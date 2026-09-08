# dsh-memory — DSH 分层记忆体系（异地灾备快照）

> 本目录是 `D:\aolong\.dsh-memory` 的**异地灾备快照**，随收工推送覆盖更新。
> 活版本永远以本地 `D:\aolong\.dsh-memory` 为准；两边冲突时，以本地较新者为准。

## 这是什么

一套「LLM 长线任务记忆体系」：三层记忆（STATE 常驻 + archive 按需 + 会话日志无损底账）+ 平台内置压缩兜底，目标是同一窗口无限延续长线项目——上下文水位受控（<80% 收口）、历史细节可精确溯源（≤2 次检索）、续接质量不衰减。

## 文件清单

| 文件 | 作用 |
|---|---|
| `PROTOCOL.md` | 行为协议权威版（会话开始读 STATE / 里程碑归档 / 80% 收口 / tmpdir 治理 / 尺寸纪律 / 体检） |
| `STATE.md` | 常驻状态：目标 / 进度 / 下一步 / 决策约束 / 待办 / 索引（**推送时点快照**） |
| `BOOTSTRAP.md` | **灾备入口**：自包含重建说明书（机制/架构/绝对路径/模板/决策日志） |
| `verify.ps1` | 一键体检：核心文件 / STATE 预算 / 索引引用 / contextWindow 配置 / tmpdir 三态清点 |
| `archive/` | 里程碑归档（每份一个主题的详情） |

## 灾难恢复（文件遗失 / 换终端 / 换 Agent）

1. `git clone https://cnb.cool/72boom/72skill.git`
2. 把 `dsh-memory/` 整目录拷回 `D:\aolong\.dsh-memory`
3. 运行 `verify.ps1`，全 PASS 即恢复完成
4. 更复杂的重建（底账也没了）照 `BOOTSTRAP.md` §6 执行，或把 `BOOTSTRAP.md` 整份发给任意 LLM 说「按此文档 §6 重建」

## 更新约定

- 收工推送（cnb-push 流程）时，用本地最新 `.dsh-memory` **整目录覆盖**本目录并提交
- `archive/` 只增不改；`STATE.md` 覆盖即最新
