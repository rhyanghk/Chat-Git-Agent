# START HERE

陌生 Human、Chat 或 Agent 第一次进入 Chat-Git-Agent 时的启动文档。

---

## 1. Chat-Git-Agent 是什么

Chat-Git-Agent 是一套围绕 Human governance、专职 AI role、可恢复控制记录与可选 GitHub 中继的人机协作方法论。

- 分离 Chat 控制职责与 Agent 执行职责；
- 保留 Human / Global Architect / Project Architect / Builder / Research / Repair / Verifier / Runner / Release 的权限边界；
- 使用编号化任务、revision、正式报告和可恢复位置，而非聊天记忆、内容哈希或临时副本；
- 在明确启用 github_relay 时，要求 Agent 在开始与结束都同步完整项目仓库；
- 不要求业务项目、实际本地仓库或 GitHub 仓库承载通用 Chat 架构或完整 Agent Skill。

它不是运行时、数据库、Router 或自动审批器。它是规则、接口、模板和平台适配资料。

## 2. 三个独立容器

1. 协作控制项目：ChatGPT Web、Claude Web、Claude Code 的 Chat 模式或其他 Chat 平台中的项目空间。保存项目指令、Chat 侧角色、任务与决策的数据源，以及人工复制派发资料。
2. Agent 执行 Skill：只供可安装 Skill 的执行环境使用。它只接收编号化任务、执行、验证并回传正式结果；不包含 Chat 架构。
3. 业务项目：实际本地仓库或 GitHub 仓库。只保存该项目的代码、构建、测试、项目约束、项目任务、项目报告和项目证据。

通用资料不进入业务项目；业务代码与私有运行态不进入本仓的通用规则。

## 3. 第一阅读入口

按顺序读，不要通读全仓：

1. READING_MAP.md：按当前角色和场景定位最小阅读集合；
2. NAMESPACE.md：理解目录与职责流向；
3. AGENTS.md：执行 Agent 的机器 L0；
4. README.md：体系概览；
5. Chat 侧角色再读 00_CHAT_CONTROL/；执行 Agent 按需读 60_AGENT_SKILL/agent-executor/。

## 4. 启动与任务

最小任务种子只寻址，不复制完整任务知识：

~~~text
task: TASK-000001-R001
role: Builder
startup_mode: fresh
~~~

任务合同、范围、禁止项、验收、输入和正式报告位置必须在命名的 durable authority source 中。GitHub 中继任务额外给出 repository、task reference、base branch、work branch 和明确 remote actions。

## 5. GitHub 是可选中继，不是业务前提

业务项目可以完全不使用 GitHub。只有任务明确声明 transport: github_relay 时，GitHub 才成为该任务的中继端：

1. 控制角色将项目相关任务记录发布到 GitHub；
2. Agent 刷新远端并同步完整项目树后才读取和执行；
3. Agent 在隔离工作区和指定工作分支完成任务；
4. Agent 再次刷新远端、同步授权的项目结果回 GitHub，并回读远端位置；
5. 提交不等于验收，Human 保留最终接受权。

## 6. 首次搭建

首次使用时准备：

- 本治理资料库；
- 一个独立协作控制项目及其唯一正式资料库；
- 可选的 Agent Skill 安装位置；
- 一个或多个业务项目；
- 仅在需要时注册 GitHub 中继。

详情见 10_BOOT/WORKSPACE_BOOTSTRAP_PROTOCOL.md 与 50_TEMPLATES/HUMAN_WORKSPACE_BOOTSTRAP.md。

## 7. 重要边界

- Human 拥有目标、优先级、风险接受、验收、merge、deploy 与 release 的最终决定权。
- 工具可用、仓库可写、模型建议或历史材料都不产生权限。
- 不使用内容哈希、哈希命名、备份副本、镜像文件或防御性写入。
- 任务、revision、分支、报告和证据使用精确编号命名。
- 缺少角色、任务、权限、入口或状态一致性时，停止并报告 BLOCKED。

## 8. 验证入口

陌生用户的冷启动验证见 40_GUIDES/PUBLIC_COLD_START_CHECKLIST.md。平台专用 Chat 使用说明见 00_CHAT_CONTROL/PLATFORM_ADAPTERS/。