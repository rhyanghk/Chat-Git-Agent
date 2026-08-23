# Chat-Git-Agent

`Chat-Git-Agent` 提供两套彼此分开的运行资料：Chat 的协作控制资料，以及可独立安装的执行型 Agent Skill。它不是业务应用、数据库、任务队列或自动审批服务；业务代码、秘密、运行态和项目记录不保存在本仓。

## 第一次进入：选择你的实际入口

| 你现在要做什么 | 读取或执行 | 不要做什么 |
| --- | --- | --- |
| Human，配置 Chat 控制项目 | [INSTALL.md](INSTALL.md) 的第 2 节 | 把业务项目资料或执行 Skill 当作 Chat 的固定安装内容 |
| Chat 控制模型 | 已配置的 [PROJECT_INSTRUCTIONS.md](00_CHAT_CONTROL/PROJECT_INSTRUCTIONS.md) → [CONTROL_ROLES.md](00_CHAT_CONTROL/CONTROL_ROLES.md) 的当前角色 → 当前正式资料库的精确记录 | 自称 Human、执行代码或自行验收 |
| 执行 Agent | 已安装的 [agent-executor/SKILL.md](60_AGENT_SKILL/agent-executor/SKILL.md) → 当前编号任务 | 读取 Chat 控制资料、设计任务或接受结果 |
| Human，安装执行 Skill | [INSTALL.md](INSTALL.md) 的第 3 节 | 把 Skill 复制进业务项目仓库或 Chat 项目 |
| 维护本仓 | [AGENTS.md](AGENTS.md) → 当前任务 | 改动业务项目资料或未授权远端动作 |

## 每个保留文件如何生效

仓内不存在“仅供参考、没有消费者”的通用规则文件。每一项都有明确加载者或触发动作。

| 文件或产物 | 消费者 | 何时生效 |
| --- | --- | --- |
| `README.md` | Human | 从仓库根目录首次进入时，选择正确入口 |
| `INSTALL.md` | Human | 配置 Chat 项目或安装 Agent Skill 时 |
| `AGENTS.md` | 维护本仓的 Agent | 平台发现本仓规则，或维护任务明确指定时；不复制到业务项目 |
| `00_CHAT_CONTROL/PROJECT_INSTRUCTIONS.md` | Chat 平台 | Human 将正文放入项目指令后，每次控制会话生效 |
| `00_CHAT_CONTROL/CONTROL_ROLES.md` | Chat 控制模型 | 作为项目静态资料加载；每次控制会话先读当前角色段落 |
| `50_TEMPLATES/CHAT_PROJECT_BOOTSTRAP.md` | Human / Chat 控制模型 | 新建或恢复 Chat 控制项目时 |
| `50_TEMPLATES/TASK_RECORD.md` | Project Architect / Human | 新建任务或新 revision 时 |
| `50_TEMPLATES/RESULT_REPORT.md` | 执行 Agent | Skill 完成任务时，写唯一正式报告 |
| `50_TEMPLATES/CHANGE_REQUEST.md` | 执行 Agent、Project Architect | 合同字段必须改变时，停止当前任务并创建新 revision |
| `50_TEMPLATES/CONTROL_ROLE_HANDOFF.md` | Human、控制模型 | 交接 Global Architect 或 Project Architect 时 |
| `60_AGENT_SKILL/agent-executor/SKILL.md` | 安装了 Skill 的 Agent 平台 | Skill 被显式调用或与编号执行任务匹配时 |
| `60_AGENT_SKILL/agent-executor/references/` | `agent-executor` | Skill 按启动、角色、编号、远端中继或恢复场景按需读取 |
| `60_AGENT_SKILL/agent-executor/agents/openai.yaml` | 支持该元数据的平台 | 展示 Skill 名称和默认调用提示时 |
| `60_AGENT_SKILL/scripts/` | Human | 运行明确安装或打包命令时 |
| `60_AGENT_SKILL/packages/agent-executor.skill` | 支持 `.skill` 包的平台 | Human 选择包安装时 |
| `NOTICE.md`、`LICENSE` | Human、分发者 | 查看许可、来源和分发条件时 |

未列入上表的通用说明、重复角色规则、未被调用的协议和历史式入口均不保留。

## 三个容器，三种职责

~~~text
Human（真实授权者）
        │
        ▼
Chat 协作控制项目
  Global Architect 或 Project Architect
        │  编号任务 / 最小派发 Seed
        ▼
独立 Agent 执行会话 + agent-executor Skill
  Builder / Research / Repair / Verifier / Runner / Release
        │  结果与证据
        ▼
业务项目仓库或本地项目
~~~

| 容器 | 保存什么 | 绝不保存什么 |
| --- | --- | --- |
| Chat 控制项目 | 短项目指令、静态控制角色资料、正式资料库入口和会话级指针 | 业务代码、完整 Skill、可变项目记录的副本 |
| Agent Skill 安装目录 | `agent-executor` 与其执行规则 | Chat 派发规则、Human 决策、业务项目全量资料 |
| 业务项目 | 代码、依赖、项目约束、任务、报告和证据 | 本仓通用 Chat 架构和完整 Skill |

`Human` 不由模型扮演。Chat 模型每个会话只能担任 `Global Architect` 或 `Project Architect` 之一；六个执行角色只能在独立 Agent 会话中工作。

## 正式资料与 GitHub

每个项目指定一个唯一的正式资料库（`authority_store`）。它可以是数据库、受控文档库、项目版本库或任务指定的远端位置；必须有精确 URL、路径、资料库名称或查询方式。任务中的 `authority_source` 是其中一份正式记录的精确位置。聊天记忆、临时附件和复制后的任务文本都不是第二份合同。

GitHub 仅在任务明确声明 `transport: github_relay` 时使用。此时执行 Agent 必须同步完整声明项目、在隔离工作区执行、仅回写授权工作分支并回读远端。没有该声明时，不假设 GitHub 存在或必需。

## 最小读取原则

Chat 只加载项目指令、当前控制角色和当前事项需要的正式记录。执行 Agent 只加载 Skill、当前任务、分配角色和任务点名的项目文件。同步完整项目不等于把全部文件读入模型上下文。资料、角色、任务、权限或状态不可确认时，返回 `BLOCKED`，不扫描全部历史来猜测。

