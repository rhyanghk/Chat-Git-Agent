# TASK-0006 Dispatch

status: DISPATCHED
role: RELEASE
project: rhyanghk/Chat-Git-Agent
task: .ai/tasks/TASK-0006.md
task_revision: 1
report: .ai/reports/TASK-0006-RELEASE.md
startup_mode: fresh
task_ref: 8762b17d5950620911107c17ecb4ab18560a631d

accepted_work_ref: 56815df11a80a8682f63c2fbfee9dd99af4dd3a6
remote_sync_gate: REQUIRED
remote_actions:
  push_work_branch: allowed
  open_pr: forbidden
  merge: allowed
  write_default_branch: allowed_for_merge_only
  deploy: forbidden
  release: forbidden
  create_tag: forbidden
user_authorized_actions:
  - merge

说明：用户仅授权 merge。RELEASE Agent 必须先刷新远端并确认 live main 包含上述 task_ref，再以精确 accepted_work_ref 做正常非 force merge。merge 后回读 main exact ref 并停止；不得 PR、deploy、release、tag、force push 或重写历史。