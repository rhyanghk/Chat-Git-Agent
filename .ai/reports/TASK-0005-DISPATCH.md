# TASK-0005 Dispatch

status: DISPATCHED
role: REPAIR
project: rhyanghk/Chat-Git-Agent
task: .ai/tasks/TASK-0005.md
task_revision: 2
report: .ai/reports/TASK-0005-REPAIR.md
startup_mode: fresh
task_ref: 0271b880778a3db6d915b3c083f5bb7443b98542

remote_sync_gate: REQUIRED
说明：Repair 开工前必须先刷新远端 refs，并确认 live main 包含上述 task_ref；不得以本地 checkout 看起来最新作为同步证据。同步失败报告 `BLOCKED_REMOTE_SYNC`，远端 task/ref 漂移无法安全解释报告 `BLOCKED_REMOTE_DRIFT`。允许 push 指定 Repair 工作分支；禁止 PR、merge、deploy、release、force push。
