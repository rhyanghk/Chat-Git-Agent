# Chat Project Bootstrap

~~~text
CHAT_PROJECT_BOOTSTRAP
---
project: PROJECT-0001
human: <one human authority>
chat_role: <Global Architect | Project Architect>
platform: <ChatGPT Web | Claude Web | Claude Code Chat | Generic Chat>
authority_store: <one formal location>
project_inputs: <named project documents>
transport: <local | github_relay>
status: READY | BLOCKED | WAITING_FOR_HUMAN
~~~

Human 不是模型的可选 `chat_role`。模型角色未明确、项目未明确或 authority_store 不可访问时，状态为 BLOCKED；不得猜测或以执行 Agent 角色补位。

用途：建立或恢复协作控制项目。不得把业务仓库路径、Agent Skill 内容或完整聊天记录写入此模板。
