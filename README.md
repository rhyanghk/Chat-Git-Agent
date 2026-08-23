# Chat-Git-Agent

`Chat-Git-Agent` 是通用的协作控制资料与执行型 Agent Skill 分发仓。它定义谁能决定、谁能派发、谁能执行和如何留存证据；它不是业务应用、任务队列、数据库或自动审批服务。

本仓不保存任何业务项目的代码、秘密或运行态。业务项目只保存自己的代码、约束、任务、报告和证据。

## 第一次使用：先选当前入口

不要从头通读全仓。按你现在承担的职责读取最小必要资料。

| 你现在要做什么 | 先读 / 先做 | 此刻不要做什么 |
| --- | --- | --- |
| Human，建立或使用协作控制项目 | [INSTALL.md](INSTALL.md) 的“配置 Chat 协作控制项目” | 把执行 Skill、通用规则或业务代码混入同一项目空间 |
| Chat 模型，协助 Human 控制工作 | [00_CHAT_CONTROL/PROJECT_INSTRUCTIONS.md](00_CHAT_CONTROL/PROJECT_INSTRUCTIONS.md) → [CONTROL_ROLES.md](00_CHAT_CONTROL/CONTROL_ROLES.md) 的当前角色 → 当前正式资料库中的精确记录 | 自称 Human；切换为执行 Agent；猜测缺失资料 |
| 执行 Agent，收到一个编号任务 | [AGENTS.md](AGENTS.md) → 当前 `TASK-xxxxxx-Rxxx` → 当前执行角色规则 | 读取全部历史；自行设计任务；以 Chat 控制角色工作 |
| Human，安装执行 Skill | [INSTALL.md](INSTALL.md) 的“安装 Agent 执行 Skill” | 把完整 Skill 安装或复制到 Chat 控制项目、业务项目仓库 |
| 维护本仓 | [AGENTS.md](AGENTS.md) → 当前任务 → 任务点名的协议或模板 | 让历史材料、无关项目或未编号请求扩大当前任务 |

## 三个彼此分开的容器

~~~text
Human（真实授权者）
        │
        ▼
独立 Chat 协作控制项目
  Global Architect 或 Project Architect
        │  编号任务 / 最小派发 Seed
        ▼
独立 Agent 执行会话 + agent-executor Skill
  Builder / Research / Repair / Verifier / Runner / Release
        │  仅任务范围内的结果与证据
        ▼
业务项目仓库或本地项目
~~~

| 容器 | 保存什么 | 不保存什么 |
| --- | --- | --- |
| Chat 协作控制项目 | 短项目指令、静态控制角色参考、唯一正式资料库的入口、会话级指针 | 业务代码、完整执行 Skill、项目控制记录的副本 |
| Agent Skill 安装位置 | `agent-executor` 及其执行参考资料 | Chat 派发规则、Human 决策、业务项目全量资料 |
| 业务项目仓库或本地项目 | 项目代码、依赖、测试、项目约束、项目任务、报告和证据 | 本仓完整通用控制架构、完整执行 Skill、无关项目资料 |

“协作控制项目”是 Chat 平台中的项目空间或独立控制工作区，不等于业务项目的本地仓库或 GitHub 仓库。

## 身份、职责与禁止事项

| 身份 | 工作位置 | 负责什么 | 不负责什么 |
| --- | --- | --- | --- |
| `Human` | Chat 外的真实授权者 | 目标、优先级、风险接受、验收和重大远端动作决定 | 不由模型扮演；不要求 Agent 猜测未写入任务的要求 |
| `Global Architect` | Chat 控制项目 | 跨项目规则、共享接口、术语、治理收敛 | 代替 Human 决策、验收或发布；默认施工 |
| `Project Architect` | Chat 控制项目 | 单项目任务、revision、边界、派发和结果收敛 | 扩大 Human 授权；最终验收、merge、deploy、release |
| `Builder` | 独立 Agent 会话 | 实施任务拥有的项目改动 | 改任务合同、共享接口或自我验收 |
| `Research` | 独立 Agent 会话 | 指定问题的可复查证据 | 施工、把建议变为决定 |
| `Repair` | 独立 Agent 会话 | 已确定故障的最小修复 | 擅自重构、重设边界 |
| `Verifier` | 独立 Agent 会话 | 独立验证指定结果 | 实施修复或接受结果 |
| `Runner` | 独立 Agent 会话 | 明确批准的确定性操作 | 解释歧义、充当审批者 |
| `Release` | 独立 Agent 会话 | 独立任务内、经 Human 授权的 merge、deploy 或 release | 从提交、验证或验收推导发布权 |

