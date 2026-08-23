# 任务变更请求

执行 Agent 发现当前合同必须变化时填写，然后停止。Project Architect 或已授权 Human 依据本记录创建新 revision。

~~~text
CHANGE-TASK-000001-R001-001
---
task: TASK-000001-R001
requested_change: <scope | role | baseline | transport | forbidden | acceptance | inputs | report | stop>
reason: <short factual reason>
impact: <what cannot safely continue>
requested_next_revision: TASK-000001-R002
status: <WAITING_FOR_HUMAN | WAITING_FOR_PROJECT_ARCHITECT>
~~~

