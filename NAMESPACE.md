# Chat-Git-Agent Namespace

本文件只说明当前项目实际目录；它不是第二套执行规则。执行规则以 [AGENTS.md](AGENTS.md)、当前角色规则和精确任务为准。

| 位置 | 当前职责 | 默认何时读取 |
| --- | --- | --- |
| `00_CHAT_CONTROL/` | Chat 控制项目指令、控制角色和平台适配 | 建立或运行 Chat 控制项目时 |
| `00_KERNEL/` | 语言政策与稳定治理入口 | 需要稳定规则或输出规范时 |
| `10_BOOT/` | Bootstrap Check 和 Workspace Bootstrap | 首次搭建、启动、恢复、交接时 |
| `20_ROLES/` | 六个执行角色的职责边界 | 创建或执行编号任务时 |
| `30_PROTOCOLS/` | 编号、正式记录、业务仓边界、GitHub 中继 | 任务、变更、证据或 GitHub 中继时 |
| `40_GUIDES/` | 面向陌生使用者的冷启动验证 | 验证安装或首次使用路径时 |
| `50_TEMPLATES/` | Chat、任务、报告、变更、交接的正式模板 | 需要创建正式记录时 |
| `60_AGENT_SKILL/agent-executor/` | 唯一执行型 Skill | 独立 Agent 收到任务时 |
| `60_AGENT_SKILL/packages/` | 当前 Skill 的分发包 | 支持 `.skill` 包的平台安装时 |
| `60_AGENT_SKILL/scripts/` | 当前 Skill 的安装与打包器 | 本地安装或重新打包时 |
| `docs/` | Agent 接口、渐进上下文与会话生命周期 | 场景需要时 |

不存在要求业务项目复制这些目录的隐含规则。业务项目只保存其项目特有的代码、约束、任务、报告和证据。
