# verify.ps1 — .dsh-memory 一键体检（收口后 / 重建后运行）
# 用法: powershell -NoProfile -ExecutionPolicy Bypass -File D:\aolong\.dsh-memory\verify.ps1
# 退出码: 0 = 全过；1 = 有 FAIL（明细见输出）
[Console]::OutputEncoding = [Text.Encoding]::UTF8
$ErrorActionPreference = 'Stop'
$root = 'D:\aolong\.dsh-memory'
$script:fail = 0
function Check($name, $ok, $detail = '') {
    $mark = if ($ok) { 'PASS' } else { $script:fail++; 'FAIL' }
    $line = '{0,-5} {1}' -f $mark, $name
    if ($detail) { $line += "  — $detail" }
    Write-Output $line
}
Write-Output "=== .dsh-memory 体检 $(Get-Date -Format 'yyyy-MM-dd HH:mm') ==="

# 1) 核心文件存在
foreach ($f in 'PROTOCOL.md', 'STATE.md', 'BOOTSTRAP.md', 'verify.ps1') {
    $p = Join-Path $root $f
    $len = if (Test-Path $p) { '{0:N0} B' -f (Get-Item $p).Length } else { '' }
    Check "核心文件 $f" (Test-Path $p) $len
}

# 2) STATE 尺寸纪律（≤6KB ≈ 3K token；超限就地收口压缩）
$s = Get-Item (Join-Path $root 'STATE.md')
Check 'STATE 尺寸 ≤6KB' ($s.Length -le 6KB) ('{0:N0} B（超限：细节移 archive，STATE 只留一句话+索引）' -f $s.Length)

# 3) STATE 索引引用的 archive 文件全部存在
$state = Get-Content (Join-Path $root 'STATE.md') -Raw -Encoding UTF8
$refs = [regex]::Matches($state, 'archive/[^\s`）)）】]+?\.md') | ForEach-Object { $_.Value } | Select-Object -Unique
foreach ($r in $refs) {
    Check "索引引用 $r" (Test-Path (Join-Path $root ($r -replace '/', '\')))
}

# 4) settings.yaml 关键配置在位（zai/glm-5.3-flash contextWindow=1000000）
$settings = 'C:\Users\七兔\.dsh\settings.yaml'
$raw = Get-Content $settings -Raw -Encoding UTF8
$zai = $raw -match 'zai:[\s\S]*?glm-5\.3-flash[\s\S]{0,400}?contextWindow:\s*1000000'
Check 'settings.yaml zai/glm-5.3-flash contextWindow=1000000' $zai

# 5) tmpdir 清点（在途/可清/待判断 三态）
$tmps = Get-ChildItem 'D:\aolong\72' -Recurse -Force -Directory -Filter '*.tmpdir' -ErrorAction SilentlyContinue
Write-Output "---- tmpdir 清点: $($tmps.Count) 个 ----"
$now = Get-Date
foreach ($t in $tmps) {
    $orig = $t.Name -replace '^\.','' -replace '\.\d+\.[0-9a-f\-]{36}\.tmpdir$',''
    $finalExists = Test-Path (Join-Path $t.Parent.FullName $orig)
    $ageMin = [int]($now - $t.LastWriteTime).TotalMinutes
    $verdict = if (-not $finalExists) { '待判断' } elseif ($ageMin -lt 30) { '在途勿动' } else { '可清' }
    Write-Output ('{0,-6} {1,5}min  {2}' -f $verdict, $ageMin, $t.FullName)
}

Write-Output "=== 结果: $script:fail 项 FAIL ==="
if ($script:fail -gt 0) { exit 1 } else { exit 0 }
