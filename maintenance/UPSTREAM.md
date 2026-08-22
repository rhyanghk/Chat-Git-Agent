# Upstream Alignment

本文件只用于维护 Chat-Git-Agent，不进入业务项目，也不进入 Release 安装包。

## 当前原项目基线

```text
source_repository: youling/ai-use
last_checked_ref: 1ddfeb0dd6a606dbc80ab86de8903d6888077bc6
checked_date: 2026-08-22
```

## 用户确认的固定边界

原项目以后怎么变化，都不能自动推翻：

1. Chat 规则只安装在 Chat。
2. Agent 规则只安装在 Agent 用户环境。
3. 业务项目零预装；首次接入后只建立项目自己的 `.ai/`。
4. GitHub 只用于同步和版本记录；没有 GitHub 时本地流程仍能完成。
5. 用户可见说明优先使用通俗简体中文；代码、路径、命令和机器标识按实际需要保留原文。
6. 文件和目录使用英文名称。

冲突时先报告用户决定，不自动吸收。

## 原项目作用对应

| 原项目入口 | 本项目位置 | 保留的作用 |
| --- | --- | --- |
| `START_HERE.md` | `README.md`、`INSTALL.md`、`USAGE.md` | 第一次从哪里开始、安装和使用 |
| `README.md` | `README.md`、Chat/Agent 规则 | 用户与各角色分工、证据优先、最低足够流程 |
| `CONSTITUTION.md` | `chat/CHAT_CORE.md`、`agent/AGENTS.md` | 用户最终决定、能力不等于授权、单一主协调、验证边界 |
| `AGENTS.md` | `agent/AGENTS.md` | Agent 通用执行规则 |
| `READING_MAP.md` | Chat/Agent 的定向读取规则 | 不全量扫描，按当前任务读取 |
| `NAMESPACE.md` | `README.md` 导航 | 只保留导航作用，不复制编号目录 |
| `00_KERNEL/LANGUAGE_POLICY.md` | Chat/Agent 输出规则 | 用户可见说明默认简体中文 |
| `10_BOOT/BOOTSTRAP_CHECK_PROTOCOL.md` | `agent/AGENTS.md` 开工检查 | 角色、入口、授权、访问、任务、边界、状态七项检查 |
| `10_BOOT/WORKSPACE_BOOTSTRAP_PROTOCOL.md` | `chat/CHAT_CORE.md` 初始化 + 项目 `.ai/` | 初始化、缺失不猜、可恢复状态；原多仓角色被本项目固定安装边界替代 |
| `30_PROTOCOLS/DURABLE_TRACE_PRINCIPLE.md` | Chat/Agent 可恢复记录规则 + `.ai/` | 决定、修改、验证、状态和风险必须落盘 |
| `40_GUIDES/PUBLIC_COLD_START_CHECKLIST.md` | `maintenance/AUDIT.md` | 从空环境验证可启动性 |
| `50_TEMPLATES/HUMAN_WORKSPACE_BOOTSTRAP.md` | `INSTALL.md` | 用户首次安装与接入步骤 |
| `50_TEMPLATES/capability_self_check.md` | Agent 开工检查 + Chat 交接能力核对 | 能力盘点，能力不等于授权 |
| `50_TEMPLATES/bootstrap_check_request.md` | Agent 开工检查 | 固定启动检查 |
| `50_TEMPLATES/pointer_response.md` | 最短启动提示 | 提示只寻址，不复制任务合同 |
| `50_TEMPLATES/architect_handoff_check.md` | Chat 交接 | 接任前恢复、边界和单主协调核对 |
| `50_TEMPLATES/architect_handoff_transaction.md` | `.ai/handoff/CURRENT.md` + Chat 交接 | 交出记录与接任确认都要落盘，并有用户确认 |
| `docs/AGENT_INTERFACE.md` | `USAGE.md`、Chat 派发、Agent 报告 | 用户五项派发说明、最短启动提示、五类完成信息 |
| `docs/PROGRESSIVE_CONTEXT_BOOT.md` | Chat/Agent 定向读取 | 从最小可信集合开始，异常时才扩大读取 |
| `docs/SESSION_LIFECYCLE.md` | Chat 恢复/交接 + Agent fresh/resume | 换会话/设备后从项目文件恢复，不依赖旧聊天 |
| `20_ROLES/` / Constitution roles | `agent/roles/` | 角色职责分开 |
| Runner/tool boundary | Chat/Agent 工具边界 | 自动化是工具，不产生架构或审批权 |
| `90_HISTORY/` | 不安装 | 历史只在维护时按需参考 |

### 对原多仓结构的适配

原项目建议把治理、任务控制、资产和业务项目分成不同仓库。本项目根据用户明确要求改成更轻的部署方式：

- 原“治理”作用 → Chat/Agent 用户级安装文件；
- 原“任务控制”作用 → 每个业务项目自己的 `.ai/tasks/`、`.ai/handoff/`；
- 原“资产事实”作用 → 留在实际负责这些资产的项目/文件中，由 `.ai/context/PROJECT.md` 只记录必要入口和稳定约束；不强制建立单独资产仓库；
- 原“业务项目”作用 → 真实业务项目本身。

这是部署位置变化，不取消“事实要可恢复、任务要有合同、权限不能靠猜”的原则。

## 每次跟随原项目更新

1. 找到原项目最新 exact commit。
2. 从 `last_checked_ref` 比较到新提交。
3. 先检查上表对应的当前有效入口，再检查新增加的真正行为规则。
4. 判断是否影响：用户最终决定、任务合同、启动检查、角色边界、证据、验证、交接、安全、恢复或阅读范围。
5. 有影响时，用本项目现有简单说法修改对应文件；不复制原项目目录、编号和历史说明。
6. 运行 `maintenance/AUDIT.md`，审计通过后才更新 `last_checked_ref` 和 `maintenance/CHANGELOG.md`。