模型不能扮演 `Human`。每个 Chat 会话只能以 `Global Architect` 或 `Project Architect` 其中一个模型角色工作；执行角色只能在独立 Agent 会话中运行。

## 正式资料库与 GitHub

每个项目指定一个唯一的**正式资料库**（`authority_store`）：它可以是数据库、平台项目的受控资料源、版本库或文档库，但必须有清楚的位置和读取方式。`authority_store` 表示资料库本身；任务中的 `authority_source` 表示其中某一份正式记录的精确位置。简单项目中两者可以是同一个 URL 或路径。Chat 对话和临时附件不是第二份合同。

GitHub 是可选中继。只有任务明确声明 `transport: github_relay` 时，执行 Agent 才需要完整同步指定业务项目、在隔离工作区执行、回写授权结果并回读远端。没有这个声明时，项目不需要 GitHub。

## 实际目录与按需阅读

| 位置 | 何时读取 | 内容 |
| --- | --- | --- |
| `00_CHAT_CONTROL/` | 建立或运行 Chat 控制项目时 | 短项目指令与控制角色边界 |
| `00_KERNEL/` | 需要语言或稳定输出规则时 | 语言政策 |
| `10_BOOT/` | 启动、恢复、交接或首次建立协作空间时 | 开工检查与协作空间初始化协议 |
| `20_ROLES/` | 创建或执行编号任务时 | 六个执行角色的职责边界 |
| `30_PROTOCOLS/` | 任务、编号、正式记录、仓库边界或 GitHub 中继时 | 具体协议 |
| `50_TEMPLATES/` | 要创建正式任务、报告、变更或交接记录时 | 可复制模板 |
| `60_AGENT_SKILL/` | 安装或运行执行型 Agent 时 | 唯一 Skill、安装器和分发包 |
| `docs/` | 派发、恢复、交接或深度场景时 | 中立 Agent 接口与会话生命周期参考 |

默认读取层级：L0 是当前执行规则或短控制指令；L1 是当前角色、编号任务和任务点名的项目文件；L2 仅在中继、恢复、交接、冲突、验证、权限或安全场景读取相应协议；历史材料默认不读。同步整个项目不等于把所有文件加载进模型上下文。

## 常用正式模板

| 文件 | 用途 |
| --- | --- |
| [CHAT_PROJECT_BOOTSTRAP.md](50_TEMPLATES/CHAT_PROJECT_BOOTSTRAP.md) | 建立或恢复一个 Chat 协作控制项目，只记录角色与正式资料库入口 |
| [TASK_RECORD.md](50_TEMPLATES/TASK_RECORD.md) | 创建一个编号、可执行的正式任务 |
| [GITHUB_RELAY_TASK.md](50_TEMPLATES/GITHUB_RELAY_TASK.md) | 为明确使用 GitHub 中继的任务补充远端字段 |
| [RESULT_REPORT.md](50_TEMPLATES/RESULT_REPORT.md) | 执行角色提交结果、交付、验证、风险与下一步 |
| [CHANGE_REQUEST.md](50_TEMPLATES/CHANGE_REQUEST.md) | 修改角色、范围、revision、基线或验收时创建变更请求 |
| [bootstrap_check_request.md](50_TEMPLATES/bootstrap_check_request.md) | 只做七项开工检查 |
| [capability_self_check.md](50_TEMPLATES/capability_self_check.md) | 新环境或交接前盘点能力，不产生授权 |
| [architect_handoff_check.md](50_TEMPLATES/architect_handoff_check.md) / [architect_handoff_transaction.md](50_TEMPLATES/architect_handoff_transaction.md) | 交接控制角色时使用 |

## 维护本仓

本仓的通用规则、协议、模板和 Skill 可以演进；业务项目资料不能进入本仓。维护时遵循 [AGENTS.md](AGENTS.md)、当前执行角色规则与精确编号任务。来源和许可见 [NOTICE.md](NOTICE.md)。
