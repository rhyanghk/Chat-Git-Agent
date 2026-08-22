# Latest Upstream Alignment Audit

executor: current_chat
checked_date: 2026-08-22
upstream_ref: youling/ai-use@1ddfeb0dd6a606dbc80ab86de8903d6888077bc6
project_main_at_audit: a5382f663f359217e9a6d7616a985ab8c2102af6
result: NEEDS_REPAIR

## 结论

当前项目不是 ai-use 的目录镜像，而是精简适配。Human sovereignty、evidence > self-report、单一主协调、最低足够验证、durable trace、能力不等于授权等核心治理语义仍基本对齐；但当前 Agent 派发接口存在真实阻塞级缺口，因此旧 `maintenance/AUDIT.md` 的 PASS 不再能代表 live main。

## 已满足

- 用户对目标、验收、风险、merge/deploy/release 保留最终权威。
- Chat/Agent 建议不能静默升级成用户要求；工具能力不产生授权。
- Agent 结果必须有 durable report / exact ref；验证证据高于自评。
- 低风险可 Chat 直接验收，普通复杂/高风险最多一个 fresh Verifier；多验证只用于真实 Incident。
- Remote Sync Gate 与 Remote Action Gate 强化了 live-ref 与 authority 边界，和 upstream 原则兼容。
- v1.1.0 产品候选已正常双父 merge 到 main；历史 Builder/Verifier/Repair 报告均已收敛到 main。

## 阻塞级缺口

1. 当前有效项目规则要求项目内 `.ai/agents/STARTUP.md`、`.ai/agents/roles/<ROLE>.md`、`.ai/agents/prompts/TASK-xxxx-<ROLE>.md`，但 live main 的 `.ai/` 没有 `agents/` 目录。
2. 当前产品仍依赖 Agent 用户环境中的角色文件；真实 TASK-0006 曾触发 `BLOCKED_RULES_UNAVAILABLE`，证明 fresh Agent 不能仅凭 durable pointer 无歧义恢复角色上下文。
3. upstream `docs/AGENT_INTERFACE.md` 要求 durable dispatch source 足以让 fresh Agent 执行，Human seed 只寻址；当前项目 seed 仍直接携带 role/project/task/revision/report/task_ref，多于 upstream canonical minimal seed，且没有项目内 durable dispatch prompt 作为统一入口。
4. `.ai/reports/TASK-0006-RELEASE.md` 仍只在 Agent 本地路径，远端 main 缺少 Agent 原始 merge 报告；Chat 已有独立 merge 事实报告，但任务尚未完全收敛。

## 非阻塞但不是 full parity

- upstream 当前包含 Workspace Bootstrap / Registry / Global Architect Ready 与 `ARCHITECT_HANDOFF_REQUEST` / `ARCHITECT_HANDOFF_ACCEPTED` 精确事务格式；本项目只保留作用对应，不实现其完整控制面与精确字段。这是精简适配，不是 full feature parity。
- upstream 默认 Minimal Agent Seed 是 pointer/work/startup_mode 三行；本项目当前格式更长。语义接近但不是 canonical exact interface。
- 本项目允许 GitHub 可选；upstream 更强调 Git/GitHub durable truth。只要本地模式仍有 durable Git/文件 pointer 可恢复，属于用户接受的适配；若仅靠未版本化临时 workspace，则不满足 upstream durable-truth 原则。

## 本项目额外约束

- Chat Write Guard：Chat 在业务项目只写 `.ai/**`，比 upstream Global Architect Maintenance Lane 更严格，是用户明确接受的本地约束。
- Remote Sync Gate / Remote Action Gate / `remote_actions` / `user_authorized_actions`：upstream 没有同名完整字段模型，本项目是更严格的权限实现。
- 多 Agent 平台安装位置矩阵、无复制脚本要求、v1.1.0 11 文件安装包：均为本项目产品化扩展，不属于 upstream 核心治理协议。

## 分支收敛结论

ai-use 要求的是 durable Git/GitHub 可恢复事实与 exact pointer，不要求工作分支永久保留。当前 `build/task-0003-dispatch-guard`、`verify/task-0004-task0003`、`repair/task-0005-task0003` 的必要产品结果/报告均已在 main durable source 中可恢复，因此从治理/恢复角度可以删除；删除 remote refs 仍是独立 destructive remote action，需要显式授权与可用 delete-ref 工具。

用户已明确授权删除以下误建临时分支：
- `tmp/invalid-do-not-use`
- `tmp/report-convergence`
- `tmp/stop`

当前 Chat GitHub connector 未暴露 delete-ref/delete-branch 动作，因此状态为 `BLOCKED_DELETE_REF_TOOL`；不得用移动 ref 冒充删除。
