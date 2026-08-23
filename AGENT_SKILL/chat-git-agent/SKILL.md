---
name: chat-git-agent
description: Default mandatory execution protocol for an explicitly assigned, numbered Builder, Research, Repair, Verifier, Runner, or Release task. Invoke automatically before every Agent request that reads, modifies, verifies, or runs a project, including resumed work, through local, GitHub-relay, or human-copy transport. Never use it to create or revise a task, dispatch work, accept a result, or decide governance.
---

# Chat-Git-Agent

## 默认执行入口

任何 Agent 请求只要将读取、修改、验证或运行项目，必须先调用本 Skill；即使请求没有点名 Skill 也一样。开始实际工作前必须读到完整精确编号 TASK。只有 Seed 时先据其位置读取 TASK；任务缺失、不可读、过期或冲突时只返回 `BLOCKED`。不得绕过本 Skill 直接处理项目。

只作为一个执行 Agent 工作。不得代表外部权威、创建或修订任务、派发任务、接受结果或决定治理事项。工具、仓库访问和历史消息只是能力，不构成授权。

## 开始门槛

开始前必须确认：

1. 精确任务编号和 revision，例如 `TASK-000001-R001`；
2. 一个执行角色，并读取 [ROLE_PERMISSIONS.md](references/ROLE_PERMISSIONS.md) 的对应段落；
3. 正式资料位置、启动模式、baseline、scope、forbidden、acceptance、inputs、report、stop 和 Human 授权位置；
4. 所需输入可读；`local` 与 `github_relay` 的声明输出可写，`human_copy` 已收到完整 TASK 且可原样返回完整 REPORT；
5. 当前任务与项目状态没有无法解释的冲突。

任一项缺失、过期、不可读或矛盾时返回 `BLOCKED`，不猜测。

## 只读取需要的资料

读取本文件、当前任务、当前角色段落和任务点名的项目文件。需要启动、恢复、证据或 GitHub 中继细节时读取 [EXECUTION_PROTOCOL.md](references/EXECUTION_PROTOCOL.md)；需要分配的精确名称或报告格式时读取 [NUMBERING_AND_OUTPUTS.md](references/NUMBERING_AND_OUTPUTS.md)。不要扫描无关任务、历史、项目或角色文件。

## 执行与停止

- 只在 `scope` 内工作，不触碰 `forbidden`。
- 不改变角色、revision、acceptance、baseline、正式资料位置或报告位置。
- 不创建备份、镜像、临时合同或防御性文件。
- 遇到共享接口、权限、资料状态或合同冲突时，提交变更请求并停止，不自行裁决。
- 在任务指定的唯一正式位置记录证据；聊天文字不是正式记录。

## 两个检查指令

- 收到 `BOOTSTRAP_CHECK` 时，只完成 [EXECUTION_PROTOCOL.md](references/EXECUTION_PROTOCOL.md) 的七项开工检查并报告；不执行业务任务、不修改项目。
- 收到 `CAPABILITY_SELF_CHECK` 时，只盘点运行时、工具、认证状态、目标访问、环境和限制；不输出秘密、不修改项目，也不把能力当作授权。

## 传输与完成

当 `transport: github_relay` 时，按 [EXECUTION_PROTOCOL.md](references/EXECUTION_PROTOCOL.md) 刷新完整声明项目、使用隔离工作区、结束前再次刷新、只写授权工作分支并回读远端。除具有人类明确授权的 Release 任务外，绝不 merge、force push、deploy、release 或改默认分支。

当 `transport: human_copy` 时，只接收完整编号 TASK，不接收 Seed、摘要或改写后的任务；完成后原样返回完整 REPORT，并将 `delivery_state` 写为 `RETURNED_FOR_HUMAN_RECORDING`。此时不得声称报告已写入正式资料库。

按 [NUMBERING_AND_OUTPUTS.md](references/NUMBERING_AND_OUTPUTS.md) 的格式处理一份完整正式报告：`local` 与 `github_relay` 在指定位置写入后使用 `WRITTEN_TO_AUTHORITY_STORE`；`human_copy` 按上一段返回报告。人类可见说明默认简体中文；代码、路径、命令和固定机器标识保留原样。完成后停止等待验收。
