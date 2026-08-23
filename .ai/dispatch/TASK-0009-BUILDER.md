# TASK-0009 BUILDER Durable Dispatch

dispatch_id: TASK-0009-BUILDER-r2
status: DISPATCHED
role: BUILDER
project: rhyanghk/Chat-Git-Agent
startup_mode: fresh

task: .ai/tasks/TASK-0009.md
task_revision: 2
task_ref: e2ce33c1c05b87ef7b7d7314b5b9119f6c9a8855
report: .ai/reports/TASK-0009-BUILDER.md
work_branch: build/task-0009-chat-architecture-repair

common_rule: agent/AGENTS.md
common_rule_ref: rhyanghk/Chat-Git-Agent@e2ce33c1c05b87ef7b7d7314b5b9119f6c9a8855:agent/AGENTS.md
role_rule: agent/roles/BUILDER.md
role_rule_ref: rhyanghk/Chat-Git-Agent@e2ce33c1c05b87ef7b7d7314b5b9119f6c9a8855:agent/roles/BUILDER.md

architecture_decisions:
  - .ai/context/DECISIONS.md#D-011
  - .ai/context/DECISIONS.md#D-012
architecture_baseline: .ai/context/ARCHITECTURE.md
access: github-public
remote_sync_gate: REQUIRED

remote_actions:
  push_work_branch: allowed
  open_pr: forbidden
  merge: forbidden
  deploy: forbidden
  release: forbidden

user_authorized_actions:
  - push_work_branch

bootstrap_evidence: .ai/reports/TASK-0009-BOOTSTRAP.md

说明：本 dispatch 不保存包含自身的 commit SHA。给 Agent 的 minimal seed 必须使用创建本文件后得到的 exact `<repo>@<commit>:<path>` pointer。Agent 先读取本 dispatch，再读取 exact common/role rules 与 TASK revision，并在实施前写 durable Bootstrap evidence。
