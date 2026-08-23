> **适配状态：PROFILE-0001。** 本文件完整保留原始方法论的结构与内容连续性，
> 但其现行解释以 `CONSTITUTION.md`、`docs/AGENT_INTERFACE.md`、
> `30_PROTOCOLS/CONTROL_RECORDS.md`、`30_PROTOCOLS/GITHUB_RELAY_PROTOCOL.md` 为准。
> 本仓不把 GitHub 设为所有项目的强制事实源；不使用内容哈希或防御性写入；
> Chat 控制与 Agent 执行严格分离。

# 10_BOOT

启动路由层。

职责：

- 确认下一步所需上下文；
- 避免全仓扫描；
- 保持渐进式上下文加载。

相关协议：

- Bootstrap Check（`BOOTSTRAP_CHECK_PROTOCOL.md`）
- Workspace Bootstrap（`WORKSPACE_BOOTSTRAP_PROTOCOL.md`）
- 渐进式上下文启动（`../docs/PROGRESSIVE_CONTEXT_BOOT.md`）
