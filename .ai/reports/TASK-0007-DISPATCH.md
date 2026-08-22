# TASK-0007 Dispatch

status: DISPATCHED
role: RELEASE
project: rhyanghk/Chat-Git-Agent
task: .ai/tasks/TASK-0007.md
task_revision: 1
task_ref: ab56afa07f4997cdfab6822d8b99e48aaebb9cff
report: .ai/reports/TASK-0007-RELEASE.md

remote_actions:
  delete_remote_branches: allowed_exact_list_only
  push_work_branch: forbidden
  write_default_branch: forbidden
  open_pr: forbidden
  merge: forbidden
  deploy: forbidden
  release: forbidden
  create_or_delete_tag: forbidden

target_branches:
  - tmp/invalid-do-not-use
  - tmp/report-convergence
  - tmp/stop
  - build/task-0003-dispatch-guard
  - verify/task-0004-task0003
  - repair/task-0005-task0003

说明：本轮只允许删除上述 6 个 refs/heads。Agent 不创建新工作分支、不写 main、不创建/删除 tag、不 PR/merge/release。若用户级角色规则不可发现，可按 TASK-0007 的明确授权读取本仓库 exact ref 下的 `agent/AGENTS.md` 与 `agent/roles/RELEASE.md` 作为本次任务规则源。完成后返回报告给 Chat，由 Chat 收敛 durable report。