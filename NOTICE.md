# Notice

本仓以 `youling/ai-use` 为方法论来源，在 Apache License 2.0 下进行结构性适配。

适配内容包括：

- 将 GitHub 从全局强制事实源调整为按任务声明的 `github_relay`；
- 分离 Chat 协作控制项目、纯执行 Agent Skill 与业务项目仓；
- 保留角色治理，并为六个执行角色提供明确权限文件；
- 使用精确编号与 revision，拒绝内容哈希与防御性写入；
- 将 ChatGPT Web、Claude Web、Claude Code 控制会话与通用 Chat 的配置方法集中写入 `INSTALL.md`。

原项目版权与许可证文本保留于 `LICENSE`。

