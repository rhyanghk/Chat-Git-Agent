# Agent Interface — Canonical L2 Reference

**Protocol Version: PROJECT-0001.** 仅在派发、执行、验证或回收任务时读取。

本文定义控制角色与执行角色之间的中立接口。它不要求某个具体 Chat 平台，也不把控制职责装入 Agent Skill。

## 1. Dispatch layers

每次派发分三层：

1. Formal Task Record：命名 durable authority source 中的完整合同。
2. Human Dispatch Card：给 Human 决策和调度的五字段说明。
3. Minimal Agent Seed：给执行 Agent 寻址的最小文本。

## 2. Formal Task Record

~~~text
TASK-000001-R001
---
role: Builder
startup_mode: fresh
authority_source: <one named location>
transport: local | github_relay
project: PROJECT-0001
scope: <owned work>
forbidden: <explicit prohibitions>
acceptance: <observable completion conditions>
inputs: <required project files and records>
report: REPORT-TASK-000001-R001-BUILDER-001.md
stop: <completion or blocked condition>
~~~

github_relay 任务还必须声明 repository、task reference、base branch、work branch、full sync profile 与 remote actions。任一远端动作字段缺失即 forbidden。

## 3. Human Dispatch Card

按顺序只保留五项：任务、为什么做、你要做什么、调度建议、本轮终点。调度建议只给 Human，不进入执行 Seed。

## 4. Minimal Agent Seed

默认三行：

~~~text
task: TASK-000001-R001
role: Builder
startup_mode: fresh
~~~

只有 pointer 不能无歧义解析时才增加最少 route 字段，例如 transport 或 authority_source。不得把 scope、acceptance、验证步骤、历史结论或调度建议复制进 Seed。

## 5. State

~~~text
DRAFT → APPROVED → DISPATCHED → ACKNOWLEDGED → IN_PROGRESS
      → SUBMITTED → VERIFIED → ACCEPTED → CLOSED
~~~

- Human 或已授权控制角色可创建、批准和派发。
- 执行角色最多提交 SUBMITTED；Verifier 可提交 VERIFIED 证据。
- 只有 Human 接受；Release 是另行授权的远端动作，不由 ACCEPTED 自动推导。

## 6. Completion Card

执行角色正式报告按以下顺序：任务编号和 revision、结果、交付、验证、剩余风险、下一步。

## 7. Boundary conditions

- 任务编号与 revision 是协议身份；不使用内容哈希。
- 正式记录只有一个任务声明位置；不创建副本、镜像或第二份合同。
- scope、role、baseline、transport、forbidden、acceptance、inputs、report 或 stop 变化时必须新 revision。
- 任务提交、验证、验收、merge、deploy 和 release 是不同权限动作。