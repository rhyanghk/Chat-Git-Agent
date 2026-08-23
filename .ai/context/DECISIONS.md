# 已接受的重要选择

## D-001

决定：采用“Chat 安装 / Agent 安装 / 业务项目零预装”。

理由：让通用规则不污染业务项目，同时让 Chat 和 Agent 可以跨项目复用。

影响：业务项目首次接入后只生成项目自己的 `.ai/`。

来源：用户于 2026-08-22 明确要求。

## D-002

决定：GitHub 不是运行前提，只用于同步和版本记录。

理由：本地文件即可完成任务；远端不可用不应阻塞正常执行。

影响：任务启动提示支持本地路径和 `revision`；使用 GitHub 时额外使用 exact commit/ref。

来源：用户于 2026-08-22 明确要求。

## D-003

决定：跟随原项目更新采用“精确提交 + 作用对应 + 手动审计”，不做目录镜像或自动覆盖。

理由：持续吸收原项目有效改进，同时不把复杂目录和 GitHub 强依赖重新带回来。

影响：维护 `maintenance/UPSTREAM.md`、`maintenance/AUDIT.md` 和 `maintenance/CHANGELOG.md`。

来源：用户于 2026-08-22 明确要求。

## D-004

决定：普通目录和文件名统一为英文；安装说明只保留根目录 `INSTALL.md`；Release 包只包含 README、INSTALL、USAGE 和需要安装的规则文件。

理由：降低安装和维护成本，避免重复文件。

影响：删除旧中文命名文件和 Chat/Agent 子目录安装文档；项目接入说明并入 `USAGE.md`，来源与许可并入 `README.md`，检查清单并入 `maintenance/AUDIT.md`。

来源：用户于 2026-08-22 明确要求。

## D-005

决定：业务项目中 Chat 只允许修改 `.ai/**` 控制记录；任何 `.ai/**` 之外的产品、代码、配置、测试和项目交付文档修改必须先形成版本化 TASK 并派 Agent。TASK 完成派发后 Chat 进入 `WAIT_AGENT_RESULT`，不得继续该 TASK 的开发工作。

理由：把协调/决策与技术执行彻底分离，防止 Chat 自己完成“定义任务 → 实现 → 自评”的整条链。

影响：`chat/CHAT_CORE.md` 必须增加 Chat Write Guard、Dispatch Gate 和明确角色路由；越界写入报告 `BLOCKED_CHAT_WRITE_SCOPE`。

来源：用户于 2026-08-22 明确要求。

## D-006

决定：对于通过“把规则文件放入固定目录”完成安装的 Agent，`INSTALL.md` 只列出需要放置的源文件和目标目录/文件名，不提供复制、移动、链接或安装脚本/命令。

理由：安装说明应直接、可检查，避免平台/终端差异和脚本副作用。

影响：Codex、Claude Code、OpenCode 等文件型安装用“源文件 → 目标路径”表达；只有 UI 型产品保留必要界面步骤。

来源：用户于 2026-08-22 明确要求。

## D-007

决定：Agent 规则文件的实际安装/读取位置按具体 Agent 平台分别定义，不设置一个跨平台统一的 `~/.chat-git-agent/...` 或 `%USERPROFILE%\\.chat-git-agent\\...` 官方位置。

理由：不同 Agent 平台的原生规则文件、全局配置目录和角色规则导入机制不同，统一伪路径会导致安装说明和运行时读取错误。

影响：`agent/AGENTS.md` 只描述逻辑读取顺序，不硬编码所有平台共用的安装目录；`INSTALL.md` 逐平台给出“源文件 → 官方目标位置/UI”，并说明角色文件如何被该平台使用。平台不原生支持多角色自动发现时必须明确说明，不能假定 `roles/*.md` 会自动加载。

来源：用户于 2026-08-22 明确要求。

## D-008

决定：任何使用 GitHub/远端 Git 仓库的 Agent，在 `fresh`、`resume`、`VERIFIER` 或 `REPAIR` 开工前都必须先刷新远端引用，并核对 live default branch、`task_ref`、任务要求的 target/work refs 与本地状态；没有远端同步证据不得进入实现或验收。

理由：本地 checkout 可能落后于云端。只读取旧本地分支会让 Agent 在过时事实上实现或验证，产生“过程正确、对象错误”的结论。

影响：`agent/AGENTS.md` 必须加入 Remote Sync Gate；`chat/CHAT_CORE.md` / `USAGE.md` 明确 GitHub 任务的开工与验收都要基于刷新后的远端 refs。同步失败时报告 `BLOCKED_REMOTE_SYNC`；发现 task/ref 漂移无法安全解释时报告 `BLOCKED_REMOTE_DRIFT`。Agent 报告应记录本轮核验使用的 live remote refs。

来源：用户于 2026-08-22 在 TASK-0004 验收后明确指出 Verifier 未先拉取云端更新。

## D-009

决定：GitHub/远端 Git TASK 必须显式声明 `remote_actions`；任何未声明或含义不明确的远端动作默认禁止。push 工作分支、开 PR、merge、deploy、release 是相互独立的权限，不能互相推导。

理由：工具能力、工作分支存在、测试 PASS、Chat 内容验收或某一项远端动作获准，都不能自动推出更高风险动作的授权。

