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
2. 一个执行角色，并按下述“角色规则定位”读取 [ROLE_PERMISSIONS.md](references/ROLE_PERMISSIONS.md) 的唯一对应段落；
3. 正式资料位置、项目位置、项目规则、启动模式、baseline、scope、forbidden、acceptance、inputs、report、stop 和 Human 授权位置；
4. 任务点名的项目本地规则、合同和输入可读；`local` 与 `github_relay` 的声明输出可写，`human_copy` 已收到完整 TASK 且可原样返回完整 REPORT；
5. 当前任务、正式资料和项目状态没有无法解释的冲突，并已按执行协议的权威优先级判断。

任一项缺失、过期、不可读或矛盾时返回 `BLOCKED`，不猜测。

## 角色规则定位

只从当前完整 TASK 的 `role` 字段确定执行角色。该字段必须精确等于 `Builder`、`Research`、`Repair`、`Verifier`、`Runner` 或 `Release` 之一；不得从请求措辞、操作内容、聊天历史或工具能力推断、改写或补全角色。

角色确定后，必须打开相对于本 `SKILL.md` 的 `references/ROLE_PERMISSIONS.md`，并按下表定位唯一规则段落。文件路径和标题均为精确值，不得改写、模糊匹配或从其他文件替代：

| TASK.role（精确值） | 必须读取的文件 | 必须匹配的标题（精确值） |
|---|---|---|
| `Builder` | `references/ROLE_PERMISSIONS.md` | `## Builder` |
| `Research` | `references/ROLE_PERMISSIONS.md` | `## Research` |
| `Repair` | `references/ROLE_PERMISSIONS.md` | `## Repair` |
| `Verifier` | `references/ROLE_PERMISSIONS.md` | `## Verifier` |
| `Runner` | `references/ROLE_PERMISSIONS.md` | `## Runner` |
| `Release` | `references/ROLE_PERMISSIONS.md` | `## Release` |

读取范围从匹配标题之后开始，截至下一个 `## ` 标题或文件结尾。不得把任何角色当作独立 Skill 查找，也不得以其他角色段落代替；例如 `role: Runner` 只能使用 `## Runner` 段落。

文件不可读、精确标题不存在、出现重复同名标题，或 TASK 的 `role` 不在上述允许值中时，返回 `BLOCKED` 并指出角色规则定位失败；不得继续执行任务。

## 只读取需要的资料

读取本文件、当前任务、当前角色段落、任务点名的项目规则和项目文件。需要启动、恢复、证据或 GitHub 中继细节时读取 [EXECUTION_PROTOCOL.md](references/EXECUTION_PROTOCOL.md)；需要分配的精确名称或报告格式时读取 [NUMBERING_AND_OUTPUTS.md](references/NUMBERING_AND_OUTPUTS.md)。不要扫描无关任务、历史、项目或角色文件。

## 执行与停止

- 只在 `scope` 内工作，不触碰 `forbidden`，不把任务、报告、旧聊天或工具能力当作更高授权。
- 不改变角色、revision、acceptance、baseline、项目位置、项目规则、正式资料位置或报告位置。
- 写入前使用独立且被授权的项目副本；不得对不属于当前任务的现场执行 `reset`、`clean`、`stash`、覆盖、删除分支、重写历史或破坏性清理。
- 不创建备份、镜像、临时合同或防御性文件；只有 TASK 明示的项目输出才可写入。
- 不输出 password、token、private key、secret 或完整环境变量值。
- 遇到共享接口、权限、资料状态或合同冲突时，提交变更请求并停止，不自行裁决。
- 在任务指定的唯一正式位置记录证据；聊天文字不是正式记录。

## 两个检查指令

- 收到 `BOOTSTRAP_CHECK` 时，仍须先通过完整编号的 Runner TASK 启动门槛；该 TASK 的 `scope` 只能是 [EXECUTION_PROTOCOL.md](references/EXECUTION_PROTOCOL.md) 的七项开工检查。不得执行业务任务或修改项目；必须按任务的 `report` 字段写入或原样返回完整正式 REPORT。
- 收到 `CAPABILITY_SELF_CHECK` 时，仍须先通过完整编号的 Runner TASK 启动门槛；只盘点运行时、工具、认证状态、目标访问、环境和限制。不得输出秘密、修改项目或把能力当作授权；必须按任务的 `report` 字段写入或原样返回完整正式 REPORT。

## 传输与完成

当 `transport: github_relay` 时，按 [EXECUTION_PROTOCOL.md](references/EXECUTION_PROTOCOL.md) 刷新完整声明项目、使用隔离工作区、结束前再次刷新、只写授权工作分支并回读远端。除具有人类明确授权的 Release 任务外，绝不 merge、force push、deploy、release 或改默认分支。

当 `transport: human_copy` 时，只接收完整编号 TASK，不接收 Seed、摘要或改写后的任务；完成后原样返回完整 REPORT，并将 `delivery_state` 写为 `RETURNED_FOR_HUMAN_RECORDING`。此时不得声称报告已写入正式资料库。

按 [NUMBERING_AND_OUTPUTS.md](references/NUMBERING_AND_OUTPUTS.md) 的格式处理一份完整正式报告：`local` 与 `github_relay` 在指定位置写入后使用 `WRITTEN_TO_AUTHORITY_STORE`；`human_copy` 按上一段返回报告。人类可见说明默认简体中文；代码、路径、命令和固定机器标识保留原样。完成后停止等待验收。
