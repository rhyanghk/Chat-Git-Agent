# 控制角色交接记录

Human 交接 `Global Architect` 或 `Project Architect` 时使用。本记录只转移 AI 工作流的协调职责，不转移 Human 的决定权、组织权限或 GitHub 权限。

~~~text
CONTROL_ROLE_HANDOFF
---
role: <Global Architect | Project Architect>
outgoing: <current role holder or none>
incoming: <new role holder>
governance_source: <one exact location>
authority_store: <one exact location>
current_state_record: <exact pointer>
human_authorization: <exact pointer>
checks:
  - <current project, active work, frozen boundaries, risks, next action are readable>
  - <no parallel primary role>
  - <new role has completed required startup or capability check>
status: <WAITING_FOR_CHECK | ACCEPTED | BLOCKED>
blockers:
  - <none | item>
~~~

只有所有检查通过后，接任模型才可派发新任务或收敛结果。聊天中的“我接任了”不构成交接。

