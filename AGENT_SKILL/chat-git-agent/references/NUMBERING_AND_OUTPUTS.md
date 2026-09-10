# 编号与输出

长任务阶段报告使用 TASK 的 `checkpoint_reports` 预分配位置与序号，最终报告仍用 `report`；不得覆盖旧阶段或自己分配编号。写入失败/回读未知允许 `delivery_state: NOT_WRITTEN`，失败处理遵循 EXECUTION_PROTOCOL，不冒充 WRITTEN_TO_AUTHORITY_STORE 或 RETURNED_FOR_HUMAN_RECORDING。

仅在 Skill 需要创建工作位置或正式报告时读取。

~~~text
project_id: <opaque control identifier assigned by the control layer>
TASK-000001-R001
WORK-TASK-000001-R001-BUILDER-001
REPORT-TASK-000001-R001-BUILDER-001.md
~~~

- 任务指定的编号分配者预先分配项目、任务、revision 和提交序号；Agent 只能使用任务已分配的编号。
- 合同变化才递增 revision；同一 revision 的新正式提交才递增角色提交序号。
- 不生成随机名、时间戳名、内容哈希、哈希命名或替代别名。
- GitHub 中继使用任务分配的精确分支名，例如 `work/TASK-000001-R001-BUILDER-001`。
- `BOOTSTRAP_CHECK` 与 `CAPABILITY_SELF_CHECK` 使用 scope 仅限检查的 Runner TASK 和同一命名规则的 REPORT；不得创建未编号的检查结论。
- 正式报告固定顺序：报告编号、`task`、`role`、`delivery_state`、结果、交付、验证、剩余风险、下一步。
- “验证”内按 [EXECUTION_PROTOCOL.md](EXECUTION_PROTOCOL.md) 的“输入与证据边界”记录生成规则版本与来源覆盖；不增加或省略报告必需章节，不改写旧报告的版本。
- `local` 与 `github_relay` 在报告已写入任务指定正式位置后使用 `delivery_state: WRITTEN_TO_AUTHORITY_STORE`；`human_copy` 使用 `delivery_state: RETURNED_FOR_HUMAN_RECORDING`，由任务指定的记录者原样写入正式资料库。Agent 不改写该状态或声称已完成记录。
