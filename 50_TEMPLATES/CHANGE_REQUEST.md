# Change Request

~~~text
CHANGE-TASK-000001-R001-001
---
task: TASK-000001-R001
requested_change: <scope | role | baseline | transport | forbidden | acceptance | inputs | report | stop>
reason: <short factual reason>
impact: <what cannot safely continue>
requested_next_revision: TASK-000001-R002
status: WAITING_FOR_HUMAN | WAITING_FOR_PROJECT_ARCHITECT
~~~

执行角色提出后停止。只有控制角色在权限范围内创建新 revision。