# 节点能力盘点

用于新设备、新 Agent 环境、交接前，或 Human 明确要求时盘点“能不能做”。它不执行任务、不修改项目，也不产生授权。

~~~text
CAPABILITY_SELF_CHECK
---
scope: <current task pointer or node identity>
depth: <targeted | full>
report: <one formal result location | chat only when no formal task exists>
~~~

按顺序只盘点六项：

1. `runtime`：可确认的模型、版本或运行时标识；
2. `tools`：可用工具及必要版本；
3. `auth`：已登录、未登录或不可确认的状态，绝不输出 token；
4. `access`：目标项目与正式资料库的可读/可写状态；
5. `environment`：操作系统、网络、本地工作区与隔离能力；
6. `limits`：缺少工具、无网络、只读文件系统或 `unknown`。

结果格式：

~~~text
CAPABILITY_SELF_CHECK_REPORT
---
runtime: <known | unknown>
tools: <known | unknown>
auth: <authenticated | none | unknown>
access: <available | unavailable | unknown>
environment: <summary>
limits: <known limits | unknown>
status: <READY | BLOCKED | WAITING_FOR_HUMAN>
blockers:
  - <none | item>
~~~

能力只说明“可以做什么”，不说明“获准做什么”。需要进入当前任务时，仍必须通过 Bootstrap Check。

