# Chat-Git-Agent

`Chat-Git-Agent` 让一个独立 Chat 控制项目与一个或多个独立执行 Agent 完成完整任务闭环。它不保存业务代码、秘密或运行态；业务项目只保存自己的代码、任务、报告和证据。

## 安装后怎样完整运行

~~~text
Human
  │  配置 Chat 控制项目：项目指令 + 控制运行文件
  ▼
Chat 控制模型
  │  创建编号任务，选择执行角色和传输方式
  ▼
执行 Agent + Chat-Git-Agent Skill
  │  实施 / 验证，产出编号结果报告
  ▼
Human 或共享正式资料库
  │  记录报告，再把精确位置交回 Chat
  ▼
Chat 控制模型
  └─ 读取结果、记录风险，等待 Human 验收
~~~

完整闭环有三种传输方式：

| 方式 | 何时使用 | Chat 与 Agent 如何交接 |
| --- | --- | --- |
| `local` | 同一受控本地项目和正式资料库对执行 Agent 可读写 | Chat 给出任务位置；Agent 读取任务、写入报告；Chat 读取报告位置 |
| `github_relay` | 任务明确使用 GitHub 中继 | Chat 创建项目任务；Agent 完整同步、在隔离工作区执行、回写授权工作分支和报告；Chat 回读位置 |
| `human_copy` | Chat 与 Agent 没有共同可读写的资料库，或跨平台只能人工复制 | Human 原样记录 Chat 输出的完整任务，再复制给 Agent；Agent 原样返回完整结果报告；Human 写入唯一正式资料库并把报告位置交回 Chat；Chat 不能直读时同时接收报告的原样副本 |

`human_copy` 不是聊天摘要：它传递完整、编号的正式任务或报告，Human 不改写字段。这样 ChatGPT Web、Claude Web、Claude Code 控制会话及其他 Chat，都能向不同平台的 Agent 派发任务，而不要求 GitHub。

## Agent 默认调用

`Chat-Git-Agent` 是执行 Agent 的默认入口：任何读取、修改、验证或运行项目的 Agent 请求，均先调用它；没有精确编号 TASK 时只返回 `BLOCKED`。支持隐式 Skill 调用的平台会根据 Skill 元数据自动选择它；其他平台必须把 [INSTALL.md](INSTALL.md) 中的默认 Agent 规则写入用户级 Agent 指令。此规则不写入业务项目仓库，也不适用于控制会话。

## 第一次进入：选择入口

| 你现在要做什么 | 读取或执行 | 不要做什么 |
| --- | --- | --- |
| Human，配置 Chat 控制项目 | [INSTALL.md](INSTALL.md) 的第 1–2 节 | 把业务项目资料或执行 Skill 当作 Chat 的固定资料 |
| Chat 控制模型 | 已配置的 [PROJECT_INSTRUCTIONS.md](CHAT_CONTROL/PROJECT_INSTRUCTIONS.md) → [CONTROL_RUNTIME.md](CHAT_CONTROL/CONTROL_RUNTIME.md) → 当前正式记录 | 自称 Human、执行代码、验收或发布 |
| 执行 Agent | 已安装的 [Chat-Git-Agent Skill](AGENT_SKILL/chat-git-agent/SKILL.md) → 当前编号任务 | 读取 Chat 控制资料、设计任务或接受结果 |
| Human，安装执行 Skill | [INSTALL.md](INSTALL.md) 的第 3 节 | 把 Skill 复制进 Chat 项目或业务项目仓库 |
| 维护本仓 | [AGENTS.md](AGENTS.md) → 当前任务 | 改动业务项目资料或未授权远端动作 |

## 每个文件如何生效

| 文件或产物 | 消费者 | 加载或触发方式 |
| --- | --- | --- |
| `README.md` | Human | 从仓库根目录首次进入时 |
| `INSTALL.md` | Human | 配置 Chat 项目、安装或调用 Skill 时 |
| `AGENTS.md` | 维护本仓的 Agent | 平台发现本仓规则，或维护任务明确列出时；不复制到业务项目 |
| `CHAT_CONTROL/PROJECT_INSTRUCTIONS.md` | Chat 平台 | Human 将正文放入项目指令后，每次控制会话加载 |
| `CHAT_CONTROL/CONTROL_RUNTIME.md` | Chat 控制模型 | Human 将其作为项目静态资料上传或提供；项目指令要求每次控制会话先读它 |
| `AGENT_SKILL/chat-git-agent/SKILL.md` | Agent 平台 | Skill 由默认规则或显式调用加载，随后才允许执行任务 |
| `AGENT_SKILL/chat-git-agent/references/` | `Chat-Git-Agent` | Skill 在开始、角色、编号、恢复或传输场景按需读取 |
| `AGENT_SKILL/chat-git-agent/agents/openai.yaml` | 支持元数据的平台 | 展示名称并为每次执行请求启用隐式调用时 |
| `AGENT_SKILL/scripts/` | 安装 Agent / 维护 Agent | 接到安装或打包指令时 |
| `AGENT_SKILL/packages/Chat-Git-Agent.skill` | 支持 `.skill` 包的平台 | Agent 接到包安装指令时 |
| `NOTICE.md`、`LICENSE` | Human、分发者 | 查看许可、来源与分发条件时 |

没有“仅供参考、无人加载”的通用协议、角色目录或模板目录。

## 三个容器与边界

| 容器 | 保存什么 | 不保存什么 |
| --- | --- | --- |
| Chat 控制项目 | 短项目指令、控制运行文件、正式资料库入口和当前事项指针 | 业务代码、完整 Agent Skill、可变项目记录的副本 |
| Agent Skill 安装目录 | `Chat-Git-Agent` 及执行规则 | Chat 派发规则、Human 决策、业务项目全量资料 |
| 业务项目 | 代码、依赖、项目约束、任务、报告和证据 | 通用 Chat 架构、完整执行 Skill、其他项目资料 |

`Human` 是 Chat 外的真实授权者。每个 Chat 会话只选择 `Global Architect` 或 `Project Architect`；`Builder`、`Research`、`Repair`、`Verifier`、`Runner`、`Release` 只能在独立执行 Agent 会话中工作。

每个项目指定一个唯一正式资料库（`authority_store`）；任务中的 `authority_source` 是其中一份正式记录的精确位置。聊天记忆、临时附件和复制后的摘要都不能成为第二份合同。
