# Release Audit

本文件是发布前门槛。**审计不通过时，不生成 Release 安装包。**

## 审计基线

```text
upstream: youling/ai-use@1ddfeb0dd6a606dbc80ab86de8903d6888077bc6
project_base: rhyanghk/Chat-Git-Agent@6a737b18204b6336f3be99df93dfa19c5aaafe89
scope: TASK-0002 candidate
```

## 原项目核心语义审计

| 项目 | 本项目承载位置 | 结果 |
| --- | --- | --- |
| 用户最终决定；AI 建议不自动变要求 | `chat/CHAT_CORE.md` §1；`agent/AGENTS.md` | PASS |
| 能力不等于授权 | Chat §1；Agent §2/§9 | PASS |
| 当前实现事实优先；快照陈旧时重新核验 | Chat §1/§6；ARCHITECT role | PASS |
| 正式任务唯一合同、revision 保护 | Chat §7；`USAGE.md` | PASS |
| 与长期决定冲突必须用户明确覆盖 | Chat §1/§7；Agent §5 | PASS |
| 最短启动提示只寻址，不复制任务知识 | Chat §8；`USAGE.md` | PASS |
| 启动七项检查；`BOOTSTRAP_CHECK` 只检查不执行 | `agent/AGENTS.md` §2 | PASS |
| 新设备/交接可按需做六项 `CAPABILITY_SELF_CHECK`，能力不产生授权 | `agent/AGENTS.md` §2 | PASS |
| fresh / resume 分开，恢复不扫全历史 | Chat §8；Agent §3；`USAGE.md` | PASS |
| 定向读取，冷启动成本与任务规模相关 | Chat §5/§6；Agent §1/§3 | PASS |
| 写任务使用隔离工作区，不覆盖其他协作者现场 | Agent §4 | PASS |
| 证据高于自评，结论不超过证据 | Chat §10；Agent §6 | PASS |
| 低风险直接验收；复杂/高风险最多一个独立 Verifier | Chat §10；`USAGE.md` | PASS |
| 多验证只在真实事故 | Chat §10；`USAGE.md` | PASS |
| 决定、修改、验证、状态、风险必须留可恢复记录 | Chat §12；Agent §8 | PASS |
| 初始化/远端写入后回读，只有核验后才视为就绪/成功 | Chat §5/§11；`USAGE.md` | PASS |
| 同一项目只有一个主协调 Chat | Chat §6/§14 | PASS |
| 交接有交出记录、能力核对、用户确认、接任确认 | Chat §14；`USAGE.md` | PASS |
| 合并/部署/发布需要用户授权 | Chat §1/§11；RELEASE role | PASS |
| 自动化/Runner 是工具，不是决策者 | Chat §9；Agent §9 | PASS |
| secret 不进入长期记录 | Chat §15；Agent §10 | PASS |
| 用户可见说明默认简体中文 | Chat §15；Agent §10 | PASS |

## 用户明确改造边界审计

| 要求 | 结果 |
| --- | --- |
| Chat 安装 / Agent 安装 / 业务项目零预装 | PASS |
| GitHub 只用于同步和版本记录，不是运行前提 | PASS |
| 普通目录和文件名使用英文 | PASS（候选目录检查） |
| 表示最终决策者时只使用“用户” | PASS（候选文本检查） |
| 根目录只有一份安装文档 | PASS |
| `chat/` 和 `agent/` 内无安装文档 | PASS |
| 删除重复 onboarding / source / checklist 文件，内容分别收敛到 README/USAGE/maintenance | PASS |
| 跟随原项目更新但不自动覆盖本项目固定边界 | PASS |

## 安装方式外部核验

| 产品 | 核验结果 |
| --- | --- |
| ChatGPT Projects：支持 Project sources + Project instructions | PASS |
| Claude Projects：支持 Project knowledge + Project instructions | PASS |
| Gemini Gems：支持 Knowledge files + instructions | PASS |
| OpenAI Codex：支持 `$CODEX_HOME/AGENTS.md` 用户规则 | PASS |
| Claude Code：支持 `~/.claude/CLAUDE.md`，并支持 `@path` 导入 | PASS |
| OpenCode：支持 `~/.config/opencode/AGENTS.md` 全局规则 | PASS |
| Cursor：全局 User Rules 位于 UI；官方未提供固定用户级规则文件目录 | PASS（按 UI 兼容方式说明） |

## Release 包限制

Release 安装包只允许：

```text
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
```

不得包含：`.ai/`、`maintenance/`、`LICENSE`、旧中文命名文件、重复安装说明或项目维护记录。

## 最终审计结论

发布包生成前已执行两轮机械检查。最终结果：

```text
non_ascii_paths: 0
install_documents: 1 (INSTALL.md only)
old_chinese_path_references: 0
legacy_decision_maker_term: 0
exact_duplicate_files: 0
core_semantics_check: PASS
status: PASS
release_package_allowed: YES
```

若后续任何文件变化，必须重新运行本审计；旧的 PASS 不能自动沿用。
