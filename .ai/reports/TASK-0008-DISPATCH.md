# TASK-0008 Durable Dispatch

status: DISPATCHED
work_coordinate: `rhyanghk/Chat-Git-Agent:.ai/tasks/TASK-0008.md@revision-1`
role: ARCHITECT
startup_mode: fresh
task_ref: dcfe78b21c5df6455f5c836a4e7a10ede5d86ab8
task_source: `rhyanghk/Chat-Git-Agent@dcfe78b21c5df6455f5c836a4e7a10ede5d86ab8:.ai/tasks/TASK-0008.md`
common_rule_source: `rhyanghk/Chat-Git-Agent@4e66a7785455f5ff9bf4b8d26f800af86b307380:agent/AGENTS.md`
role_rule_source: `rhyanghk/Chat-Git-Agent@4e66a7785455f5ff9bf4b8d26f800af86b307380:agent/roles/ARCHITECT.md`
decision_source: `.ai/context/DECISIONS.md#D-010`
report: `.ai/reports/TASK-0008-ARCHITECT.md`
work_branch: `architect/task-0008-project-architecture`
remote_sync_gate: REQUIRED

remote_actions:
  push_work_branch: allowed
  open_pr: forbidden
  merge: forbidden
  deploy: forbidden
  release: forbidden

user_authorized_actions:
  - push_work_branch

说明：本文件是当前产品完成 durable-dispatch 修复前的过渡性可恢复派发指针。Seed 只需定位本文件/Task，不复制任务正文。若 Agent 用户环境无法自动加载 ARCHITECT 角色规则，必须按 `role_rule_source` 的 exact ref 读取；不得猜测角色内容。TASK-0008 将设计后续正式 Durable Dispatch 位置和协议，本文件本身不预判最终目录结构。
