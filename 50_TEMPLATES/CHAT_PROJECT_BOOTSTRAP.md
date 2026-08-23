# Chat 控制项目启动记录

建立或恢复一个 Chat 协作控制项目时填写。它只登记入口和指针，不复制项目控制记录、业务代码或 Skill 内容。

~~~text
CHAT_PROJECT_BOOTSTRAP
---
project: PROJECT-0001
human: <one real human authority>
chat_role: <Global Architect | Project Architect>
platform: <ChatGPT Web | Claude Web | Claude Code control workspace | Generic Chat>
authority_store:
  type: <database | document_store | connected_source | project_repository | github_relay>
  location: <one exact URL, path, source name, or query route>
  access: <how this Chat reads it>
current_record: <exact project, task, decision, or none>
transport: <local | github_relay>
status: <READY | BLOCKED | WAITING_FOR_HUMAN>
~~~

`Human` 不是可选 `chat_role`。模型角色、项目、正式资料库或读取方式不可确认时，状态为 `BLOCKED`；不得以执行 Agent 身份补位。当前事项变化时，提供新的精确指针，而不是修改或复制整套资料。

