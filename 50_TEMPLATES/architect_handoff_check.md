# 控制角色交接检查

用于接任 `Global Architect` 或 `Project Architect` 前的接收检查。它检查 AI 工作职责的连续性，不转移 Human 的决定权、组织权限或 GitHub 权限。

## 输入

~~~text
ARCHITECT_HANDOFF_CHECK
---
role: <Global Architect | Project Architect>
authority_store: <one formal location>
outgoing_record: <exact current-state or handoff record>
~~~

## 固定检查

1. Human 已明确指定接任角色和范围。
2. 交出方记录给出了当前项目、活跃事项、已冻结边界、风险和下一步的精确位置。
3. 接任方已从正式资料库读取当前实时记录，而不是依赖旧聊天。
4. 当前任务、项目状态和交接记录之间没有无法解释的冲突。
5. 同一项目没有并行 primary `Project Architect`，跨项目规则也没有并行 primary `Global Architect`。
6. 接任方已完成需要的 Bootstrap Check；新设备或环境还完成了 Capability Self Check。

## 结果

~~~text
ARCHITECT_HANDOFF_CHECK_RESULT
---
role: <Global Architect | Project Architect>
status: <PASS | BLOCKED>
verified_records:
  - <exact pointer>
blockers:
  - <none | missing or conflicting item>
~~~

通过前不得派发新任务、施工或接受结果。通过后使用 `architect_handoff_transaction.md` 写入接受记录。

