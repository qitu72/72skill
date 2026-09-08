# STATE — D:\aolong 项目群

> ⚠️ 执行前先读：`D:\aolong\.dsh-memory\PROTOCOL.md`
> 无损底账：各窗口按自己工作区落盘（`~/.dsh/sessions/--D-aolong--/`、`--D-aolong-72--/`、`--D-aolong-Products--/`…）+ Web「轨迹」标签页

## 目标

- **项目自治原则（2026-09-06 拍板）**：各项目进度以其自己窗口的状态文件为单一真相源（如三星堆 = `03-works/sanxingdui/总监制.md`）；本 STATE **不重复记账项目进度**，防双源漂移
- 本窗口（72 知识库窗口）职责：知识库治理（inbox / hubs / 入库，按用户当场指令）+ 记忆基础设施维护（本体系）
- 基础设施：长线窗口上下文治理（分层记忆协议，本文件即产物）
- 子工作区：`D:\aolong\72` = 知识库（Obsidian vault：00-moc / hubs / 01-classics / 02-methods / 03-works / 04-products，红线：不放无关内容）；`D:\aolong\72\03-works\sanxingdui` = 三星堆小说（**自治**，状态源=总监制.md，勿代管）；`D:\aolong\Products` 等（清单待补全）

## 当前进度

- 2026-09-06 体系上线：上下文根因修复（zai/glm-5.3-flash 补 `contextWindow: 1000000`）＋分层记忆协议落地＋记忆根迁至 `D:\aolong\.dsh-memory`＋洁癖清场 25 项＋`D:\aolong\AGENTS.md` 域五·二 落协议指针（备份 `.bak-20260906`）→ 细见 `archive/2026-09-06-上下文管理方案.md`、`archive/2026-09-06-洁癖同步.md`
- 2026-09-06 身份拍板：Agent＝**思思**，人格以 SOUL.md 为准，模型只是可换"大脑"；AGENTS/SOUL 修订（备份日期笔误 `.bak-20260212`）；并发编辑有身份漂移风险需定期抽查 → 细见 `archive/2026-09-06-身份修正.md`
- 2026-09-07 基建三连（思思）：① 72-daoyuan SKILL 五份同步修复（WorkBuddy 两次漏 .dsh 腿，现存全份 md5=0044abe6）；② 对话框贴图 Ctrl+V 兜底补丁固化五层并端到端实测通过；③ skill-sync 迁仓 `cnb.cool/72boom/72skill`（本地 `D:\aolong\repos\72skill`）→ 细见 `archive/2026-09-07-贴图修复与SKILL同步.md` §A-§G
- 2026-09-07 晚-深夜（思思）：对话框 P7-P9 增强（拖拽调高 / Ctrl+Enter 换行）经 MR#2/#3 并入 dsh-plugins main=3d52c6d；cnb-push SKILL 三端升级＋`cnb-repo-daily-sync` automation（10:00 巡检，现暂停中）；AutoClaw 卸载闭环（4.2GB 清退＋python 换装 `tools/runtime/python312`＋AGENTS/TOOLS 清污）→ 细见同 archive §I-§K
- 2026-09-08 收口（本窗口）：PROTOCOL 增补 tmpdir 治理＋STATE 尺寸纪律（三.6/三.7）；`verify.ps1` 一键体检上线；11 个 tmpdir 核验清扫（sanxingdui/reviews 10 + voiceprints 1，正式文件全在、龄 55h）；体系打包推送 `cnb.cool/72boom/72skill`（feat/dsh-memory-system）→ 本条即收口压缩样例，9/6-9/7 长条目细节全在 archive

## 下一步

1. 各项目按其窗口自治推进（三星堆=总监制.md；本 STATE 不记项目进度）
2. 仪表 ~80% 触发收口（PROTOCOL 三.3）
3. 归档员观察期（1-2 周）：archive 漏写再叠

## 关键决策与约束

- 用户偏好：同一窗口延续一个项目，尽量不开新窗口
- 项目进度单一真相源在各项目自己的状态文件（三星堆=总监制.md）；STATE.md 只记基础设施与跨窗口协调，不重复记账，不设时限（2026-09-06 拍板）
- 定时 automation「归档员」：**暂不叠加**（2026-09-06 拍板）。观察期 1-2 周，若发现 archive 漏写再叠（daily 22:00，任务书限定只写 `.dsh-memory`）
- 水位纪律：常驻 <80%；收口后 ≤20%
- zai/glm-5.3-flash 的 `contextWindow: 1000000` 为手工配置——若日后在「设置→模型」页重写该条目，需复查此字段仍在
- 72 知识库红线：记忆与无关文件不入 72；记忆根固定 `D:\aolong\.dsh-memory`（不入 git，各子仓库 .gitignore 无需为记忆改动）
- 会话日志 = 无损底账：任何压缩/遮蔽都不删除原始事件（轨迹可查）

## 未完成事项

- [ ] 归档员观察期 1-2 周（archive 漏写则叠）
- [ ] `dsh-schedule` 结算 bug（面板红标误报，实质工作不受影响）待维护窗口修（引自 9/7 深夜）

## 索引

- `BOOTSTRAP.md` — 灾备重建说明书（自包含：机制/架构/路径/模板/决策日志）
- `verify.ps1` — 一键体检（收口后 / 重建后运行；含 tmpdir 三态清点）
- `archive/2026-09-06-上下文管理方案.md` — 根因分析、方案对比、目标定义、决策与迁移全记录
- `archive/2026-09-06-洁癖同步.md` — 六事实面核验、残留清点、清场与提案落地全记录
- `archive/2026-09-06-身份修正.md` — Agent 身份=思思的拍板记录、AGENTS/SOUL 修订明细与漂移风险
- `archive/2026-09-07-贴图修复与SKILL同步.md` — SKILL 副本同步修复 + 贴图 Ctrl+V 补丁 + skill-sync 迁仓 + 对话框增强 + AutoClaw 清退（§A-§K）
- `~/.dsh/sessions/--D-aolong--/` — D:\aolong 主窗口底账（如有）
- `~/.dsh/sessions/--D-aolong-72--/` — 本窗口（72）底账
