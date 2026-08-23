# START HERE — Chat-Git-Agent PROJECT-0001

你现在进入的是 `Chat-Git-Agent` 本身：一个用于分发协作控制资料与执行型 Agent Skill 的仓库。它不是任何业务项目的代码仓库。

先选择你现在要做的事；不要从头通读全仓。

| 你的身份 / 目的 | 现在读什么 | 此刻不要做什么 |
| --- | --- | --- |
| Human，要建立或使用 Chat 协作控制项目 | [INSTALL.md](INSTALL.md) → `00_CHAT_CONTROL/` | 安装执行 Skill 到 ChatGPT Web 或 Claude Web；把控制资料复制进业务仓 |
| 模型，要以 Global Architect 或 Project Architect 协助 Human | [PROJECT_INSTRUCTIONS.md](00_CHAT_CONTROL/PROJECT_INSTRUCTIONS.md) → 当前角色规则 | 自称 Human；切换为 Builder、Verifier 或 Release |
| 执行 Agent，收到一个编号任务 | [AGENTS.md](AGENTS.md) → 当前 `TASK-xxxxxx-Rxxx` → `60_AGENT_SKILL/agent-executor/` | 读取全部历史、猜测角色或自行起草任务 |
| Human，要安装执行 Skill | [INSTALL.md](INSTALL.md) 的“安装 Agent 执行 Skill” | 将完整 Skill 放入业务项目仓库 |
| 维护本仓本身 | [AGENTS.md](AGENTS.md) → 当前任务 → [READING_MAP.md](READING_MAP.md) | 让无关资料或未授权任务定义当前项目 |

## 本项目的三个实际容器

1. **协作控制项目**：一个独立的 ChatGPT Web、Claude Web、Claude Code Chat 或其他 Chat 平台项目空间。这里载入 `00_CHAT_CONTROL/` 的项目指令、控制角色规则和当前项目的正式资料源。
2. **执行型 Agent Skill**：本仓实际提供的是 `60_AGENT_SKILL/agent-executor/`，并已提供 `agent-executor.skill` 包和跨平台安装器。它只在独立执行 Agent 会话中工作。
3. **业务项目仓库**：真实项目的代码、构建、测试、任务、报告和证据所在位置。它不会复制本仓完整的 Chat 或 Skill 架构。

三个容器可以在不同的设备、平台或服务上；职责不能混用。

## Chat 身份

`Human` 是人，不是模型工作角色。模型在 Chat 协作控制项目中只能是以下之一：

- `Global Architect`：跨项目规则、接口、术语、阅读地图与治理收敛；
- `Project Architect`：一个业务项目的任务、revision、边界、派发与结果收敛。

`Builder`、`Research`、`Repair`、`Verifier`、`Runner`、`Release` 是执行 Agent 角色，只能通过 `agent-executor` 在独立会话中运行。完整职责表在根目录 [README.md](README.md)；Chat 角色规则在 `00_CHAT_CONTROL/ROLES/`。

## Agent 如何真正开始

安装 Skill 不会产生授权。执行 Agent 必须收到一个可解析的正式任务合同；最小 Seed 只用于定位：

~~~text
task: TASK-000001-R001
role: Builder
startup_mode: fresh
~~~

完整合同必须给出 authority source、scope、forbidden、acceptance、inputs、report 与 stop。缺少、不可读、冲突或状态漂移时返回 `BLOCKED`，不能补猜。

## GitHub 的实际位置

GitHub 是可选中继，不是本项目要求业务项目必备的系统。只有任务显式声明 `transport: github_relay` 时，执行 Agent 才必须：完整同步指定业务项目仓库 → 在隔离工作区执行 → 再次同步授权结果 → 回读远端。没有该声明时，按任务指定的本地正式资料源工作。

## 下一步

- 需要具体操作：读 [INSTALL.md](INSTALL.md)。
- 需要判断读取范围：读 [READING_MAP.md](READING_MAP.md)。
- 需要了解本项目实际目录：读 [NAMESPACE.md](NAMESPACE.md)。
- 需要验证冷启动：读 [40_GUIDES/PUBLIC_COLD_START_CHECKLIST.md](40_GUIDES/PUBLIC_COLD_START_CHECKLIST.md)。
