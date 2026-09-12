# skill-sync

> 一套技能库，多处 AI Agent 共用。改一处，处处同步。
> Keep **one** skill library in sync across **many** AI agents.

[![Python 3.8+](https://img.shields.io/badge/python-3.8%2B-blue)](https://www.python.org/)
[![No dependencies](https://img.shields.io/badge/dependencies-none-brightgreen)]()
[![License: MIT](https://img.shields.io/badge/license-MIT-green)](LICENSE)

---

## 为什么需要它 / Why

现在同时用多个 AI Agent 是常态：Claude Code、Codex、WorkBuddy、CodeBuddy、Cursor……**每个 Agent 各自维护一份自己的 skill 目录**。
于是同一个 `SKILL.md` 在你的机器上存在 N 份副本。改了其中一份，其他几份不会自动跟着变——时间一长，各端的技能版本开始漂移，你会遇到：
- 在 A 客户端修好的技能，到 B 客户端还是旧版
- 同名 `SKILL.md` 内容不一致，却没人知道该信哪份
- 手工复制粘贴，迟早漏掉一个

`skill-sync` 把这件事变成一条命令。

**设计前提：每个人的 Agent 组合都不一样。** 所以本工具**不硬编码任何路径**——它先做一次「数据收集」（`discover`）探测你机器上真实存在的 Agent 技能库，把结果存进注册表，之后所有同步按注册表走。

---

## 安装 / Install

零第三方依赖，标准库即可运行。
```bash
# 方式一：不安装，直接跑（推荐先试这个）
git clone https://cnb.cool/72boom/72skill.git && cd 72skill/skill-sync
python -m skill_sync discover

# 方式二：安装后用命令
pip install .
skill-sync discover
```

> Windows 用户也可用 `py -m skill_sync`。
---

## 快速开始 / Quick start

```bash
# 1. 数据收集：探测本机有哪些 Agent 技能库（交互式勾选）
skill-sync discover

# 2. 看看各端漂移情况（只读，不改动任何文件）
skill-sync status

# 3. 同步
skill-sync sync --dry-run    # 先干跑，看会改什么
skill-sync sync              # 确认无误后真跑
```

`discover` 会扫描已知 Agent 的常见位置，例如：
| Agent | 默认路径 |
|---|---|
| WorkBuddy | `~/.workbuddy/skills` |
| CodeBuddy | `~/.codebuddy/skills` |
| DeepSeek Harness | `~/.dsh/skills` |
| Claude Code | `~/.claude/skills` |
| Codex CLI | `~/.codex/skills` |
| Gemini CLI | `~/.gemini/skills` |
| Cursor | `~/.cursor/skills` |
| Windsurf | `~/.windsurf/skills` |
| Cline | `~/.cline/skills` |
| Roo Code | `~/.roo/skills` |
| OpenClaw（旧名）/ AutoClaw | `~/.openclaw/skills`、`~/.openclaw-autoclaw/skills` |

探测不到的？手动登记即可：
```bash
skill-sync add ~/some/agent/skills --name "My Agent"
```

---

## 命令 / Commands

| 命令 | 作用 |
|---|---|
| `discover` | **数据收集**：扫描本机已知 Agent 技能库，交互式确认后写入注册表 |
| `list` | 列出已登记的库及其技能数量 |
| `status` | 只读报告：哪些技能一致 / 缺失 / 内容冲突 |
| `sync` | 双向增量同步（mtime 新者胜） |
| `sync --dry-run` | 干跑，只看会改什么 |
| `sync --hub <id>` | **hub-and-spoke**：以指定库为中枢与其余各库两两同步，N 端只需 N-1 对 |
| `sync --from <id>` | 单向：以指定库为准强制覆盖其他库（会先备份） |
| `add <path>` | 手动登记一个技能库 |
| `remove <key>` | 从注册表移除（只移除登记，不删文件） |

注册表位置：`~/.skill-sync/registry.json`（可直接编辑，也可用 `SKILL_SYNC_HOME` 环境变量改位置）。

---

## 同步规则 / Rules

这几条是刻意设计的，也是本工具的安全底线：
1. **mtime 新者胜** —— 双向增量同步，修改时间更新的版本覆盖旧的。不做内容合并。
2. **绝不删除** —— 只存在于某一端的技能会原样保留。这就是为什么我们不提供 `--mirror`：各 Agent 本来就有自己独有的技能，静默删除是灾难。
3. **双端编辑透明化（v0.2.0 新增）** —— 同一个文件在两端都有实质编辑（大小不同）时，新者胜照常执行，但会打印 `OVERWRITTEN` 报告，**精确指出哪一端的哪个文件被哪一端覆盖**，不再静默丢失。
4. **歧义绝不覆盖** —— mtime 相同但内容不同（或 `--deep` 哈希不符）的文件：**只报告、不覆盖**，交给你人工裁决。
5. **跳过客户端元数据** —— `*.bundled-hash`、`_user_meta.json`、`_bm_skillid_migration.json*`、`.DS_Store`、`__pycache__` 等不参与同步，避免互相污染各客户端的启用状态。
6. **不跟随符号链接 / junction** —— 有些 Agent 会用 junction 互相指向，跟随会造成无限遍历或重复写入，一律跳过。

`--from` 单向模式是*唯一会覆盖较新文件*的模式，因此它会先把被替换的文件存为 `.bak-skillsync-<时间戳>`，确保可回退。

---

## 让 Agent 自己调用 / Agent integration

`skills/skills-sync/SKILL.md` 是一个现成的技能定义，装进你的 Agent 技能库后，直接对 Agent 说「同步技能库」即可触发。
```bash
# 把技能定义放进某个 Agent（然后 sync 一次，它就自动分发到所有端）
mkdir -p ~/.claude/skills/skills-sync
cp skills/skills-sync/SKILL.md ~/.claude/skills/skills-sync/
skill-sync sync
```

有点自举的味道：这个同步技能本身，也由这套工具同步。

---

## 新增一个 Agent / Contributing an agent

如果你用的 Agent 不在上面的表里，有两种方式：

**1. 本地扩展（无需改代码）** —— 编辑 `data/known_agents.json`：
```json
{
  "agents": [
    { "id": "my-agent", "name": "My Agent", "path": "{home}/.my-agent/skills" }
  ]
}
```

**2. 提 PR** —— 直接往 `skill_sync/agents.py` 的 `KNOWN_AGENTS` 加一行，让所有人受益。
`path` 支持占位符：`{home}`（用户主目录）、`{cwd}`（当前目录）。

---

## Windows PowerShell 免 Python 版 / legacy

`legacy/sync_skills.ps1` 是一个不依赖 Python 的 PowerShell 实现（v0.2.0 与 Python 版语义对齐）：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "$env:USERPROFILE\scripts\sync_skills.ps1"
```

- 技能库列表来自同目录的 `sync_skills.json`（示例见 `legacy/sync_skills.json.example`）——**加一个 Agent = 加一行路径**；没有配置文件时默认三库拓扑（`~/.dsh` `~/.codebuddy` `~/.workbuddy`）。
- 同步前快照：先列出跨端有差异的技能；mtime 相同且内容不同 → `HARD CONFLICT` 原地停手（exit 2），什么文件都不碰。
- `OVERWRITTEN` 透明报告与 Python 版同语义。

---

## 平台支持 / Platforms

| 平台 | 支持 | 说明 |
|---|---|---|
| Windows | ✅ | 已处理 junction 与盘符路径 |
| macOS | ✅ | |
| Linux | ✅ | |
| iOS / Android | ❌ | 移动端沙盒里 App 之间目录互不可见，也没有常规终端，无法做跨 App 目录同步 |

---

## 安全 / Safety

- 默认**只增不删**；唯一会覆盖的是「同一文件、对端更新」的情况——v0.2.0 起会打印 `OVERWRITTEN` 报告。
- 冲突一律报告，不自动裁决。
- `--from` 是唯一强制模式，会自动备份被替换文件。
- 建议首次使用先跑 `status` 和 `sync --dry-run`，看清会发生什么再真跑。
- 技能库里如果有你的私密内容，注意同步会把它在多个客户端之间摊平。

---

## 更新日志 / Changelog

### v0.2.0 (2026-09-12)
- `sync --hub <id>`：hub-and-spoke 拓扑——以一个库为中枢与其余各库同步，N 端从 N*(N-1)/2 对降为 N-1 对；任何一端的更新两步内传遍全网。
- `OVERWRITTEN` 透明报告：双端都编辑过同一文件时，精确列出哪一端的文件被哪一端覆盖（旧版静默丢失）。
- 冲突语义修正：quick 指纹（size+mtime）下「同 mtime 不同 size」不再被误当覆盖，而是作为冲突报告、文件不动。
- `skills/skills-sync/SKILL.md` 重写：N 端模型、新 Agent 接入指引、v2 输出语义。
- `legacy/sync_skills.ps1` 升级至与 Python 版同语义（配置化多库 + 同步前快照 + HARD CONFLICT 停手 + OVERWRITTEN 报告），并附 `sync_skills.json.example`。

### v0.1.0 (2026-09-07)
- 首版：discover / status / sync / --from / --dry-run / --deep，注册表持久化，11+ Agent 预置目录表，JSON 扩展目录。

---

## 许可 / License

MIT —— 见 [LICENSE](LICENSE)。
