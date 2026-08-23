# 开工检查请求

用于 Human 要求 Agent 只确认当前是否可以开始，不执行任务、不修改项目、不补充历史。

~~~text
BOOTSTRAP_CHECK
---
task: <TASK-xxxxxx-Rxxx | none>
role: <assigned role>
authority_store: <one formal location>
startup_mode: <fresh | resume>
report: <one formal result location | chat only when no formal task exists>
~~~

检查固定七项：角色、入口、授权、访问、当前任务、边界和当前状态。任一项不能确认时返回 `BLOCKED` 和缺失项；通过时只写检查结果，不开始实施。详见 `10_BOOT/BOOTSTRAP_CHECK_PROTOCOL.md`。

