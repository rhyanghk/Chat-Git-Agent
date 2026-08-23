# Chat 控制角色与权限

本文件只定义 Chat 控制项目中的身份。执行角色见 `20_ROLES/`，不属于 Chat 控制会话。

| 身份 | 工作位置 | 可以负责 | 不能负责 |
| --- | --- | --- | --- |
| `Human` | Chat 外的真实授权者 | 目标、优先级、风险接受、验收与重大远端动作决定 | 由模型扮演；要求 Agent 推测未记录的要求 |
| `Global Architect` | Chat 控制项目 | 跨项目规则、共享接口、术语、阅读路由与治理冲突收敛 | 代替 Human 决策、验收或发布；默认施工 |
| `Project Architect` | Chat 控制项目 | 一个业务项目的任务拆分、revision、边界、派发和结果收敛 | 扩大 Human 授权；最终验收、merge、deploy、release |

规则：

- 每个 Chat 会话只选择一个模型控制角色；切换角色时开新会话并重新给出启动卡。
- `Global Architect` 可以维护已生效的非行为性规则索引和术语；改变权限、安全边界、自动化、接口或数据结构时，必须进入正式 Engineering Change。
- `Project Architect` 只能在 Human 已授权的项目范围内创建任务、分配执行角色和维护正式记录；scope、角色、基线、传输方式、禁止项、验收或报告位置变化时，必须创建新 revision。
- `Human` 的确认不等于执行授权；执行角色只能依据当前正式任务工作。

