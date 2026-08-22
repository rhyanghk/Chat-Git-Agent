# 使用

## 日常流程

```text
用户提出目标和边界
→ Chat 把正式要求写进项目 .ai/tasks/TASK-xxxx.md
→ Chat 选择最少够用的 Agent 角色
→ Chat 生成最短启动提示
→ Agent 读取通用规则、角色规则、任务和必要项目文件
→ Agent 在本地执行并写 .ai/reports/...
→ Chat 根据实际改动和验证证据验收
→ 只有长期仍有价值的事实和决定才进入 .ai/context/
```

## 第一次接入业务项目

把真实项目交给 Chat，并明确说：

```text
初始化这个项目。
```

Chat 会先检查 `.ai/INDEX.md`。不存在时只读取当前项目必要入口、依赖、运行/测试/构建配置、主要代码、已有架构说明和环境变量名称，然后建立项目自己的 `.ai/`。不能确认的事实写“未知”，不猜。

如果 `.ai/INDEX.md` 已存在，则按恢复流程读取，不重新初始化。

## 创建正式任务

正式 Agent 工作必须先有：

```text
.ai/tasks/TASK-xxxx.md
```

至少包含：

```text
id
revision
status
role
base_branch
work_branch
goal
scope
forbidden
read_context
acceptance
report
```

任务的角色、基线、工作分支、目标、范围、禁止事项、必读内容、验收条件或报告位置发生变化时，先把 `revision` 加一，再继续执行。

如果新任务与已经接受的长期决定或限制冲突，Chat 必须先取得用户明确覆盖意图并记录 `supersedes_decisions` / `overrides_constraints`；否则停止并报告：

```text
BLOCKED_CONTRACT_CONFLICT
```

## Chat 给 Agent 的启动提示

启动提示只负责定位，不复制任务正文。

本地项目示例：

```text
role: BUILDER
project: /absolute/path/to/project
task: .ai/tasks/TASK-0007.md
task_revision: 2
report: .ai/reports/TASK-0007-BUILDER.md
startup_mode: fresh
```

使用 GitHub 时再增加：

```text
task_ref: <包含该 revision 的 exact commit SHA>
```

继续同一任务、同一现场时使用：

```text
startup_mode: resume
```

`resume` 只刷新当前任务 revision、必要状态和当前代码/分支，不重新扫描全部历史。

Chat 或 Agent 的会话名称只用于用户导航，不是任务状态来源。新任务/新职责优先新会话；同一任务、同一现场连续工作才优先 `resume`。

## Agent 角色

- `BUILDER`：实现已经明确的改动。
- `RESEARCH`：查清事实、原因和选择，默认不施工。
- `REPAIR`：修复已经确认的问题。
- `VERIFIER`：独立检查结果是否满足原任务。
- `RELEASE`：核对发布条件和材料；只有用户明确授权才执行发布。
- `ARCHITECT`：仅在 Chat 明确派发时协助项目结构或本地项目记录工作，不成为第二个主协调 Chat。

命令、脚本、CI 或其他自动化工具只是执行工具，不拥有需求、验收、合并或发布决定权。

## Agent 完成报告

报告写到任务指定位置，通常是：

```text
.ai/reports/TASK-xxxx-<ROLE>.md
```

在任务 ID / revision 元数据之后，报告只需要五类信息：

1. 结果；
2. 交付（实际改动与精确位置）；
3. 验证；
4. 剩余风险；
5. 下一步。

没有验证就明确写“未验证”。

## 怎么验收

- 低风险、边界清楚、证据充分：Chat 可直接验收。
- 普通复杂或高风险：默认最多增加一个全新的独立 `VERIFIER`。
- 只有真实系统失效、数据丢失、权限/安全边界失效、状态损坏或不可恢复、无法解释的事实冲突、secret 泄漏、制度性死锁、重复执行或错误接管，才扩大为多验证事故处理。

`VERIFIER` 优先看原始任务、实际代码/差异和测试，不把实现者自评当成证据。

## 恢复项目

新 Chat 先读：

```text
.ai/INDEX.md
.ai/tasks/ACTIVE.md
.ai/handoff/CURRENT.md
```

再只读取当前任务需要的 `PROJECT.md`、`ARCHITECTURE.md`、`MEMORY.md`、`DECISIONS.md`、任务、报告和代码。

恢复时核对：当前代码/配置、`.ai` 的核验版本、ACTIVE 与 TASK、CURRENT 引用、架构快照是否陈旧、是否存在两个主协调 Chat。

用户只要求“查看状态”时保持只读。用户明确要求“继续管理 / 接任 / 恢复并继续”后，才更新主协调状态并继续调度。

## 主协调 Chat 交接

交接必须可从 `.ai/handoff/CURRENT.md` 恢复，不能只在聊天里说“已经交接”。

1. 旧 Chat 收敛当前任务、阻塞、风险、有效决定和下一步，状态改为 `HANDOFF_READY` 并写交出记录。
2. 新 Chat 做最小能力检查，并从项目文件完成快速恢复。
3. 用户明确确认接任。
4. 新 Chat 写接任确认，把 `architect_control` 改成 `ACTIVE` 并记录新 holder。
5. 接任确认写入后，旧 Chat 停止调度。

缺少交出记录、恢复核对、用户确认或接任确认中的任一项时，保持 `BLOCKED`，不形成两个主协调者。

## GitHub 怎么用

GitHub 只用于同步和版本记录。

使用 GitHub 时：

1. Agent/Chat 写入前读取当前 branch/ref 和相关文件版本；
2. 执行工作先同步到本地；
3. 本地完成并验证；
4. 只有任务和用户授权允许时才 push / merge / release；
5. 不 force、不绕过分支保护；
6. 写入后回读，返回 exact commit/ref。

没有 GitHub 时，本地流程完全不变，只少远端同步步骤。
