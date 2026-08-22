# Release Audit

本文件是发布前门槛。**审计不通过时，不生成 Release 安装包。** 本轮审计对应 TASK-0005 revision 3，目标资源包版本为 v1.1.0。

## 审计基线

    upstream: youling/ai-use@1ddfeb0dd6a606dbc80ab86de8903d6888077bc6
    live_main_at_start: rhyanghk/Chat-Git-Agent@2076a8da6a2bf4c408be73d7be0572b585857814
    task_ref_checked: 8a60d0fc4666bd9a7caa387ebcb1804b123c6e36
    builder_product_ref: 9e07c42420b642bcd6f5609e7dc57618cc90f553
    verifier_ref_checked: 1ac96ee80a26280ad847450cdd2d6a018e94d19b
    scope: TASK-0005 revision 3 candidate
    checked_date: 2026-08-22

## 原项目核心语义审计

| 项目 | 本项目承载位置 | 结果 |
| --- | --- | --- |
| 用户最终决定；AI 建议不自动变要求 | chat/CHAT_CORE.md §1；agent/AGENTS.md | PASS |
| 能力不等于授权 | Chat §1；Agent §2/§9 | PASS |
| 当前实现事实优先；快照陈旧时重新核验 | Chat §1/§6；ARCHITECT role | PASS |
| 正式任务唯一合同、revision 保护 | Chat §7；USAGE.md | PASS |
| 与长期决定冲突必须用户明确覆盖 | Chat §1/§7；Agent §5 | PASS |
| 最短启动提示只寻址，不复制任务知识 | Chat §2.2/§8；USAGE.md | PASS |
| 启动七项检查；BOOTSTRAP_CHECK 只检查不执行 | agent/AGENTS.md §2 | PASS |
| 新设备/交接可按需做六项 CAPABILITY_SELF_CHECK | agent/AGENTS.md §2 | PASS |
| fresh / resume 分开，恢复不扫全历史 | Chat §8；Agent §3；USAGE.md | PASS |
| 定向读取，冷启动成本与任务规模相关 | Chat §5/§6；Agent §1/§3 | PASS |
| 写任务使用隔离工作区，不覆盖其他协作者现场 | Agent §4 | PASS |
| 证据高于自评，结论不超过证据 | Chat §10；Agent §6 | PASS |
| 低风险直接验收；复杂/高风险最多一个独立 Verifier | Chat §10；USAGE.md | PASS |
| 多验证只在真实事故 | Chat §10；USAGE.md | PASS |
| 决定、修改、验证、状态、风险必须留可恢复记录 | Chat §12；Agent §8 | PASS |
| 初始化/远端写入后回读，只有核验后才视为就绪/成功 | Chat §5/§11；USAGE.md | PASS |
| 同一项目只有一个主协调 Chat | Chat §6/§14 | PASS |
| 交接有交出记录、恢复核对、用户确认、接任确认、缺失即 BLOCKED | Chat §14；USAGE.md | PASS（作用对应） |
| 本项目没有声称实现上游项目特定的事件端点或 durable pointer 字段 | maintenance/AUDIT.md 本行及 Chat §6/§14 | PASS（边界明确） |
| 合并/部署/发布需要用户授权 | Chat §1/§11；RELEASE role | PASS |
| 自动化/Runner 是工具，不是决策者 | Chat §9；Agent §9 | PASS |
| secret 不进入长期记录 | Chat §15；Agent §10 | PASS |
| 用户可见说明默认简体中文 | Chat §15；Agent §10 | PASS |

## Remote Sync Gate 审计

| 审计项 | 结果 |
| --- | --- |
| GitHub 任务在 fresh、resume、VERIFIER、REPAIR 开工前刷新远端并核对 live default branch、task ref、target/work refs 与本地状态 | PASS |
| task_ref、live main、Builder ref、Verifier ref 均以远端可解析对象核对；本轮开工 live main 为 2076a8da6a2bf4c408be73d7be0572b585857814 | PASS |
| 同步失败与无法解释的远端漂移分别报告 BLOCKED_REMOTE_SYNC / BLOCKED_REMOTE_DRIFT | PASS |
| 修复分支从刷新后的 live main 建立，不以旧 Builder base 作为最终基线 | PASS |
| push 前再次 refresh、比较指定 work branch，存在未解释推进时停止；禁止 force push | PASS |

## Remote Action 权限审计

