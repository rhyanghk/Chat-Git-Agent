> **适配状态：PROFILE-0001。** 本文件完整保留原始方法论的结构与内容连续性，
> 但其现行解释以 `CONSTITUTION.md`、`docs/AGENT_INTERFACE.md`、
> `30_PROTOCOLS/CONTROL_RECORDS.md`、`30_PROTOCOLS/GITHUB_RELAY_PROTOCOL.md` 为准。
> 本仓不把 GitHub 设为所有项目的强制事实源；不使用内容哈希或防御性写入；
> Chat 控制与 Agent 执行严格分离。

# Language Policy

## 默认语言

所有**人类可见输出**默认使用**简体中文**，包括：

- Issue 正文与评论
- Comment
- Dispatch
- Review
- Report / 报告
- PR 描述
- 会话内面向人的说明

## 允许保留原文（英文/原文）的内容

仅限机器标识与不可翻译项：

- machine identifier
- code / 代码
- path / 路径
- command / 命令
- 原生版本标识
- protocol constant / 协议常量

## 判定

"是否人类可见"取决于内容是否面向人阅读。机器可读内容（代码、路径、命令、原生版本标识、
协议常量）不属于人类可见叙述，保留原文。人类可读的叙述一律简体中文。
