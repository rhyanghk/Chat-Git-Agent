# GitHub Relay Protocol

**Classification: L2 Targeted Reference.** 仅当任务 transport: github_relay 时适用。

## Preconditions

任务必须明确给出：PROJECT 编号、TASK 与 revision、repository、任务位置、base branch、work branch、完整同步范围、remote actions、scope、forbidden、acceptance 与报告位置。缺项即 forbidden。

## Incoming sync gate

1. 刷新远端引用；
2. 记录 live default branch、live main（如存在）、任务位置、base branch、work branch 和本地起点；
3. 同步完整声明项目树，不用局部 checkout；同步任务规定的 submodule 和 LFS；
4. 在隔离 clone 或 worktree 中工作；不得用 pull、reset、clean、stash 覆盖已有未知现场；
5. 任务记录或远端状态无法读取时返回 BLOCKED_REMOTE_SYNC；无法解释的变化返回 BLOCKED_REMOTE_DRIFT。

## Outgoing sync gate

1. 完成任务和验证；
2. 再次刷新远端；
3. 若指定工作分支有未解释推进，停止，不覆盖、不 force push；
4. 仅在 remote actions 明确允许时提交并回写该工作分支；
5. 回读远端项目结果和正式报告位置；
6. 提交 SUBMITTED 后停止等待验证与 Human 接受。

## Prohibitions

github_relay 不授权默认分支写入、merge、deploy、release、删除分支、重写历史、同步无关本地状态或写入通用框架资料。