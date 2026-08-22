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
