# 72skill — 七兔的技能与工具集

跨 Agent 通用的技能（SKILL）与工具。这里放「**不挑 Agent**」的东西——任何能读 Markdown、能跑命令的 AI Agent 都能用，不限某个客户端。

## 🔄 skill-sync — 跨 Agent 技能库同步 CLI

一套技能库，多处 Agent 共用。改一处，处处同步。

- 零第三方依赖（纯 Python 标准库），Windows / macOS / Linux 全支持
- 预置 11 种主流 Agent 的技能库位置（Claude Code / Codex / Cursor / Windsurf / Cline / WorkBuddy / CodeBuddy / DeepSeek Harness…），探测不到的 `add` 一行登记
- 安全底线写死：**mtime 新者胜、绝不删除、冲突只报告不覆盖**
- 详细用法：[skill-sync/README.md](skill-sync/README.md)
- Agent 集成：把 `skill-sync/skills/skills-sync/SKILL.md` 装进任意 Agent 的技能库，之后对它说「同步技能库」即可——这个同步技能本身，也由这套工具同步

```bash
git clone https://cnb.cool/72boom/72skill.git && cd 72skill/skill-sync
python -m skill_sync discover   # 数据收集：探测本机 Agent 技能库
skill-sync status               # 只读报告：一致 / 缺失 / 冲突
skill-sync sync --dry-run && skill-sync sync
```

## 📄 License

[MIT](LICENSE) © 2026 72boom
