# ChatGPT Web Adapter

在 ChatGPT Web 创建独立协作控制项目，不把业务代码仓作为该项目的资料目录。

导入项目级指令 PROJECT_INSTRUCTIONS.md、DATA_SOURCE_PROTOCOL.md、当前控制角色规则和当前项目控制资料。每次新会话先确认角色、当前项目、authority source 和当前任务编号。

ChatGPT Web 不承担本地 Agent Skill 执行。需要派发时输出 Minimal Agent Seed 或批准的任务模板，由 Human 复制到目标执行环境。

平台文件仅作为控制项目界面；若平台不能可靠保存版本历史，使用已指定的唯一正式资料库并在项目资料中维护当前编号。