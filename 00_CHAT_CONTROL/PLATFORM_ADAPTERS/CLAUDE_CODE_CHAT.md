# Claude Code Chat Adapter

当 Claude Code 用作 Chat 控制角色时，使用独立协作控制项目资料，而不是把业务代码工作区视为控制项目。

一次会话只选择一种身份：

- Chat 控制：加载本目录与控制资料，不加载 Agent Executor Skill，不直接施工；
- Agent 执行：重新以执行角色启动，加载 Agent Executor Skill、精确任务和任务列出的业务项目资料。

不得在同一会话混合起草任务、执行代码、评审自己和接受结果。