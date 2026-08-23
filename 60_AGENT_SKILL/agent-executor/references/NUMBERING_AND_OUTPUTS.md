# 编号与输出

仅在 Skill 需要创建工作位置或正式报告时读取。

~~~text
PROJECT-0001
TASK-000001-R001
WORK-TASK-000001-R001-BUILDER-001
REPORT-TASK-000001-R001-BUILDER-001.md
~~~

- 任务指定的编号分配者预先分配项目、任务、revision 和提交序号；Agent 只能使用任务已分配的编号。
- 合同变化才递增 revision；同一 revision 的新正式提交才递增角色提交序号。
- 不生成随机名、时间戳名、内容哈希、哈希命名或替代别名。
- GitHub 中继使用任务分配的精确分支名，例如 `work/TASK-000001-R001-BUILDER-001`。
- 正式报告固定顺序：任务编号和 revision、结果、交付、验证、剩余风险、下一步。
