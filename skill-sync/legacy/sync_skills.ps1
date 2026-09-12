# sync_skills.ps1 v2 - N-way skill library sync (hub-and-spoke).
#
#   canonical (edit here) <-> leg1, leg2, ... legN   (bidirectional, newer mtime wins)
#
# Legs come from sync_skills.json next to this script (optional):
#   { "canonical": "~/.workbuddy/skills",        # omit = default below
#     "legs": ["~/.dsh/skills", "~/.codebuddy/skills"],
#     "autoDiscover": false }                     # report unmanaged <home>/.*/skills but do not touch
# Missing config = legacy behaviour: canonical ~/.workbuddy/skills,
# legs ~/.dsh/skills + ~/.codebuddy/skills. Any number of legs works.
#
# Version rule (Owner-confirmed 2026-08-14): the copy with the NEWER mtime wins
# (robocopy /XO). Nothing is ever deleted (/E, never /MIR).
#
# v2 changes (2026-09-12):
#   - legs are configurable: add a new agent by adding one line to the JSON.
#   - hub-and-spoke instead of C(N,2) pairwise: canonical <-> each leg.
#   - PRE-SYNC hash snapshot: a skill whose SKILL.md differs across ends is
#     reported BEFORE files change; if the differing copies also have (nearly)
#     equal mtimes, robocopy would ping-pong forever - abort with exit 2 and
#     let a human decide. This fixes the old post-sync conflict check that
#     could never fire (after /XO the ends are already equal).
#   - OVERWRITTEN report: after sync, list exactly which skill was overwritten
#     on which end by which end (mtime-newer wins), so a silent loss becomes a
#     visible line in the output.
#   - stats bugfix: every robocopy run now counts (v1 counted only the 2nd of
#     each pair).
# Keep this script ASCII-only for Windows PowerShell 5.1.

param([switch]$DryRun)

$ErrorActionPreference = 'Stop'
$homeDir = $env:USERPROFILE
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$cfgPath = Join-Path $scriptDir 'sync_skills.json'

# ---- 1. resolve canonical + legs (config file > defaults) ----
$canonical = Join-Path $homeDir '.workbuddy\skills'
$legs = @((Join-Path $homeDir '.dsh\skills'), (Join-Path $homeDir '.codebuddy\skills'))
$autoDiscover = $false
$cfgLoaded = $false
if (Test-Path $cfgPath) {
    try {
        $cfg = Get-Content $cfgPath -Raw | ConvertFrom-Json
        if ($cfg.canonical) { $canonical = $cfg.canonical }
        if ($cfg.legs) { $legs = @($cfg.legs) }
        if ($null -ne $cfg.autoDiscover) { $autoDiscover = [bool]$cfg.autoDiscover }
        $cfgLoaded = $true
    } catch {
        Write-Warning "config parse failed ($cfgPath) - falling back to defaults"
    }
}

function Resolve-Leg([string]$p) {
    if ($p -eq '~') { return $homeDir }
    if ($p.StartsWith('~')) { return Join-Path $homeDir $p.Substring(1) }
    if (-not [System.IO.Path]::IsPathRooted($p)) { return Join-Path $scriptDir $p }   # relative to the config's folder
    return $p
}
$canonical = [System.IO.Path]::GetFullPath((Resolve-Leg $canonical))
$norm = New-Object System.Collections.Generic.List[string]
foreach ($l in $legs) {
    $full = [System.IO.Path]::GetFullPath((Resolve-Leg $l))
    if ($full -eq $canonical) { continue }              # canonical itself is not a leg
    if (-not $norm.Contains($full)) { $norm.Add($full) }
}
$legs = $norm

Write-Host "skills-sync v2: canonical=$canonical"
Write-Host ("                legs(" + $legs.Count + ")=" + (($legs | ForEach-Object { $_.replace($homeDir,'~') }) -join ', ') + "  config=$cfgLoaded  dryrun=$DryRun")

# autoDiscover is ADVISORY ONLY (never auto-joins a library - that would flood
# a new agent's own library with 100+ skills on first run):
if ($autoDiscover) {
    $found = Get-ChildItem $homeDir -Directory -Force -ErrorAction SilentlyContinue |
        Where-Object { $_.Name.StartsWith('.') } |
        Where-Object { Test-Path (Join-Path $_.FullName 'skills') }
    foreach ($f in $found) {
        $sk = (Join-Path $f.FullName 'skills')
        if ($sk -ne $canonical -and -not $legs.Contains($sk)) {
            Write-Host ("  [discover] unmanaged library: " + $sk.replace($homeDir,'~') + "  (add it to sync_skills.json legs to join)")
        }
    }
}

# validate all roots exist
foreach ($r in @($canonical) + $legs) {
    if (-not (Test-Path $r)) { Write-Host "FATAL: library not found: $r"; exit 1 }
}

# ---- 2. pre-sync snapshot (hash of SKILL.md per end, per skill) ----
$sk = @{}
foreach ($root in @($canonical) + $legs) {
    $map = @{}
    Get-ChildItem $root -Directory -Force -ErrorAction SilentlyContinue | ForEach-Object {
        $md = Join-Path $_.FullName 'SKILL.md'
        if (-not (Test-Path $md)) { $md = Join-Path $_.FullName 'skill.md' }
        if (Test-Path $md) {
            $f = Get-Item $md
            $map[$_.Name] = @{ hash = (Get-FileHash $md -Algorithm SHA256).Hash; mtime = $f.LastWriteTimeUtc; path = $md }
        }
    }
    $sk[$root] = $map
}