| 审计项 | 结果 |
| --- | --- |
| GitHub TASK 必须显式包含 remote_actions；字段缺失或值不明确时默认禁止 | PASS |
| push_work_branch、open_pr、merge、deploy、release 相互独立，不从工具能力、分支名、验收 PASS 或其他动作权限推导 | PASS |
| push 只允许当前 TASK 指定 work branch 的非 force 写入，不授权默认分支、其他分支、重写历史或删除 ref | PASS |
| 非 RELEASE 角色不得 merge、deploy、release；错误配置为 allowed 时停止并报告权限冲突 | PASS |
| ACCEPTED_WORK_REF 只代表内容验收，不自动授予 merge 或 release | PASS |
| merge 与 release 独立授权；RELEASE 阶段还必须有 TASK allowed、用户 durable 授权、accepted/live refs 和写后回读 | PASS |

## TASK-0003 改造边界审计

| 要求 | 结果 |
| --- | --- |
| 业务项目 Chat 只写 .ai/**；越界报告 BLOCKED_CHAT_WRITE_SCOPE | PASS |
| TASK 写入并回读、Git exact task_ref、派发卡、最短提示和 WAIT_AGENT_RESULT | PASS |
| Chat 在 WAIT_AGENT_RESULT 不继续同一 TASK 的产品开发 | PASS |
| 六个角色的分发时机无歧义 | PASS |
| ARCHITECT 覆盖深入设计，默认不实现业务代码 | PASS |
| ARCHITECT 与 BUILDER 职责分离 | PASS |
| Agent 规则位置由具体平台决定，不声明跨平台统一实际目录 | PASS |
| Chat/Agent/业务项目零预装，GitHub 仍为可选同步工具 | PASS |
| INSTALL.md 对文件型 Agent 仅给源文件 → 目标，不提供 shell/PowerShell/复制移动命令 | PASS |
| INSTALL.md 逐个列出 ChatGPT Projects、Claude Projects、Gemini Gems、Codex、Claude Code、OpenCode、Cursor 的官方入口或 UI | PASS |
| 对不自动读取 roles/*.md 的平台明确角色文件处理方式 | PASS |
| Chat Write Guard、Dispatch Gate、平台特定 Agent 规则位置和无安装复制脚本等 TASK-0003 核心要求保持 | PASS |

## 安装方式外部核验

以下入口于 2026-08-22 按当前官方资料核验；产品 UI 或文档后续变化时必须重新审计：

| 产品 | 官方入口 | 核验结果 |
| --- | --- | --- |
| ChatGPT Projects | [OpenAI Help](https://help.openai.com/en/articles/10169521-projects-in-chatgpt) | PASS |
| Claude Projects | [Anthropic Help](https://support.anthropic.com/en/articles/9519177-how-can-i-create-and-manage-projects) | PASS |
| Gemini Gems | [Google Gemini Apps Help](https://support.google.com/gemini/answer/15235603) | PASS |
| OpenAI Codex | [OpenAI Codex agent loop](https://openai.com/index/unrolling-the-codex-agent-loop/) | PASS |
| Claude Code | [Claude Code memory](https://code.claude.com/docs/en/memory) | PASS |
| OpenCode | [OpenCode Rules](https://opencode.ai/docs/rules/) | PASS |
| Cursor | [Cursor Rules](https://cursor.com/docs/rules) | PASS（当前官方规则入口已核验） |

## Release 包限制

Release 安装包只允许以下 11 个文件，路径必须逐字匹配：

    README.md
    INSTALL.md
    USAGE.md
    chat/CHAT_CORE.md
    agent/AGENTS.md
    agent/roles/ARCHITECT.md
    agent/roles/BUILDER.md
    agent/roles/RESEARCH.md
    agent/roles/REPAIR.md
    agent/roles/VERIFIER.md
    agent/roles/RELEASE.md

不得包含：.ai/、maintenance/、LICENSE、旧中文命名文件、重复安装说明或项目维护记录。

## 最终审计结论

本轮产品文件机械检查目标如下，执行结果写入 Agent 报告并作为生成资源包的前置证据：

    non_ascii_paths: 0
    install_documents: 1 (INSTALL.md only)
    old_unified_agent_path_in_release_files: 0
    legacy_decision_maker_term: 0
    exact_duplicate_files: 0
    chat_write_guard: PASS
    dispatch_gate: PASS
    platform_specific_rule_locations: PASS
    handoff_claims_bounded: PASS
    remote_sync_gate: PASS
    remote_action_permissions: PASS
    release_package_allowed: YES
    status: PASS

若后续任何允许文件变化，必须重新运行本审计；旧的 PASS 不能自动沿用。只有审计 PASS 后，才可生成或替换 Chat-Git-Agent-v1.1.0.zip、manifest 和 SHA256 文件。
