# 当前状态

current_phase: TASK-0006 merge 已完成并通过 Chat 远端验收；最新 upstream 对齐审计为 NEEDS_REPAIR
active_tasks:
  - TASK-0006
blockers:
  - WAIT_RELEASE_REPORT_SYNC: `.ai/reports/TASK-0006-RELEASE.md` 目前只存在于 Agent 本地路径，尚未出现在远端 main；Chat 已写 `.ai/reports/TASK-0006-CHAT.md` 记录可独立验证的 merge 事实，但不伪造 Agent 原报告。
  - BLOCKED_DELETE_REF_TOOL: 用户已明确授权删除 `tmp/invalid-do-not-use`、`tmp/report-convergence`、`tmp/stop`，但当前 GitHub connector 未暴露 delete-ref/delete-branch 动作，不能用移动 ref 冒充删除。
  - UPSTREAM_ALIGNMENT_NEEDS_REPAIR: 当前有效项目规则要求 `.ai/agents/STARTUP.md`、项目 roles 与 task prompts，但 live main 的 `.ai/` 没有 `agents/`；TASK-0006 曾真实触发 `BLOCKED_RULES_UNAVAILABLE`。旧 `maintenance/AUDIT.md` PASS 已陈旧。
merge_main_ref: ac93e0676b6fb535c1c3c72d7300de6f9d3eab30
merge_parent_main: 6fb4ff4be164059f427dd337a7d7fe33a5e87a25
accepted_work_ref: 56815df11a80a8682f63c2fbfee9dd99af4dd3a6
accepted_zip_sha256: 613520456c70725b6b982aecfe970d320a530b7fa280983cef3ffda85bd585d8
release_task_ref: 8762b17d5950620911107c17ecb4ab18560a631d
latest_upstream_ref: 1ddfeb0dd6a606dbc80ab86de8903d6888077bc6
latest_upstream_audit: .ai/reports/UPSTREAM-AUDIT-2026-08-22-CHAT.md
user_authorized_actions:
  - merge
  - delete_temp_branches_only
current_risks:
  - release、deploy、tag 未授权；merge 成功不能推导后续权限。
  - 原历史工作分支 `build/task-0003-dispatch-guard`、`verify/task-0004-task0003`、`repair/task-0005-task0003` 的必要产品和报告均已收敛到 main；按 upstream durable-truth 原则可以删除，但用户当前只询问是否可删，尚未授权删除这 3 个历史分支。
  - 当前产品的 Agent 派发仍依赖用户环境角色文件，缺少项目内 durable dispatch assets；fresh Agent 可恢复性不足。
  - Chat 在收敛操作中误建的 3 个 tmp 分支尚未删除，原因是工具能力缺失，不是权限缺失。
next_actions:
  - 使用具备 delete-ref 能力的外部 Agent/本地 Git 删除 3 个已授权 tmp 分支，删除后回读远端 branches。
  - 若用户授权删除 3 个历史任务分支，可在确认 main durable reports/exact pointers 后一并清理；当前从治理角度已满足可删条件。
  - 修复 `.ai/agents` durable dispatch 层与 canonical pointer seed，再重新执行 upstream alignment audit；在新的 PASS 前不把旧 `maintenance/AUDIT.md` 当作当前发布门槛证据。
  - 同步 Agent 原始 `.ai/reports/TASK-0006-RELEASE.md` 到 main，完成 TASK-0006 正式报告收敛。
  - release 只有在用户另行明确授权且 upstream alignment 修复/审计通过后，才创建或修订 RELEASE 阶段合同。
last_verified_ref: 7cc9f6fd973d0236666e887e82757d65345de986
architect_control:
  status: ACTIVE
  holder: current-chat
  authority_note: Chat 已验证 merge 与 upstream 对齐缺口；只维护 `.ai/**`。release/deploy/tag 与历史分支删除均未获得授权；3 个 tmp 分支删除已授权但被工具能力阻塞。
