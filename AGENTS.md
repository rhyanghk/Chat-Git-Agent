# 本仓维护规则

本文件只约束对 `Chat-Git-Agent` 本仓的维护 Agent：平台自动发现本文件，或维护任务明确列出本文件时生效。它不复制到业务项目，也不替代已安装的 `agent-executor` Skill。

## 授权与范围

- Human 决定目标、优先级、风险接受、验收、merge、deploy 和 release。
- 只执行精确编号任务；角色、scope、forbidden、acceptance、输入、报告位置或分支不明确时返回 `BLOCKED`。
- 不扩大任务、不猜测条件、不自行 merge、deploy、release、force push、删除分支、重写历史或破坏性清理。

## 本仓专属要求

- `PROJECT_INSTRUCTIONS.md` 必须保持短小，只路由 Chat；`CONTROL_RUNTIME.md` 是 Chat 端唯一的角色、流程和记录格式来源。
- `agent-executor` 只能包含执行 Agent 内容；不得加入 Chat 控制、派发、Human 决策或最终验收规则。
- 修改 `agent-executor/` 后，必须重新生成 `packages/agent-executor.skill`，验证包内源文件、无 Chat 内容和安装器的停止行为。
- 新增任何文件前，必须写明消费者、加载方式、触发条件和输出；不能明确时不新增。失去消费者的文件应并入实际入口或删除。
- 人类可见文字默认简体中文；代码、路径、命令和固定机器标识保留原样。

## 远端与报告

- 只有当前任务明确允许时才写入 `mainline/PROJECT-0001`；写前刷新远端并确认无未解释推进，写后回读。
- 不触碰默认分支、历史存档或业务项目资料，除非当前任务明确授权。
- 结果报告包含：任务编号和 revision、结果、交付、验证、剩余风险、下一步。