# HARD conflict: same skill, differing content, mtimes within 2s on 2+ ends ->
# robocopy /XO cannot break the tie (equal times) and would ping-pong forever.
$hardConflicts = @()
$divergent = @{}   # skill -> list of ends that have it (only when hashes differ)
$allNames = @()
foreach ($m in $sk.Values) { $allNames += $m.Keys }
$allNames = $allNames | Sort-Object -Unique
foreach ($name in $allNames) {
    $present = @{}
    foreach ($root in $sk.Keys) { if ($sk[$root].Contains($name)) { $present[$root] = $sk[$root][$name] } }
    if ($present.Count -lt 2) { continue }
    $uniqHashes = @($present.Values | ForEach-Object { $_.hash } | Sort-Object -Unique)
    if ($uniqHashes.Count -le 1) { continue }
    $divergent[$name] = $present
    # pairwise near-equal mtime check
    $ends = @($present.Keys)
    for ($i = 0; $i -lt $ends.Count; $i++) {
        for ($j = $i + 1; $j -lt $ends.Count; $j++) {
            $ta = $present[$ends[$i]].mtime
            $tb = $present[$ends[$j]].mtime
            if ($present[$ends[$i]].hash -ne $present[$ends[$j]].hash -and [Math]::Abs(($ta - $tb).TotalSeconds) -lt 2) {
                $hardConflicts += "$name (" + $ends[$i].replace($homeDir,'~') + " vs " + $ends[$j].replace($homeDir,'~') + ")"
            }
        }
    }
}
if ($divergent.Count -gt 0) {
    Write-Host ""
    Write-Host ("PRE-SYNC: " + $divergent.Count + " skill(s) differ across ends (newer mtime will win):")
    $divergent.Keys | Sort-Object | ForEach-Object { Write-Host "   ~ $_" }
}
if ($hardConflicts.Count -gt 0) {
    Write-Host ""
    Write-Host "!! HARD CONFLICT (same mtime, different content - cannot auto-resolve, NOTHING was changed):"
    $hardConflicts | ForEach-Object { Write-Host "   - $_" }
    Write-Host "   fix: pick one end, delete/edit the loser copy by hand, re-run."
    exit 2
}

# ---- 3. sync: canonical <-> each leg (bidirectional, /XO newer wins) ----
$exclude = @('*.bundled-hash', '_user_meta.json', '_bm_skillid_migration.json', '_bm_skillid_migration.json.fallback.bak')
$roboArgs = @('/E', '/XO', '/XJ', '/XF') + $exclude + @('/R:1', '/W:1', '/MT:16', '/NFL', '/NDL', '/NJH', '/NJS', '/NP')
if ($DryRun) { $roboArgs += '/L' }
$totalRuns = 0
foreach ($leg in $legs) {
    if (-not $DryRun) { Write-Host "== sync: $canonical  <->  $leg ==" }
    robocopy $canonical $leg @roboArgs | Out-Null
    $c1 = $LASTEXITCODE
    robocopy $leg $canonical @roboArgs | Out-Null
    $c2 = $LASTEXITCODE
    $totalRuns += 2
    if ($c1 -ge 8 -or $c2 -ge 8) { Write-Host "ERROR robocopy on $leg (codes $c1/$c2)"; exit 1 }
}

# ---- 4. post-sync: verify + overwritten report ----
$overwritten = @()
foreach ($name in $divergent.Keys) {
    $present = $divergent[$name]
    # winner = newest mtime among pre-sync copies
    $winnerEnd = $null; $winnerM = [datetime]::MinValue
    foreach ($root in $present.Keys) {
        if ($present[$root].mtime -gt $winnerM) { $winnerM = $present[$root].mtime; $winnerEnd = $root }
    }
    $postHash = $null
    foreach ($root in $present.Keys) {
        $md = $present[$root].path
        if (Test-Path $md) {
            $h = (Get-FileHash $md -Algorithm SHA256).Hash
            if ($h -ne $present[$root].hash) {
                $loser = $root.replace($homeDir, '~')
                $overwritten += "$name : $loser was overwritten by $(($winnerEnd.replace($homeDir,'~')))"
            }
        }
    }
}

# final consistency: every end must agree on every shared skill
$finalDiff = @()
foreach ($name in $allNames) {
    $hashes = @()
    foreach ($root in $sk.Keys) {
        $md = Join-Path $root "$name\SKILL.md"
        if (-not (Test-Path $md)) { $md = Join-Path $root "$name\skill.md" }
        if (Test-Path $md) { $hashes += (Get-FileHash $md -Algorithm SHA256).Hash }
    }
    $uniq = $hashes | Sort-Object -Unique
    if ($hashes.Count -ge 2 -and $uniq.Count -gt 1) { $finalDiff += $name }
}

Write-Host ""
if ($finalDiff.Count -gt 0) {
    Write-Host "!! CONFLICT: still differing after sync (review manually):"
    $finalDiff | ForEach-Object { Write-Host "   - $_" }
} else {
    Write-Host "CONFLICT CHECK: all ends consistent OK"
}
if ($overwritten.Count -gt 0) {
    Write-Host ("OVERWRITTEN (newer mtime won - the loser edits are gone): " + $overwritten.Count)
    $overwritten | ForEach-Object { Write-Host "   - $_" }
}
$perEnd = foreach ($root in $sk.Keys) {
    $n = (Get-ChildItem $root -Directory -Force -ErrorAction SilentlyContinue |
        Where-Object { (Test-Path (Join-Path $_.FullName 'SKILL.md')) -or (Test-Path (Join-Path $_.FullName 'skill.md')) }).Count
    "$($root.replace($homeDir,'~'))=$n"
}
Write-Host ("per-end skills: " + ($perEnd -join '  '))
Write-Host ("ALL SKILL SYNC DONE (legs=" + $legs.Count + ", robocopy runs=$totalRuns, dryrun=$DryRun)")
