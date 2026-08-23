# Chat-Git-Agent Architecture

本仓的当前架构是一个**通用协作控制与执行 Skill 分发仓**。它不包含业务应用代码，也不承担业务项目的运行时。

## 当前项目构成

~~~text
Chat-Git-Agent
├── 00_CHAT_CONTROL/          Chat 协作控制项目资料
├── 00_KERNEL/                稳定规则入口与语言政策
├── 10_BOOT/                  启动与恢复协议
├── 20_ROLES/                 执行角色的职责边界
├── 30_PROTOCOLS/             编号、记录、仓库与 GitHub 中继协议
├── 40_GUIDES/                冷启动验证入口
├── 50_TEMPLATES/             正式任务与报告模板
├── 60_AGENT_SKILL/
    ├── agent-executor/       唯一可安装的执行 Skill
    ├── packages/             agent-executor.skill 分发包
    └── scripts/              安装与打包命令
└── docs/                     渐进启动、会话生命周期与中立 Agent 接口
~~~

`00_CHAT_CONTROL/` 与 `60_AGENT_SKILL/agent-executor/` 有意分开：前者用于 Chat 控制，后者用于 Agent 执行。业务项目仓库位于本仓之外，并且只接收其自身的资料。

## 实际协作流

~~~text
Human
  │  目标、优先级、风险、验收与重大远端动作决定
  ▼
Chat 协作控制项目
  │  Global Architect 或 Project Architect
  │  任务 / revision / decision / 最小派发 Seed
  ▼
独立 Agent 执行会话
  │  agent-executor + 一个执行角色 + 一个正式任务
  │  结果报告与证据
  ▼
业务项目仓库
~~~

Human 不由模型代替。Chat 模型不直接变为执行角色；执行 Agent 不创建任务、派发任务或接受结果。

## GitHub 关系

GitHub 仅在任务标记 `github_relay` 时作为项目资料与结果的中继端。该模式要求完整同步、隔离工作区、授权工作分支、回写和远端回读；它不会授权默认分支写入、merge、deploy 或 release。

没有 GitHub 时，控制项目和业务项目仍可以使用任务指定的本地正式资料源完成协作。

## 不变的写入边界

| 位置 | 允许保存 | 不允许保存 |
| --- | --- | --- |
| 本仓 | 通用控制资料、通用 Skill、平台安装器、协议和模板 | 业务代码、业务秘密、业务运行态 |
| Chat 协作控制项目 | 项目指令、控制角色、正式控制记录与人工派发资料 | 完整执行 Skill、业务实现 |
| Agent Skill 安装位置 | `agent-executor` 及其直接执行参考资料 | Chat 协调资料、业务项目全量资料 |
| 业务项目仓库 | 项目代码、项目约束、项目任务、项目报告与证据 | 本仓完整通用架构、完整 Agent Skill |
