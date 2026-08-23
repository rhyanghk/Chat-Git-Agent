# Chat-Git-Agent

一套围绕 Human governance、分职 AI role、协作控制项目、独立 Agent Skill 与可选 GitHub 中继形成的人机协作方法论。

版本：PROJECT-0001

> 第一次进入请读 START_HERE.md。

---

## Why

长期使用 AI 时，真正的风险不是模型不能写，而是职责、事实源和任务边界逐渐混在一起：

- Chat 把建议、任务、验收与实现混为一体；
- 同一个 Agent 定义需求、编写代码、评审自己并宣布完成；
- 跨平台复制后任务版本漂移；
- GitHub 被使用时，本地只读到局部或过期现场；
- 每个 Agent 为了安全而扫描全部文档、重复写备份或重复状态；
- 业务仓库被塞入通用 Chat/Agent 架构；
- 只靠聊天自述，没有可恢复证据。

Chat-Git-Agent 的目标是让 Human 与 AI 以可恢复、可验证、成本与风险相称的方式长期协作。

## Governance model

~~~text
Human
  └─ Global Architect
       ├─ Project Architect
       │     ├─ Builder / Research / Repair
       │     ├─ Verifier
       │     └─ Runner / Release
       └─ other projects
~~~

- Human：目标、优先级、验收标准、风险接受和重大远端动作的最终权威。
- Global Architect：跨项目规则、接口、阅读索引、治理收敛与冲突裁决。
- Project Architect：单一项目的日常架构自治、任务和 revision 管理。
- Builder / Research / Repair / Verifier：可替换的专业执行角色，不拥有长期治理权。
- Runner：确定性执行与安全工具，不是架构师或审批官。
- Release：仅在独立任务和 Human 明确授权下执行 merge、deploy 或 release。

## Deployment model

| 容器 | 内容 | 不包含 |
| --- | --- | --- |
| 协作控制项目 | Chat 指令、Chat 侧角色、项目控制资料与人工派发 | 业务代码、完整 Agent 执行规则 |
| Agent 执行 Skill | 启动检查、角色执行边界、任务执行与证据回报 | Chat 派发、Chat 协调与 Human 调度 |
| 业务项目仓库 | 代码、项目约束、任务、报告、证据 | 通用 Chat 架构、通用角色库、完整 Skill |

## Core ideas

- named durable authority：每类记录有明确唯一权威，不把聊天记忆当合同。
- evidence > self-report：可恢复项目记录、测试、构建和独立验证强于自评。
- minimal sufficient governance：只使用与风险相称的流程。
- progressive context：默认只读 L0、当前角色、当前任务与任务指定项目文件。
- precise numbering：任务与正式产物使用 PROJECT、TASK、R、WORK、REPORT、DECISION、EVIDENCE 编号。
- no defensive writes：不创建未经授权的副本、镜像、备份或替代事实源。
- github relay when declared：启用 GitHub 中继时，完整同步、隔离执行、回写和远端回读成为硬门槛。

## Read this repository

阅读按 READING_MAP.md 进行。Chat 侧从 00_CHAT_CONTROL/ 开始；执行 Agent 从 AGENTS.md 和 60_AGENT_SKILL/agent-executor/ 开始；项目专有知识始终在业务项目中。

## License

本仓在 Apache License 2.0 下发布。来源与适配说明见 NOTICE.md。