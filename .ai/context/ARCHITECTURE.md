# 当前结构

状态：derived recovery snapshot
last_verified_ref: ab60238ba539bc13437c0ef928a7ce757e37ea1f
product_merge_ref: ac93e0676b6fb535c1c3c72d7300de6f9d3eab30
architecture_task_ref: dcfe78b21c5df6455f5c836a4e7a10ede5d86ab8

> 本文件只服务 Chat 的快速恢复与当前状态核验，不是项目本体的正式架构文档。正式架构文档由 ARCHITECT Agent 在项目文档目录维护；当前 TASK-0008 正在建立 `docs/ARCHITECTURE.md`、`docs/OPERATING_MODEL.md`、`docs/DISPATCH_PROTOCOL.md`。

## 当前产品结构

```text
README.md
INSTALL.md
USAGE.md
LICENSE
chat/
  CHAT_CORE.md
agent/
  AGENTS.md
  roles/
maintenance/
  UPSTREAM.md
  AUDIT.md
  CHANGELOG.md
release/
  v1.1.0/
.ai/
```

- `chat/`：提供给长期协调 Chat 安装的治理/协调规则；Chat 在业务项目只写 `.ai/**`。
- `agent/`：提供给 Agent 用户环境安装的通用执行规则和角色规则。
- `maintenance/`：维护 Chat-Git-Agent 自身与 upstream 的对齐、审计和变更历史；不进入业务项目。
- `release/`：当前本地/仓库中的发布候选包及校验材料；不等于已获正式 release 授权。
- `.ai/`：只记录 Chat-Git-Agent 自己的控制、任务、证据、恢复和交接状态；不能替代产品正式架构文档。

## 当前职责分层

```text
用户
  ↓ 目标 / 限制 / 最终决定
Chat
  ↓ 任务合同 / 派发 / 授权控制 / 验收
Agent（按未解决问题选择最少角色）
  ├─ RESEARCH：事实与方案证据
  ├─ ARCHITECT：项目本体架构 + 正式架构/设计文档 + 实现拆分
  ├─ BUILDER：落实已明确架构/范围的实现
  ├─ REPAIR：修复已确认问题
  ├─ VERIFIER：独立验收
  └─ RELEASE：执行被授权的 merge/deploy/release 阶段
  ↓
报告 / exact refs / tests / diff
  ↓
Chat 验收并收敛 `.ai/**`
```

当架构已经明确且任务边界简单时，Chat 可以直接派 BUILDER；当模块边界、接口、数据流、迁移或实现拆分尚不清楚时，必须先由 ARCHITECT 形成项目本体设计，不允许 Chat 用 `.ai/context/ARCHITECTURE.md` 代替正式技术架构。

## 当前任务控制流

```text
用户要求
→ Chat 读取当前 durable/live state
→ Chat 建立/修订 `.ai/tasks/TASK-xxxx.md`
→ Chat 回读 TASK；使用 Git 时取得 exact task_ref
→ Durable Dispatch/最小启动指针
→ Agent Remote Sync / Bootstrap
→ Agent 在隔离工作区执行
→ `.ai/reports/TASK-xxxx-<ROLE>.md` + diff/tests/exact refs
→ Chat 验收
→ 必要时下一角色（ARCHITECT → BUILDER → VERIFIER → RELEASE）
→ Chat 收敛 ACTIVE/CURRENT/context
```

当前产品尚未正式定义可跨 fresh Agent 稳定恢复的 Durable Dispatch/role-rule pointer 协议；TASK-0008 将给出设计，后续 BUILDER 落实。

## 业务项目边界

业务项目首次接入前不放 Chat-Git-Agent 通用文件。首次接入后只建立项目自己的 `.ai/`。

需要长期存在的业务项目正式技术文档（架构、接口、数据流、部署、迁移等）属于项目本体，由 ARCHITECT/BUILDER 按正式 TASK 维护在项目文档位置；`.ai/context/*.md` 只保留恢复所需的精简快照、长期决定和证据指针。

## 当前已确认风险

- fresh Agent 角色规则发现尚未 durable 化：当前产品要求角色规则必须读取，但通用 seed 未保证提供 exact role-rule pointer。
- Durable Dispatch 尚无正式稳定位置/协议；当前 TASK-0008 使用 `.ai/reports/TASK-0008-DISPATCH.md` 作为过渡性可恢复派发指针。
- `maintenance/AUDIT.md` 的历史 PASS 已被 live upstream audit 的 `NEEDS_REPAIR` 推翻；静态文档存在检查不能代替 cold-start 可执行验证。
- Bootstrap Check 的 durable evidence 语义需要在下一阶段实现中加强。
- Release 安装包的 LICENSE 分发检查需要修复；在新 live audit PASS 前不得进入正式 release。
- TASK-0006 原始 RELEASE Agent 报告仍未进入 durable source。
- 主流 Chat/Agent 平台安装入口会变化，平台特定说明必须定期按官方资料核验。

## 当前演进阶段

TASK-0008（ARCHITECT）先建立项目本体架构与 Builder 实施图；Chat 当前处于 `WAIT_AGENT_RESULT`，不会替 Agent 修改 `.ai/**` 之外的产品文件。ARCHITECT 结果经 Chat 验收后，再建立后续 BUILDER TASK 实施修复，必要时使用一个 fresh VERIFIER 独立验收。
