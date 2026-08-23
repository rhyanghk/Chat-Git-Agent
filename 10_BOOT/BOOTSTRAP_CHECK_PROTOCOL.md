# Bootstrap Check Protocol

**Classification: L2 Targeted Reference.** 仅在启动、派发、恢复或任务明确要求时读取。

## 三层分工

| 层 | 职责 |
| --- | --- |
| Minimal Seed | 只寻址任务、角色和启动模式。 |
| Formal Task Record | 保存完整任务合同。 |
| Bootstrap Check | 在执行前验证身份、入口、权限、访问、任务、边界和状态。 |

## 固定七项

1. Identity：身份、角色、会话或节点无歧义。
2. Entry Point：可读取命名 authority source 和精确任务 revision。
3. Authority：当前角色拥有任务声明的最小权限。
4. Access：项目、资料和目标输出可读/可写，能力不等于授权。
5. Active Mission：当前精确任务和状态已确认。
6. Boundary：scope、forbidden、acceptance、stop 已读清。
7. State：authority source 与项目 live state 无未解释冲突。

任一失败即报告 BLOCKED，不执行任务、不修改项目。

github_relay 额外执行完整远端刷新与项目树同步；细节见 30_PROTOCOLS/GITHUB_RELAY_PROTOCOL.md。

Bootstrap 结果只写入任务声明的一个正式位置。不得为检查创建副本或额外状态文件。