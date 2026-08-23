# Pointer Response — 指向正式资料的回应

**分层**：执行 Agent 层。

当聊天中出现本应存在于正式资料的任务知识，执行 Agent 应回指正式资料，而不是在聊天中维护第二份合同。

## Pointer 格式

所有 pointer 单独放在代码块中：

~~~text
task: TASK-000001-R001
authority_source: <one formal location>
~~~

GitHub 中继可补充：

~~~text
project: <owner/repository>
task_location: <exact numbered project location>
~~~

## 填空模板

~~~text
pointer: <formal task or record location>
聊天提供的内容: <what must be formalized>
应更新的正式对象: <TASK | DECISION | CHANGE>
正式化后下一步: <next action>
无法正式化时: BLOCKED
~~~

不得把聊天补充直接当作 scope、acceptance 或权限变更。