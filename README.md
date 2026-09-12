<div align="center">

# 🎒 72skill

**跨 Agent 通用的技能与记忆基建**

技能一处同步 · 长线记忆一套延续

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
![Python: 3.8+](https://img.shields.io/badge/python-3.8%2B-blue)
![Dependencies: none](https://img.shields.io/badge/dependencies-none-brightgreen)
![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)

**[🔄 skill-sync](#1--skill-sync--一套技能库多处-agent-共用) · [🧠 dsh-memory](#2--dsh-memory--让长线项目同一窗口无限延续)**

</div>

---

这里放「**不挑 Agent**」的东西——任何能读 Markdown、能跑命令的 AI Agent（Claude Code / Codex / Cursor / WorkBuddy / CodeBuddy / DeepSeek Harness…）都能用，不限某个客户端。

## 😩 是不是也遇到过

- 同时养着好几个 Agent，**每个都维护一份自己的技能库**。同一个 `SKILL.md` 在机器上存了 N 份，改了其中一份，其他几份悄无声息地变成旧版——直到你在 B 端用上三天前在 A 端修好的技能。
- 和 AI 的长对话**上下文动不动爆满**：开新窗口 = 项目失忆，从头交代一遍；硬撑着不清理 = 后半段质量崩坏。想要「细节不丢、还能接着干」，全靠人肉搬运。
- 换台电脑、换个终端，想让任何一个 AI **接手你的工作方式和项目状态**，却发现「怎么带它入门」全凭嘴说，说漏一句它就踩坑。

这个仓库两件套，一件管技能，一件管记忆。

---

## 🧩 两大件

### 1 · 🔄 `skill-sync` — 一套技能库，多处 Agent 共用

改一处，处处同步。零第三方依赖（纯 Python 标准库），Windows / macOS / Linux 全支持。

- 🗺️ **预置 11 种主流 Agent 的技能库位置**（WorkBuddy / CodeBuddy / DeepSeek Harness / Claude Code / Codex / Gemini CLI / Cursor / Windsurf / Cline / Roo Code / OpenClaw），探测不到的 `add` 一行登记，或往 `data/known_agents.json` 加一条
- 🛡️ **安全底线写死**：`mtime 新者胜` 双向增量、**绝不删除**（只存在于一端的技能原样保留）、同名冲突**只报告不覆盖**
- 🔀 **hub-and-spoke 拓扑（v0.2.0）**：`sync --hub <id>` 以一个库为中枢与其余各库同步，N 端只需 N-1 对——接的 Agent 越多越省
- 🧯 `--from` 单向强推是唯一覆盖模式，被替换文件自动存 `.bak-skillsync-<时间戳>`，可回退；双端编辑覆盖时打印 `OVERWRITTEN` 报告，不再静默丢失
- 🤖 **Agent 自集成**：把 `skills/skills-sync/SKILL.md` 装进任意 Agent 的技能库，之后对它说「同步技能库」即可——这个同步技能本身，也由这套工具同步

```bash
git clone https://cnb.cool/72boom/72skill.git && cd 72skill/skill-sync
python -m skill_sync discover   # 数据收集：探测本机 Agent 技能库（交互式勾选）
skill-sync status               # 只读报告：一致 / 缺失 / 冲突
skill-sync sync --dry-run && skill-sync sync
```

> 适合：同时养着多个 Agent、一套技能到处要用的玩家。命令全表与同步规则见 [skill-sync/README.md](skill-sync/README.md)。

### 2 · 🧠 `dsh-memory` — 让长线项目「同一窗口无限延续」的记忆体系

三层记忆 + 平台内置压缩兜底：上下文水位受控（<80% 自动收口）、历史细节可精确溯源（≤2 次检索）、续接质量不衰减。

| 层 | 是什么 | 预算 |
|---|---|---|
| 🏠 **常驻层** `STATE.md` | 目标 / 进度 / 下一步 / 决策约束 / 索引——每次会话开始必读 | ≤3K token |
| 📦 **按需层** `archive/` | 里程碑详情，谁需要谁被读 | 每份 ≤5K token |
| 🗄️ **底账层** 会话日志 | 平台自带的逐事件无损落盘，压缩不删、永不重写 | 零成本 |

- 📉 **80% 收口流程**：触线自动压缩（DSH 内置）/ 手动 `/compact`，把最旧历史折叠成摘要检查点，近期尾部逐字保留
- 🧹 **残留治理成文**：并发多窗口的原子写残渣（tmpdir）有判定规则——在途不动、清扫前逐个核验正式文件、一律回收站
- 🩺 **`verify.ps1` 一键体检**：核心文件 / STATE 尺寸 / 索引引用 / 模型窗口配置 / tmpdir 三态清点，全 PASS 才算收口完成
- 🚑 **`BOOTSTRAP.md` 灾备入口**：自包含重建说明书——换终端、换 Agent、甚至文件全丢，把这一份发给任意 LLM 说「按 §6 重建」就能原地立起来；换平台只换两处配置，其余全部照搬
- ☁️ **异地快照就是本仓库**：`dsh-memory/` 目录随收工推送覆盖更新，本地那份是活版本

> 适合：喜欢在同一个窗口把一个项目从第一天干到收尾、不想每次都给 AI「补课」的人。机制与重建全流程见 [dsh-memory/BOOTSTRAP.md](dsh-memory/BOOTSTRAP.md)。

---

## 🚀 快速开始

```bash
git clone https://cnb.cool/72boom/72skill.git
cd 72skill

# 技能同步：三行跑通（详见 skill-sync/README.md）
cd skill-sync && python -m skill_sync discover && cd ..

# 记忆体系：整目录拷走即用（详见 dsh-memory/BOOTSTRAP.md）
# Copy-Item dsh-memory "$env:USERPROFILE\.dsh\memory-template" -Recurse
```

## ❓ FAQ

<details>
<summary><b>skill-sync 会删掉我的技能吗？</b></summary>

不会。**只增不删**是写死的设计：只存在于一端的技能原样保留（所以不提供 `--mirror`）。唯一会覆盖的是「同一文件、对端更新」的 mtime 新者胜；`--from` 强推模式也会先备份被替换文件。
</details>

<details>
<summary><b>我的 Agent 不在预置列表里？</b></summary>

`skill-sync add <路径> --name "My Agent"` 立即登记；或编辑 `skill-sync/data/known_agents.json` 加一条（支持 `{home}` 占位符）；欢迎直接 PR 到 `KNOWN_AGENTS` 让所有人受益。
</details>

<details>
<summary><b>dsh-memory 只能在 DeepSeek Harness 上用吗？</b></summary>

不是。三层结构、80% 触发线、检索协议、收口清单全部平台无关；换平台只需替换两处：会话日志（底账层）的实际存储路径、模型上下文窗口的声明方式。见 `dsh-memory/BOOTSTRAP.md` §9。
</details>

<details>
<summary><b>仓库里的 dsh-memory/ 和我本地那份，以谁为准？</b></summary>

**本地活版本为准**（`D:\aolong\.dsh-memory`），本目录是收工推送时覆盖更新的灾备快照。灾难恢复 = clone 本仓库 → 拷回 → 跑 `verify.ps1` 全 PASS。
</details>

<details>
<summary><b>verify.ps1 报 FAIL 怎么办？</b></summary>

按 FAIL 行修，常见两类：STATE 超过 6KB（跑一次收口压缩，细节移 archive）；索引引用断链（补文件或改索引）。tmpdir 段落是清点报告不计分——「在途勿动」的别碰，「可清」的走回收站。
</details>

## 📋 更新日志

### 2026-09-12 · skills-sync v0.2.0 + skill-hub v1.2.0（分发可用性专项）

对「技能基建」两件套各做了一次全盘排查与修复，主题都是同一句话：**别人下载后要能真正用起来**。

**🔄 skills-sync v0.2.0**（本仓库 `skill-sync/`）——全链路排查发现两个设计级缺陷并修复：

1. **双端编辑静默丢失**：mtime 新者胜的覆盖是静默发生的——你在 A 端和 B 端先后改了同一个技能，B 端的编辑会被 A 端无声覆盖，旧版文档承诺的「冲突报告」实际永不触发。现在：`OVERWRITTEN` 报告精确列出**哪个文件在哪一端被哪一端覆盖**（Python CLI 与 PowerShell 版同步修复）。
2. **多端拓扑升级 hub-and-spoke**：旧版把所有库两两配对（N 端 = N*(N-1)/2 对），Agent 越多趟数越爆炸。新增 `sync --hub <id>`：以一个库为中枢，N-1 对搞定，任何一端的编辑两步内传遍全网。

配套更新：`skills/skills-sync/SKILL.md` 重写（N 端模型 + 新 Agent 接入指引）；`legacy/sync_skills.ps1` 升级至同语义（配置化多库 `sync_skills.json`、同步前快照、HARD CONFLICT 原地停手）；`skill-sync/README.md` 修复编码损坏并重写。14 项假库端到端测试全过。

**🧩 skill-hub v1.2.0**（姊妹仓库 [dsh-plugins](https://github.com/qitu72/dsh-plugins)——DSH 的技能中心插件，与本工具共享「一套技能多处 Agent 共用」的理念）——审计出 5 个分发断点并全部修复：

1. 只复制文件不注册 bundle → 插件永不加载（新增 `install.ps1` 一键安装，自动注册）
2. `file:` 依赖指向开发者本机且 tgz 未随仓库分发（tgz 已入库）
3. 部署脚本硬编码开发机路径（全部参数化）
4. 技能目录三库写死 → **目录自动发现**：12 种已知 Agent 静态表 + 通用 `<home>/.*/skills` 扫描，未知 Agent 也自动纳管，目录不存在不显示
5. 内存注入兜底版硬编码用户名 → 从环境解析

### 更早

- 2026-09-07 v0.1.0：skill-sync 首版 + dsh-memory 体系 + 灾备快照机制

---

## 🗺️ Roadmap

- [x] skill-sync：双端编辑覆盖透明化（v0.2.0 已交付——OVERWRITTEN 报告）
- [ ] skill-sync：冲突交互式裁决（当前只报告）
- [ ] dsh-memory：归档员 automation（观察期中，漏写才叠）
- [ ] dsh-memory：更多平台的底账路径适配文档

---


## 🤝 贡献

欢迎 Issue / PR：新 Agent 适配、文档纠错、新模块提案都算。

## 📄 License

[MIT](LICENSE) © 2026 72boom
