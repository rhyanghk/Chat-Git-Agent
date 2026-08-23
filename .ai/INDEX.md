# 项目记录入口

schema_version: 2
repository: rhyanghk/Chat-Git-Agent
default_branch: main
last_verified_ref: 6f6315207f30b130f543caed55416439e471eaef
context_paths:
  - .ai/context/PROJECT.md
  - .ai/context/ARCHITECTURE.md
  - .ai/context/MEMORY.md
  - .ai/context/DECISIONS.md
active_task_index: .ai/tasks/ACTIVE.md
dispatch_dir: .ai/dispatch/
handoff: .ai/handoff/CURRENT.md

本目录只记录 `Chat-Git-Agent` 自己的项目事实、架构基线、任务、派发、证据和交接状态，不是给业务项目复制的安装模板。

当前角色模型：`ARCHITECT` 是主协调 Chat 的内建架构功能，不是 Agent role；可派发 Agent 为 `RESEARCH / BUILDER / REPAIR / VERIFIER / RELEASE`。当前实施任务见 `.ai/tasks/TASK-0009.md`，exact dispatch 见 `.ai/dispatch/TASK-0009-BUILDER.md`。

项目正式 `docs/**` 由 Builder 按 Chat 架构基线实体化；`.ai/context/ARCHITECTURE.md` 只作为恢复/架构控制基线，不代替已验收的正式产品文档。
