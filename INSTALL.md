# Installation and Use

本仓提供两种不同的安装/使用对象。不要把它们复制进业务项目仓库。

## Chat 控制项目

在 ChatGPT Web、Claude Web、Claude Code 的 Chat 使用方式或其他不能安装本地 Skill 的 Chat 中，创建一个独立协作控制项目，然后导入：

1. 00_CHAT_CONTROL/PROJECT_INSTRUCTIONS.md；
2. 00_CHAT_CONTROL/DATA_SOURCE_PROTOCOL.md；
3. 当前所选控制角色规则；
4. 当前项目的正式控制资料。

选择对应 00_CHAT_CONTROL/PLATFORM_ADAPTERS/ 文件完成平台适配。业务代码仓库不是此安装位置。

## Agent 执行 Skill

在支持本地 Skill 的 Agent 平台，将整个 60_AGENT_SKILL/agent-executor 目录安装到该平台支持的 Skill 目录。不要将该目录复制到业务项目仓库。

安装后，执行 Agent 只能在收到编号任务和对应角色后触发此 Skill。Chat 控制项目不得使用此 Skill 承担派发或架构职责。

## 业务项目

业务项目只接收与自身相关的项目资料：项目 README、架构、构建/测试入口、任务、项目报告和项目证据。通用治理资料通过本仓或平台项目引用，不复制。