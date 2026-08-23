# 本仓维护与默认 Agent 规则

本文件约束对 `Chat-Git-Agent` 本仓的维护 Agent。它不复制到业务项目，也不替代用户级安装的 `Chat-Git-Agent` Skill。无法隐式选择 Skill 的平台，必须使用 [INSTALL.md](INSTALL.md) 的用户级默认 Agent 规则；不得以业务项目的 `AGENTS.md` 承担这项通用规则。

## 授权与范围

- Human 决定目标、优先级、风险接受、验收、merge、deploy 和 release。
- 只执行精确编号任务；角色、项目位置、项目规则、scope、forbidden、acceptance、输入、报告位置或分支不明确时返回 `BLOCKED`。
- 不扩大任务、不猜测条件、不自行 merge、deploy、release、force push、删除分支、重写历史或破坏性清理。

## 本仓专属要求

- `PROJECT_INSTRUCTIONS.md` 必须保持短小，只路由 Chat；`CONTROL_RUNTIME.md` 是 Chat 端唯一的角色、流程和记录格式来源。
- `CONTROL_RUNTIME.md` 必须完整定义 authority_store、TASK、TASK-STATE、DECISION、REPORT、CHANGE 与交接的关系；不要在 README、安装说明或业务项目中复制第二套合同。
- `chat-git-agent` 只能包含执行 Agent 内容；不得加入 Chat 控制、派发、Human 决策或最终验收规则。
- Skill 元数据必须保持隐式调用开启；Skill 正文必须要求执行 Agent 在任何项目读取、修改、验证或运行前先读取精确编号 TASK。缺少合同一律 `BLOCKED`。
- 修改 TASK 合同字段、状态或权限边界时，必须同步 `CONTROL_RUNTIME.md`、Skill 引用、README 与 INSTALL，并验证两侧字段和报告名一致。
- 修改 `AGENT_SKILL/chat-git-agent/` 后，必须重新生成 `AGENT_SKILL/packages/Chat-Git-Agent.skill`，验证包内源文件、无 Chat 控制内容和安装器的停止行为。
- 新增任何文件前，必须写明消费者、加载方式、触发条件和输出；不能明确时不新增。失去消费者的文件应并入实际入口或删除。
- 人类可见文字默认简体中文；代码、路径、命令和固定机器标识保留原样。

## 远端与报告

- `main` 是当前项目主线；`mainline/PROJECT-0001` 保留为同一主线的引用。只有当前任务明确允许时才写入任一分支；写前刷新远端并确认无未解释推进，写后回读。
- 不触碰历史存档或业务项目资料，除非当前任务明确授权。
- 结果报告包含：任务编号和 revision、结果、交付、验证、剩余风险、下一步。
