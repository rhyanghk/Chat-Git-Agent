# Chat 控制项目启动记录

新建或恢复 Chat 协作控制项目时填写。它只登记来源和入口，不复制业务代码、可变项目记录或 Skill 内容。

~~~text
CHAT_PROJECT_BOOTSTRAP
---
project: PROJECT-0001
human: <one real human authority>
chat_role: <Global Architect | Project Architect>
platform: <ChatGPT Web | Claude Web | Claude Code control workspace | Generic Chat>
governance_source: <one exact location for this repository and templates>
authority_store: <one exact business-project formal location>
current_record: <exact task, decision, project record, or none>
transport: <local | github_relay>
status: <READY | BLOCKED | WAITING_FOR_HUMAN>
~~~

`Human` 不是可选 `chat_role`。角色、两个来源、项目或读取方式不可确认时，状态为 `BLOCKED`；不得以执行 Agent 身份补位。

