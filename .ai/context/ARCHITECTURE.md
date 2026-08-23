# 当前结构与 Chat 架构基线

状态：derived recovery snapshot + accepted architecture baseline
last_verified_ref: 4de4244bc022be10699a92356bf001326c684b25
product_merge_ref: ac93e0676b6fb535c1c3c72d7300de6f9d3eab30
architecture_decisions:
  - D-011
  - D-012

> 本文件由主协调 Chat 维护，用于快速恢复当前架构事实与下一阶段实施规格。它不是面向最终用户的正式项目文档；正式 `docs/**` 由 Builder 按本基线实体化。架构判断和内容归 Chat，产品文件写入归被派发的 Agent。

## 1. 目标架构

Chat-Git-Agent 分成四个逻辑层：

```text
Human authority
    ↓
Chat control + architecture plane
    ↓ durable TASK / DISPATCH / decisions / acceptance
Agent execution plane
    ↓ diff / tests / reports / exact refs
Project + Git durable state
```

### Human authority

用户保留目标、优先级、验收标准、风险接受、merge、deploy、release 的最终决定权。

### Chat control + architecture plane

Chat 同时承担：

1. 治理/协调：恢复项目、维护长期约束与决定、建立 TASK、派发执行角色、权限控制、验收、交接、`.ai/**` 收敛；
2. 架构：定义模块边界、接口、数据流、依赖、运行边界、技术约束、迁移/演进方案、实现拆分和正式架构文档的内容。

Chat 仍受 D-005 约束，只直接写业务项目 `.ai/**`。正式项目文档、规则、代码、配置和测试由 Builder/Repair 实体化，避免 Chat 自己完成“架构 → 修改产品 → 自我验收”全链路。

### Agent execution plane

可派发 Agent 角色收敛为五个：

- `RESEARCH`：补事实和方案证据；
- `BUILDER`：按 Chat 已确定的需求/架构实施产品文件；
- `REPAIR`：修已确认问题；
- `VERIFIER`：独立验收；
- `RELEASE`：执行被单独授权的 merge/deploy/release。

`ARCHITECT` 不再是 Agent role。

## 2. 产品目标结构

```text
README.md
INSTALL.md
USAGE.md
LICENSE
docs/
  ARCHITECTURE.md
  OPERATING_MODEL.md
  DISPATCH_PROTOCOL.md
chat/
  CHAT_CORE.md
agent/
  AGENTS.md
  roles/
    BUILDER.md
    RESEARCH.md
    REPAIR.md
    VERIFIER.md
    RELEASE.md
maintenance/
  UPSTREAM.md
  AUDIT.md
  CHANGELOG.md
  COLD_START.md
release/
.ai/
```

`agent/roles/ARCHITECT.md` 应从可安装/可派发角色集合退役；最终产品不得再把它暴露成 Agent role。

## 3. 业务项目 `.ai` 控制面目标

在现有结构上增加 task-specific Durable Dispatch：

```text
.ai/
├─ INDEX.md
├─ context/
├─ tasks/
├─ dispatch/
│  └─ TASK-xxxx-<ROLE>.md
├─ reports/
└─ handoff/
```

`dispatch/` 只保存当前业务项目的任务派发元数据和规则 pointer，不复制通用 Agent 规则或角色正文，因此不破坏“业务项目零预装”。

## 4. Durable Dispatch 设计

每个 Agent TASK 在启动前必须有 durable dispatch artifact。最低字段：

```text
dispatch_id
task
task_revision
role
project
startup_mode
report
common_rule
role_rule
```

使用 Git/GitHub 时，dispatch artifact 再保存：

```text
task_ref
common_rule_ref
role_rule_ref
access
```

**exact dispatch pointer 不写入 dispatch 文件自身。** 根据 D-012，它由 minimal seed 或外部派发记录提供，例如：

```text
rhyanghk/project@<commit>:.ai/dispatch/TASK-0009-BUILDER.md
```

这是为了避免 commit SHA 的哈希自引用。

要求：

- `common_rule` / `role_rule` 必须是本轮实际可解析的 durable/exact pointer；不得只写 `role: BUILDER` 然后依赖用户记忆角色文件在哪里。
- GitHub 模式优先 exact `<repo>@<commit>:<path>`。
- local-only 模式记录 Agent 环境中已安装规则的可解析绝对路径或平台原生 identifier，并记录本地核验标记；不能伪造 GitHub ref。
- 业务项目中不复制通用 `AGENTS.md` 或 `roles/*.md`。
- TASK 合同变化导致 revision+1 时，旧 dispatch 失效，必须产生新 dispatch/exact pointer。

## 5. Minimal Seed

给 Agent 的可见启动提示只负责定位 durable dispatch，目标形态：

```text
dispatch: <exact durable dispatch pointer>
startup_mode: fresh | resume
```

若平台首次访问需要额外 route/access hint，只加 bootstrap-critical 最小字段；TASK 正文、scope、验收清单、角色规则正文、模型/时间建议不得复制进 seed。

