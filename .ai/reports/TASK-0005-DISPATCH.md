# TASK-0005 Dispatch

status: DISPATCHED
role: REPAIR
project: rhyanghk/Chat-Git-Agent
task: .ai/tasks/TASK-0005.md
task_revision: 3
report: .ai/reports/TASK-0005-REPAIR.md
startup_mode: fresh
task_ref: 8a60d0fc4666bd9a7caa387ebcb1804b123c6e36

remote_sync_gate: REQUIRED
remote_actions:
  push_work_branch: allowed
  open_pr: forbidden
  merge: forbidden
  deploy: forbidden
  release: forbidden
user_authorized_actions: []

说明：revision 1/2 派发全部作废。Repair 开工前必须刷新远端 refs，并确认 live main 包含上述 revision 3 `task_ref`；不得以本地 checkout 看起来最新作为同步证据。同步失败报告 `BLOCKED_REMOTE_SYNC`，远端 task/ref 漂移无法安全解释报告 `BLOCKED_REMOTE_DRIFT`。本轮只允许非 force push 指定 Repair 工作分支；禁止 PR、merge、deploy、release、默认分支写入、创建 release tag、force push 或重写历史。正式合同以 TASK-0005 revision 3 为准。
