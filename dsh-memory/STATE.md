# STATE — D:\aolong 项目群

> ⚠️ 执行前先读：`D:\aolong\.dsh-memory\PROTOCOL.md`
> 无损底账：各窗口按自己工作区落盘（`~/.dsh/sessions/--D-aolong--/`、`--D-aolong-72--/`、`--D-aolong-Products--/`…）+ Web「轨迹」标签页

## 目标

- **项目自治原则（2026-09-06 拍板）**：各项目进度以其自己窗口的状态文件为单一真相源（如三星堆 = `03-works/sanxingdui/总监制.md`）；本 STATE **不重复记账项目进度**，防双源漂移
- 本窗口（72 知识库窗口）职责：知识库治理（inbox / hubs / 入库，按用户当场指令）+ 记忆基础设施维护（本体系）
- 基础设施：长线窗口上下文治理（分层记忆协议，本文件即产物）
- 子工作区：`D:\aolong\72` = 知识库（Obsidian vault：00-moc / hubs / 01-classics / 02-methods / 03-works / 04-products，红线：不放无关内容）；`D:\aolong\72\03-works\sanxingdui` = 三星堆小说（**自治**，状态源=总监制.md，勿代管）；`D:\aolong\Products` 等（清单待补全）

## 当前进度

> PROTOCOL 三.7 收口态：细节在 archive，此处只留日期＋一句话＋索引。

- 2026-09-06 体系上线＋身份拍板（Agent=思思）→ `archive/2026-09-06-上下文管理方案.md`、`archive/2026-09-06-洁癖同步.md`、`archive/2026-09-06-身份修正.md`
- 2026-09-07 基建三连＋对话框增强（MR#2/#3）＋AutoClaw 清退 → `archive/2026-09-07-贴图修复与SKILL同步.md`
- 2026-09-08 收口：PROTOCOL 增补＋verify.ps1＋tmpdir 清扫＋推 72skill（MR 待合并）
- 2026-09-08 晚 web(3080) 模型预设修复 → `archive/2026-09-08-web模型预设修复.md`
- 2026-09-08/09 skill-hub 三轮闭环：覆写→置顶(方案A)→引用条隐藏/行内灰底/按钮兜底→**lexicon source 正解**（@技能名灰底 pill；带点号名受核心正则限制）；MR feat/skill-hub-skill-first 待合并。companion 撞车→休眠对齐（兼容构建留档 `repos/dsh-companion-fix/`）→ `archive/2026-09-08-skillhub覆写修复.md`
- 2026-09-09 插件修复日：modlens 3.26.1＋dsh-automation 0.1.7＋companion 保持休眠＋kb automation 迁移解释器 → `archive/2026-09-09-DSH插件升级与自动化修复.md`

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
- **dsh-companion 禁止加入 bundles**（裸 ESM 客户端拼入 CJS 合包即崩 GUI，2026-09-09 撞车事故）；依赖休眠无害，等上游出 ModuleLoader 兼容客户端再议
- **动 profile / bundles / 插件前必读 `STATE.md`**（2026-09-09 撞车教训：本会话激活 companion 时未读，与 skill-hub 窗口的紧急摘除对撞）
- **思兔对话摘要维护协议**：`思兔对话_{date}_摘要.md` 由 WorkBuddy（9:10 `--skeleton` 首建，创建权独占）与 DSH（22:30 `--draft` 只追加）共管；**当日文件不存在时 DSH 绝不代建/触发 SUMMARY_CREATE**（2026-09-09 兔兔重申，prompt revision 4 已内置；协议源：memory/2026-08-09.md + MEMORY.md）

## 未完成事项

- [ ] 归档员观察期 1-2 周（archive 漏写则叠）
- [ ] `dsh-schedule` 结算 bug（面板红标误报，实质工作不受影响）待维护窗口修（引自 9/7 深夜）
- [ ] DSH 桌面端择机重启刷新模型路由（现端旧路由假活，见 9/8 晚 archive）
- [ ] 备份目录 `~/.dsh/backups/web-profile-nm-cleanup-20260908/`（230 项）观察一周无异常后清（见 9/8 晚 archive §五）；**已设 2026-09-15 12:00 automation 提醒**（`automation_a3a8e00b-abf8-469e-8eba-62f57d8e0872`，read-only，到点先核验 web 健康再问兔兔是否清，不自动删）
- [ ] 会话残留候选：A 组（tmp 日志修复产物 4 件）已兔兔确认清场（9/8 晚）；B 组（根部 fix-session/diagnose 等 10 件）兔兔选择暂不清，留待下次裁决
- [ ] 两条 kb automation（22:00 归档 / 22:30 摘要）解释器已对齐 `tools/runtime/python312`（09-07 既有约定），今晚首跑验证 `no_turn_result` 是否消失；思兔摘要 prompt 已内置维护协议（rev 5：文件缺失不代建）；dsh-automation 滚动补丁已随 0.1.7 重打（见 9/9 archive §④⑤⑥）

## 索引

- `BOOTSTRAP.md` — 灾备重建说明书（自包含：机制/架构/路径/模板/决策日志）
- `verify.ps1` — 一键体检（收口后 / 重建后运行；含 tmpdir 三态清点）
- `archive/2026-09-06-上下文管理方案.md` — 根因分析、方案对比、目标定义、决策与迁移全记录
- `archive/2026-09-06-洁癖同步.md` — 六事实面核验、残留清点、清场与提案落地全记录
- `archive/2026-09-06-身份修正.md` — Agent 身份=思思的拍板记录、AGENTS/SOUL 修订明细与漂移风险
- `archive/2026-09-07-贴图修复与SKILL同步.md` — SKILL 副本同步修复 + 贴图 Ctrl+V 补丁 + skill-sync 迁仓 + 对话框增强 + AutoClaw 清退（§A-§K）
- `~/.dsh/sessions/--D-aolong--/` — D:\aolong 主窗口底账（如有）
- `~/.dsh/sessions/--D-aolong-72--/` — 本窗口（72）底账
