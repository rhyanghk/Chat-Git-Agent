# 控制角色交接记录

本模板将控制角色的交出和接任写入唯一正式资料库。它只记录 AI 工作流职责，不转移 Human 的目标、风险接受、验收、组织权限或 GitHub 权限。

## 发起记录

~~~text
ARCHITECT_HANDOFF_REQUEST
---
role: <Global Architect | Project Architect>
outgoing: <current role holder or none>
incoming: <new role holder>
authority_store: <one formal location>
scope: <project or cross-project boundary>
current_state_record: <exact pointer>
human_authorization: <exact pointer>
status: <WAITING_FOR_CHECK | BLOCKED>
~~~

## 接任记录

只有 `architect_handoff_check.md` 的结果为 `PASS` 时才能写入：

~~~text
ARCHITECT_HANDOFF_ACCEPTED
---
role: <Global Architect | Project Architect>
incoming: <new role holder>
authority_store: <one formal location>
handoff_request: <exact pointer>
handoff_check: <exact PASS pointer>
current_state_record: <exact pointer>
status: <ACCEPTED | BLOCKED>
~~~

仅有聊天中的“我接任了”不构成交接。接任后仍需按当前任务和角色边界工作。