Agent 启动路径：

```text
Seed
→ exact Durable Dispatch pointer
→ common rule + role rule
→ exact TASK revision
→ Bootstrap Check
→ execution
```

## 6. Bootstrap durable evidence

Bootstrap Check 不能只在聊天里返回“已确认”。Agent 开工前至少核对：

1. role；
2. dispatch entry；
3. authority；
4. access；
5. exact active task/revision；
6. scope/forbidden/acceptance；
7. current live state。

结果必须进入 durable evidence，例如 `.ai/reports/TASK-xxxx-BOOTSTRAP.md` 或 dispatch 指定的同等位置。缺任一关键项时 `BLOCKED`。

## 7. Cold-start 验收

Release Audit 不能再只检查“文档里写了这些规则”。新的 live PASS 至少要求一次 fresh Agent 验证：

```text
只给 minimal seed
→ 能读取 exact durable dispatch pointer
→ 能取得 common rule + exact role rule
→ 能读取 exact TASK revision
→ 能完成 Bootstrap Check
→ 能写 durable bootstrap/result evidence
```

实际 fresh-Agent 证据 pointer 必须进入本轮 audit；没有该证据，只能 `NOT_VERIFIED/NEEDS_REPAIR`，不得静态推导 PASS。

## 8. Upstream compatibility 分类

### MUST_REPAIR

- fresh Agent role-rule discoverability；
- Durable Dispatch 正式位置/协议；
- minimal seed 只寻址；
- Bootstrap durable evidence；
- cold-start executable validation；
- live audit 不得沿用历史 PASS；
- stale `.ai` snapshot 防护；
- Release 包 LICENSE 分发检查；
- 产品仍暴露独立 ARCHITECT Agent 的旧模型。

### INTENTIONAL_DIVERGENCE

- Chat/Agent 用户级安装、业务项目零预装；
- GitHub 可选，本地流程仍可运行；
- 不强制 upstream 多仓 Workspace Registry；
- 简化 handoff 状态模型。

这些只能描述为 intentional divergence / semantic adaptation，不得声称 upstream full protocol parity。

## 9. 正式项目文档分工

Builder 应根据本 Chat 架构基线创建：

- `docs/ARCHITECTURE.md`：稳定产品架构、分层、组件、控制流、durable state、运行/安装边界、兼容策略；
- `docs/OPERATING_MODEL.md`：Human / Chat / RESEARCH / BUILDER / REPAIR / VERIFIER / RELEASE 职责矩阵和生命周期；
- `docs/DISPATCH_PROTOCOL.md`：TASK → durable dispatch → seed → bootstrap → execution → report 的正式协议。

`.ai/context/ARCHITECTURE.md` 继续只保存当前恢复快照、架构决定和正式文档 pointer；以后正式 docs 与实现冲突时先核验 live implementation，再刷新快照。

## 10. Builder 实施文件图

下一阶段 Builder 至少处理：

- `chat/CHAT_CORE.md`：加入 Architecture Function；移除独立 ARCHITECT Agent 派发模型；定义 `.ai/dispatch/` 和 durable dispatch gate。
- `agent/AGENTS.md`：角色集合收敛为五个；以 durable dispatch 为启动入口；Bootstrap 必须 durable 留痕。
- `agent/roles/ARCHITECT.md`：退役/删除，并清理所有产品引用。
- `README.md` / `USAGE.md` / `INSTALL.md`：更新职责、角色和启动接口。
- `docs/ARCHITECTURE.md` / `docs/OPERATING_MODEL.md` / `docs/DISPATCH_PROTOCOL.md`：创建正式项目文档。
- `maintenance/UPSTREAM.md`：更新作用映射和 intentional divergence。
- `maintenance/AUDIT.md`：历史 PASS 与 live PASS 分离；无 fresh cold-start evidence 不得 PASS；加入 LICENSE 检查。
- cold-start 验证入口/记录：提供明确的 fresh Agent 验证协议与 evidence pointer。
- Release policy：分发包必须包含 `LICENSE`，不得包含 ARCHITECT Agent 文件；现有 v1.1.0 缺 LICENSE 的包只能作为历史证据，在用户决定新版本前不擅自创建 tag/release。

## 11. 当前未收敛事项

- TASK-0006 原始 `.ai/reports/TASK-0006-RELEASE.md` 仍缺失；不能由 Chat/Builder 伪造。
- 当前 `maintenance/AUDIT.md` 历史 PASS 已失效。
- release/deploy/tag 未授权。

## 12. 执行顺序

```text
Chat 架构基线（D-011 + D-012 + 本文件）
→ BUILDER 实体化规则/正式 docs/durable dispatch/audit/package policy 修复
→ Chat 验收实际 diff/tests/evidence
→ fresh VERIFIER 做独立 cold-start + upstream alignment 验证
→ Chat 收敛 .ai
→ 如需 merge/release，再分别取得用户授权并建立 RELEASE TASK
```
