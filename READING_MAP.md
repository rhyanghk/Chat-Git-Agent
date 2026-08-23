# Reading Map

**不要通读全仓。** 默认上下文成本必须与当前任务规模相关。

## 层级

- L0：AGENTS.md 或当前控制角色的最小项目指令。
- L1：当前角色、当前编号任务、任务指定项目文件。
- L2：场景触发的启动、接口、GitHub 中继、恢复、交接、编号和平台资料。
- L3：历史、案例、被替代材料。

## 角色 / 场景

| 角色或场景 | 默认读取 | 按需读取 | 默认不读 |
| --- | --- | --- | --- |
| Human（真实授权者） | START_HERE.md、INSTALL.md | 00_CHAT_CONTROL/ROLES/HUMAN.md、控制资料 | Agent Skill、无关业务仓库 |
| Global Architect | CONSTITUTION.md、READING_MAP.md、NAMESPACE.md、00_CHAT_CONTROL/ROLES/GLOBAL_ARCHITECT.md | Workspace Bootstrap、控制资料、明确依赖 | 所有项目代码和全历史 |
| Project Architect | CONSTITUTION.md、任务与项目约束、00_CHAT_CONTROL/ROLES/PROJECT_ARCHITECT.md | AGENT_INTERFACE、控制记录、GitHub 中继 | 其他项目与完整 Agent Skill |
| Builder / Research / Repair / Verifier / Runner / Release | AGENTS.md、当前任务、角色规则 | 60_AGENT_SKILL 参考、Bootstrap、项目文件、GitHub Relay | 完整 Constitution、Chat 控制资料、其他任务 |
| 首次使用 Chat 平台 | START_HERE.md、INSTALL.md、00_CHAT_CONTROL/PROJECT_INSTRUCTIONS.md | 对应 PLATFORM_ADAPTER | Agent Skill 全文 |
| 首次安装执行 Skill | INSTALL.md、60_AGENT_SKILL/agent-executor/SKILL.md | 当前平台官方资料 | Chat 控制项目全文、业务仓库 |
| github_relay | AGENTS.md、当前任务、30_PROTOCOLS/GITHUB_RELAY_PROTOCOL.md | 项目 Git 事实、任务指定输入 | 无关仓库/历史 |
| handoff / recovery | 当前角色 L0、当前任务 | docs/SESSION_LIFECYCLE.md | 全量历史 |
| Incident | AGENTS.md、当前任务 | 相关 L2 资料 | 无关材料 |

新增文档默认属于 L2/L3，除非本表明确提升。