影响：`push_work_branch` 只允许按 TASK 指定分支非 force push；非 `RELEASE` 角色不得 merge/deploy/release。只有 `RELEASE` TASK 同时具备动作 `allowed`、Chat 记录的 accepted exact ref/live target、以及由 Chat 根据用户明确指令写入的 `user_authorized_actions`，才可执行 merge/deploy/release。merge 与 release 必须分别授权；merge 后、release 后都必须回读 exact ref/Release/tag/asset。`ACCEPTED_WORK_REF` 只代表内容验收，不产生 merge/release 权限。

来源：用户于 2026-08-22 明确要求本轮完整修复 push/merge/release 权限。

## D-010 — SUPERSEDED BY D-011

决定：进一步分离 Chat 与 Agent 的工作层次，并曾定义独立 `ARCHITECT` Agent 负责项目本体架构和正式架构文档。

状态：`SUPERSEDED`。该决定中“ARCHITECT 是独立 Agent 角色”的部分被 D-011 明确取代；其余关于 `.ai` 不是正式项目架构、Builder 负责实现、Chat 继续受 D-005 写入边界约束等原则继续由 D-011 重新表述。

来源：用户于 2026-08-23 早先明确要求；随后同日被用户最新明确指令取代。

## D-011

决定：`ARCHITECT` 不再是独立 Agent 角色，而是主协调 Chat 的内建架构功能。

Chat 的职责扩展为两层同时存在：

- **协调/治理功能**：理解用户目标与限制、维护长期决定、建立和修订版本化 TASK、选择执行角色、控制授权、验收证据、维护 `.ai/**` 恢复状态、交接和风险收敛。
- **架构功能（ARCHITECT-as-Chat）**：基于当前真实项目定义系统/产品分层、模块边界、接口、数据流、依赖、运行边界、架构约束、演进/迁移方案、技术取舍和实现拆分，并对正式项目架构文档的内容负责。

Agent 角色收敛为：

- `RESEARCH`：查证未知事实、外部资料和备选方案证据，默认不施工。
- `BUILDER`：把 Chat 已确定的需求与架构落实为正式项目文档、规则、代码、配置、测试和其他产品文件。
- `REPAIR`：修复已确认且边界明确的问题。
- `VERIFIER`：独立验收任务、实际 diff/code/tests 与验证证据，不顺手修改。
- `RELEASE`：只处理已验收 exact ref 的 merge/deploy/release 阶段，并受独立授权门控制。

写入边界：D-011 **不取代 D-005**。Chat 仍只直接写业务项目 `.ai/**`；Chat 负责架构判断和架构内容，但当架构需要落到 `.ai/**` 之外的 `docs/**`、README、规则文件、代码或配置时，由 `BUILDER` 按正式 TASK 实体化。这样避免 Chat 同时承担“定义架构 → 修改产品 → 自我验收”的整条链。

任务模型：不再创建 `role: ARCHITECT` 的 Agent TASK。需要架构时由主协调 Chat 先完成架构判断并留下 durable 架构基线/决定；随后创建 `BUILDER` TASK 实施，必要时使用 `RESEARCH` 补证据，实施后按风险使用 `VERIFIER`，发布阶段再使用 `RELEASE`。

影响：

- TASK-0008 的独立 ARCHITECT Agent 模型在执行前废止，状态改为 `SUPERSEDED_BEFORE_EXECUTION`。
- 后续产品规则需要删除/退役 `agent/roles/ARCHITECT.md` 作为可派发 Agent 的语义，并从 README/INSTALL/USAGE/agent rules/release manifest 中移除 ARCHITECT Agent。
- `chat/CHAT_CORE.md` 应加入明确的 Chat Architecture Function；正式项目架构文档由 Chat 负责内容与决策，Builder 负责文件落地。
- `.ai/context/ARCHITECTURE.md` 仍只是快速恢复快照；Chat 可在 `.ai/**` 内维护更详细的架构基线/实施规格，Builder 再将已接受内容同步到正式项目文档。

supersedes: D-010 中“独立 ARCHITECT Agent”模型。

来源：用户于 2026-08-23 最新明确指令：“ARCHITECT应作为chat的功能”。

## D-012

决定：Git/GitHub 模式下，Durable Dispatch artifact **不在自身内容中保存“包含自身的 commit SHA”**。exact dispatch pointer 由 minimal seed/外部派发记录提供，格式可为 `<repo>@<commit>:.ai/dispatch/TASK-xxxx-<ROLE>.md`；dispatch 文件自身保存 task/ref、common rule exact ref、role rule exact ref、role、report、startup mode、access 等可解析上下文。

理由：Git commit SHA 由文件内容参与计算，文件若要求写入“包含自己的 SHA”会形成不可实现的哈希自引用。

影响：D-011 架构下的 Durable Dispatch 采用“外部 exact pointer → dispatch artifact → exact task/rules”的单向寻址链。local-only 模式使用可复核本地路径/平台 identifier 和本地核验标记，不伪造 GitHub ref。

来源：Chat 在 2026-08-23 按 D-011 执行架构设计时发现并修正的可实现性约束；属于对用户已接受架构目标的技术收敛，不改变用户授权边界。
