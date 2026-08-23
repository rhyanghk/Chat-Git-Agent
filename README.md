# Chat-Git-Agent

`Chat-Git-Agent` 是一个实际的治理与分发仓：它提供 Chat 协作控制资料、一个可安装的执行型 Agent Skill、平台安装器、任务协议与模板。当前主线标识为 `PROJECT-0001`。

它**不是**业务应用、运行时、任务队列、数据库或自动审批服务；本仓也不保存任何业务项目的代码或运行态。

> 第一次进入读 [START_HERE.md](START_HERE.md)。要安装或配置使用环境读 [INSTALL.md](INSTALL.md)。

## 本项目实际包含的内容

| 位置 | 当前内容 | 用途 |
| --- | --- | --- |
| `00_CHAT_CONTROL/` | Chat 项目指令、三种控制身份、四个平台适配 | 建立独立协作控制项目；不执行业务代码 |
| `00_KERNEL/` | 语言政策与稳定规则入口 | 辅助定位 `AGENTS.md`、`CONSTITUTION.md` 和阅读地图 |
| `10_BOOT/` | Bootstrap Check 与 Workspace Bootstrap 协议 | 只在启动、恢复和首次搭建时按需读取 |
| `20_ROLES/` | Builder、Research、Repair、Verifier、Runner、Release 的角色边界 | 定义任务可分配的执行职责 |
| `30_PROTOCOLS/` | 编号、控制记录、业务仓边界、GitHub 中继协议 | 让任务和证据可恢复且不越权 |
| `40_GUIDES/` | 冷启动验证入口 | 为陌生使用者验证实际启动路径 |
| `50_TEMPLATES/` | Chat 启动、任务、结果、变更和交接模板 | 生成唯一、编号化的正式记录 |
| `60_AGENT_SKILL/agent-executor/` | 唯一的通用执行 Skill | 只在独立 Agent 会话中执行一个已派发任务 |
| `60_AGENT_SKILL/packages/agent-executor.skill` | 可分发的 ZIP 格式 `.skill` 包 | 给支持 `.skill` 包的平台直接安装 |
| `60_AGENT_SKILL/scripts/` | macOS/Linux、Windows 安装器和打包器 | 将同一份 Skill 装入平台的用户级目录 |

## 本项目实际运行方式

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
        │  仅任务授权范围内的结果与证据
        ▼
业务项目仓库
~~~

只有任务明确写为 `transport: github_relay` 时，GitHub 才进入该任务的中继流程：执行前同步完整业务项目仓库，完成后同步授权结果并回读。没有这一声明时，业务项目可以完全不使用 GitHub。

## 身份与权限

| 身份 | 谁承担 | 当前实际职责 | 不拥有的权力 |
| --- | --- | --- | --- |
| `Human` | 真实的人 | 目标、优先级、风险接受、任务发布授权、最终验收、merge、deploy、release | 不必亲自执行；不要求 Agent 猜测未写入任务的细节 |
| `Global Architect` | Chat 模型 | 跨项目规则、公共接口、术语、阅读地图、治理收敛 | 不能替代 Human 的产品决定、验收或发布授权；不默认施工 |
| `Project Architect` | Chat 模型 | 单项目架构、任务拆分、revision、边界、派发与结果收敛 | 不能扩大 Human 授权；不能最终验收、merge、deploy、release |
| `Builder` | 执行 Agent | 实施任务拥有的项目改动 | 不改任务合同或共享接口，不自我验收 |
| `Research` | 执行 Agent | 为指定问题提供证据 | 不施工，不把建议变成决定 |
| `Repair` | 执行 Agent | 修正已确定、已授权的问题 | 不把修复扩展为重构或重设边界 |
| `Verifier` | 执行 Agent | 独立验证指定结果 | 不实施修复或接受结果 |
| `Runner` | 执行 Agent | 执行明确批准的确定性操作 | 不解释歧义或充当审批者 |
| `Release` | 执行 Agent | 在独立任务和 Human 授权下进行重大远端动作 | 不从提交、验证或验收推导 merge、deploy、release 权 |

模型不能扮演 `Human`。Chat 模型一次会话只以 `Global Architect` 或 `Project Architect` 之一工作；执行 Agent 角色只能在独立 Agent 会话中运行。

这不是平台、模型或工具的分类；它们是权限边界。可用工具和可写仓库都不等于获得授权。

## 如何使用本项目

1. 要建立 Chat 协作控制项目：从 `00_CHAT_CONTROL/` 开始，按 [INSTALL.md](INSTALL.md) 载入项目指令、控制角色和正式资料源。
2. 要执行实际项目任务：安装 `60_AGENT_SKILL/agent-executor/`，再向新的 Agent 会话提供一个可解析的 `TASK-xxxxxx-Rxxx` 合同。
3. 要维护本仓本身：遵循 [AGENTS.md](AGENTS.md)、当前角色规则和编号任务；只修改本仓的通用治理资料或 Skill 产物。

业务项目仓只保存其自己的代码、测试、项目任务、报告与证据。不得复制本仓完整的 Chat 架构或执行 Skill 进去。

## 正式模板实际用途

| 文件 | 何时使用 |
| --- | --- |
| `HUMAN_WORKSPACE_BOOTSTRAP.md` | Human 首次建立本仓、控制项目和业务项目的协作空间 |
| `CHAT_PROJECT_BOOTSTRAP.md` | 建立或恢复一个 Chat 协作控制项目 |
| `TASK_RECORD.md` | 新建一个编号、可执行的正式任务 |
| `GITHUB_RELAY_TASK.md` | 任务明确使用 GitHub 中继时 |
| `RESULT_REPORT.md` | 执行角色提交一份正式结果报告 |
| `CHANGE_REQUEST.md` | 修改 scope、revision、角色、基线或验收时 |
| `bootstrap_check_request.md` | 只做七项开工检查时 |
| `capability_self_check.md` | 新环境或交接前盘点能力时 |
| `architect_handoff_check.md` / `architect_handoff_transaction.md` | 交接 Global Architect 或 Project Architect 时 |
| `pointer_response.md` | 仅返回正式资料位置，不复制第二份合同 |

## 导航

- [START_HERE.md](START_HERE.md)：按使用者身份选择正确入口。
- [INSTALL.md](INSTALL.md)：Chat 控制项目与各主流 Agent 平台的具体安装命令。
- [00_CHAT_CONTROL/ROLES/HUMAN.md](00_CHAT_CONTROL/ROLES/HUMAN.md)、[GLOBAL_ARCHITECT.md](00_CHAT_CONTROL/ROLES/GLOBAL_ARCHITECT.md)、[PROJECT_ARCHITECT.md](00_CHAT_CONTROL/ROLES/PROJECT_ARCHITECT.md)：Chat 身份边界。
- [60_AGENT_SKILL/agent-executor/SKILL.md](60_AGENT_SKILL/agent-executor/SKILL.md)：Skill 的直接执行规则；包和安装器在 `60_AGENT_SKILL/` 下。
- [READING_MAP.md](READING_MAP.md)：按角色读取最小必要文档。

## License

本仓在 Apache License 2.0 下发布。来源与适配说明见 [NOTICE.md](NOTICE.md)。
