# 正式结果报告

执行 Agent 完成、阻塞或验证当前任务时，按任务指定的唯一报告位置写入。报告提交不等于 Human 接受。

~~~text
REPORT-TASK-000001-R001-BUILDER-001
---
task: TASK-000001-R001
role: Builder

结果
<what actually happened>

交付
<changed project files and one recoverable formal location>

验证
<commands/checks actually run and outcome; state 未验证 when applicable>

剩余风险
<known gaps, blockers, or none>

下一步
<Human or Architect action, or none>
~~~

不要写隐藏推理、完整聊天记录、内容哈希或第二份副本。写完后停止等待验收。

