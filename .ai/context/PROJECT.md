# 项目说明

last_verified_ref: 2c7373959dabb2f2d1329b890b477e3e1ed81150
product_merge_ref: ac93e0676b6fb535c1c3c72d7300de6f9d3eab30
architecture_decisions:
  - D-011
  - D-012
builder_task_ref: e2ce33c1c05b87ef7b7d7314b5b9119f6c9a8855

## 用途

Chat-Git-Agent 提供一套长期的人机协作治理与执行规则：主协调 Chat 负责理解用户目标、维护约束/决定、**承担项目架构功能**、建立任务合同、派发与验收、保存 `.ai/**` 可恢复控制状态；专职 Agent 负责研究、实现、修复、独立验证和被授权的发布阶段工作。

`ARCHITECT` 不再是独立 Agent role。架构判断、模块/接口/数据流/依赖/演进方案和正式架构文档内容由 Chat 负责；根据 D-005，Chat 仍只直接写业务项目 `.ai/**`，因此 `.ai/**` 之外的正式 docs、规则、代码和配置由 BUILDER/REPAIR 按 Chat 已确定架构实体化。

## 已确认的长期限制

- 用户可见说明优先使用通俗简体中文；普通目录和文件名使用英文。
- Chat 规则只安装在 Chat。
- Agent 通用规则和角色规则只安装在 Agent 用户环境；业务项目不预装通用规则。
- 业务项目首次接入后建立项目自己的 `.ai/` 控制/恢复状态；新架构将增加 task-specific `.ai/dispatch/`，只保存 pointer，不复制通用规则正文。
- GitHub 只用于同步和版本记录；没有 GitHub 时本地流程仍需可运行，但不得伪造 GitHub exact ref。
- Chat 在业务项目只写 `.ai/**`；项目产品文件由 Agent 执行，Chat 最终验收。
- 可派发 Agent 角色目标集合：`RESEARCH / BUILDER / REPAIR / VERIFIER / RELEASE`。
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
- `.ai/context/ARCHITECTURE.md`
- `.ai/dispatch/TASK-0009-BUILDER.md`

正式项目架构文档目前尚未存在；TASK-0009 BUILDER 将按 Chat 架构基线实体化：

- `docs/ARCHITECTURE.md`
- `docs/OPERATING_MODEL.md`
- `docs/DISPATCH_PROTOCOL.md`

在这些文件由 Builder 交付并经 Chat 验收前，不把它们视为当前产品事实。

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

## 当前修复状态

- v1.1.0 产品内容已通过正常双父 merge 进入 `main`，merge ref：`ac93e0676b6fb535c1c3c72d7300de6f9d3eab30`。
- 历史 v1.1.0 包缺 LICENSE，且旧 Audit PASS 已被 live `NEEDS_REPAIR` 推翻，不能作为新的 release-ready 证据。
- TASK-0008 独立 ARCHITECT Agent 模型已在执行前被 D-011 废止。
- TASK-0009 revision 2 已派发 BUILDER，目标是把 ARCHITECT-as-Chat、正式项目 docs、Durable Dispatch、minimal seed、Bootstrap/cold-start/audit/LICENSE 修复实体化。
- TASK-0006 的 merge 已验收，但 `.ai/reports/TASK-0006-RELEASE.md` 原始 Agent 报告仍缺失，任务保持未完全收敛。
- release、deploy、tag 未授权。
