# Numbering and Naming Protocol

所有正式对象使用固定宽度编号。禁止随机名、时间戳名、内容哈希、哈希命名和随意别名。

~~~text
PROJECT-0001
TASK-000001-R001
DISPATCH-TASK-000001-R001
WORK-TASK-000001-R001-BUILDER-001
REPORT-TASK-000001-R001-BUILDER-001.md
DECISION-000001-R001
EVIDENCE-TASK-000001-R001-001
~~~

规则：

- primary Project Architect 是唯一编号分配者；
- revision 只在合同改变时递增；不得原地改写活跃 revision；
- role submission 只在同一 revision 的新正式提交时递增；
- Agent 只能使用任务已分配的编号；
- 项目 GitHub 分支采用任务声明的精确名字，例如 task/TASK-000001-R001 与 work/TASK-000001-R001-BUILDER-001。

编号是协议身份；正式资料位置是恢复入口。