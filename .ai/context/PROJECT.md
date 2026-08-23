# 项目说明

last_verified_ref: ab60238ba539bc13437c0ef928a7ce757e37ea1f
product_merge_ref: ac93e0676b6fb535c1c3c72d7300de6f9d3eab30
architecture_task_ref: dcfe78b21c5df6455f5c836a4e7a10ede5d86ab8

## 用途

Chat-Git-Agent 提供一套长期的人机协作治理与执行规则：Chat 负责理解用户目标、维护约束/决定、建立任务合同、派发与验收、保存 `.ai/**` 可恢复控制状态；专职 Agent 负责项目本体的研究、架构、实现、修复、验证和发布阶段工作。

`.ai/**` 是协调与恢复控制面，不是项目正式架构文档。项目本体架构应由正式 `ARCHITECT` TASK 产出并维护在项目文档中；当前该能力正在 TASK-0008 中建立。

## 已确认的长期限制

- 用户可见说明优先使用通俗简体中文；普通目录和文件名使用英文。
- Chat 规则只安装在 Chat。
- Agent 通用规则和角色规则只安装在 Agent 用户环境；业务项目不预装通用规则。
- 业务项目首次接入后只建立项目自己的 `.ai/` 控制/恢复状态。
- GitHub 只用于同步和版本记录；没有 GitHub 时本地流程仍需可运行，但不得伪造 GitHub exact ref。
- Chat 在业务项目只写 `.ai/**`；项目本体架构文档由 ARCHITECT Agent 在正式任务范围内创建/维护，产品实现由 BUILDER/REPAIR 执行。
- 项目跟随 `youling/ai-use` 采用“精确提交 + 作用对应 + 手动审计”，不自动覆盖用户已接受边界。
- merge、deploy、release 分别受独立用户授权和 RELEASE TASK 控制。

## 主要入口

当前产品入口：

- `README.md`
- `INSTALL.md`
- `USAGE.md`
- `chat/CHAT_CORE.md`
- `agent/AGENTS.md`
- `agent/roles/`
- `maintenance/UPSTREAM.md`
- `maintenance/AUDIT.md`

当前控制/恢复入口：

- `.ai/INDEX.md`
- `.ai/tasks/ACTIVE.md`
- `.ai/handoff/CURRENT.md`
- `.ai/context/DECISIONS.md`

正式项目架构文档目前尚未存在；TASK-0008 要求建立：

- `docs/ARCHITECTURE.md`
- `docs/OPERATING_MODEL.md`
- `docs/DISPATCH_PROTOCOL.md`

在这些文件由 Agent 交付并经 Chat 验收前，不把它们视为当前事实。

## 外部来源

当前 upstream 对齐基线：

```text
youling/ai-use@1ddfeb0dd6a606dbc80ab86de8903d6888077bc6
```

最新 live upstream audit：

```text
.ai/reports/UPSTREAM-AUDIT-2026-08-22-CHAT.md
result: NEEDS_REPAIR
```

## 当前发布与修复状态

- v1.1.0 产品内容已通过正常双父 merge 进入 `main`，merge ref：`ac93e0676b6fb535c1c3c72d7300de6f9d3eab30`。
- `release/v1.1.0/` 中已有 ZIP/manifest/SHA256，但当前 upstream alignment 为 `NEEDS_REPAIR`，且审计发现安装 ZIP 的 LICENSE 分发检查需要修复，因此不得把历史 Release Audit PASS 视为 live release 许可。
- release、deploy、tag 未授权。
- TASK-0006 的 merge 已验收，但 `.ai/reports/TASK-0006-RELEASE.md` 原始 Agent 报告仍缺失，任务保持未完全收敛。
- TASK-0008 已派发 ARCHITECT，目标是建立正式项目架构文档、更新 ARCHITECT 职责，并为 durable dispatch、role discoverability、cold-start、Bootstrap、live audit、LICENSE/release package 等问题形成下一阶段 Builder 的可执行设计。
