# Chat-Git-Agent Namespace

本文件是目录入口，不是第二套 L0 规则。实际执行规则以 AGENTS.md、当前角色规则和精确任务为准。

~~~text
00_CHAT_CONTROL / 00_KERNEL
            ↓
10_BOOT
            ↓
20_ROLES
            ↓
30_PROTOCOLS
            ↓
40_GUIDES
            ↓
50_TEMPLATES
            ↓
60_AGENT_SKILL
            ↓
90_HISTORY
~~~

| 层 | 职责 |
| --- | --- |
| 00_CHAT_CONTROL | Chat 项目指令、Chat 侧角色、数据源与平台适配；不进入执行 Skill。 |
| 00_KERNEL | 宪法、机器 L0、语言政策与公共入口。 |
| 10_BOOT | Bootstrap、workspace 注册、恢复入口。 |
| 20_ROLES | 原始角色集的职责与权限边界。 |
| 30_PROTOCOLS | 编号、任务接口、控制记录、GitHub 中继、项目仓边界。 |
| 40_GUIDES | 冷启动和用户可见指南。 |
| 50_TEMPLATES | 编号化任务、报告、变更、交接与启动模板。 |
| 60_AGENT_SKILL | 可安装的纯执行 Agent Skill。 |
| 90_HISTORY | 历史与被替代材料，默认不进入执行上下文。 |

命名空间是逻辑分层，不要求业务项目复制这些文件。