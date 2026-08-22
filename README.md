# Chat-Git-Agent

Chat-Git-Agent 是一套简单的长期协作规则：**Chat 负责理解、安排、验收和保存项目上下文；Agent 负责按明确任务执行；业务项目用自己的 `.ai/` 保存可恢复状态。**

## 核心边界

1. **Chat 规则只安装在 Chat。**
2. **Agent 规则只安装在 Agent 的用户级配置位置。**
3. **业务项目零预装。** 第一次接入后，才由 Chat 根据真实项目建立项目自己的 `.ai/`。
4. **GitHub 不是运行前提。** 本地文件即可完成任务；GitHub 只用于同步和版本记录。
5. **用户拥有最终决定权。** 目标、优先级、验收标准、风险接受、合并和发布由用户决定。
6. **证据高于自评。** 实际差异、测试、构建、检查和精确版本强于 Agent 的自然语言评价。
7. **只读当前任务需要的内容。** 不为了“可能有用”扫描全部历史。
8. **Chat Write Guard。** 在业务项目中 Chat 只允许写 `.ai/**`；越界请求必须报告 `BLOCKED_CHAT_WRITE_SCOPE` 并形成正式 TASK 派 Agent。
9. **Dispatch Gate。** TASK 写入并回读、取得 Git exact `task_ref`（使用 Git 时）、输出派发卡和最短提示后，Chat 进入 `WAIT_AGENT_RESULT`，不继续该 TASK 的产品开发。

## Remote Sync Gate 与远端动作权限

使用 GitHub 的 TASK 必须在 fresh、resume、VERIFIER、REPAIR 开工前刷新远端，核对 live main、task_ref、target/work refs 和本地状态。无法刷新报告 BLOCKED_REMOTE_SYNC；无法解释的 task/ref 或远端漂移报告 BLOCKED_REMOTE_DRIFT。

TASK 必须显式声明 remote_actions：push_work_branch、open_pr、merge、deploy、release。字段缺失默认 forbidden，五项权限互相独立；push 只允许指定工作分支的非 force 写入。非 RELEASE 角色不得 merge、deploy、release。ACCEPTED_WORK_REF 只表示内容验收，不自动授予 merge/release；merge 与 release 必须分别由用户授权并由 RELEASE TASK 执行。

## Chat 与 Agent 的职责边界

Chat 负责理解目标、写任务合同、选择角色、派发、验收和保存 `.ai/**` 记录。Agent 负责在隔离工作区落实已明确的任务并报告实际结果。Chat 不直接修改业务项目的产品文件、代码、配置、测试或项目文档；这些内容必须由被派发的 Agent 修改。

一次派发的最小流程是：

```text
写 TASK → 回读 TASK → 使用 Git 取得 exact task_ref（如适用）
→ 输出用户派发卡和最短 Agent 提示 → WAIT_AGENT_RESULT
→ 读取报告/diff/验证证据 → Chat 验收
```

`WAIT_AGENT_RESULT` 期间 Chat 可以读取状态、回答用户和维护 `.ai/**`，但不能继续同一 TASK 的设计、实现、代码、配置、测试或产品文档修改。

## 角色选择

| 未解决的问题或阶段 | 角色 |
| --- | --- |
| 事实、原因、官方资料或可选方案不清 | `RESEARCH` |
| 技术设计、影响、接口、数据流、迁移或实现拆分不清 | `ARCHITECT` |
| 方案和验收已经明确，需要落实文件或代码 | `BUILDER` |
| 已确认故障，需要按边界修复 | `REPAIR` |
| 实现完成，需要独立验收 | `VERIFIER` |
| 已验收版本需要准备或执行发布 | `RELEASE` |

`ARCHITECT` 默认只输出设计报告，不实现业务代码；`BUILDER` 才落实明确实现。角色规则的实际安装目录或 UI 入口由具体 Agent 平台决定，见 [`INSTALL.md`](INSTALL.md)，不存在所有平台共用的规则目录。

## 仓库结构

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
    ARCHITECT.md
    BUILDER.md
    RESEARCH.md
    REPAIR.md
    VERIFIER.md
    RELEASE.md
maintenance/
  UPSTREAM.md
  AUDIT.md
  CHANGELOG.md
.ai/
```

- `chat/`：需要安装到 Chat 的长期规则。
- `agent/`：需要安装到 Agent 用户环境的通用规则和角色规则。
- `maintenance/`：只用于维护 Chat-Git-Agent 自身，不进入业务项目，也不进入 Release 安装包。
- `.ai/`：只记录 Chat-Git-Agent 这个仓库自己的任务、决定和交接状态，不是业务项目模板。

## 从哪里开始

- 安装：读 [`INSTALL.md`](INSTALL.md)
- 日常使用：读 [`USAGE.md`](USAGE.md)
- 维护者核对原项目：读 [`maintenance/UPSTREAM.md`](maintenance/UPSTREAM.md)
- 发布前审计：读 [`maintenance/AUDIT.md`](maintenance/AUDIT.md)

## 业务项目里会出现什么

业务项目第一次接入前不需要任何 Chat-Git-Agent 文件。首次接入后，Chat 按真实项目建立：

```text
.ai/
├─ INDEX.md
├─ context/
│  ├─ PROJECT.md
│  ├─ ARCHITECTURE.md
│  ├─ MEMORY.md
│  └─ DECISIONS.md
├─ tasks/
│  ├─ ACTIVE.md
│  └─ TASK-xxxx.md
├─ reports/
│  └─ TASK-xxxx-<ROLE>.md
└─ handoff/
   └─ CURRENT.md
```

`reports/` 只有出现第一份结果时才建立，不创建空目录占位文件。

## 与原项目的关系

本项目吸收 `youling/ai-use` 的实际工作原则，但不复制它的目录、术语和 GitHub 强依赖。当前核对基线：

```text
youling/ai-use@1ddfeb0dd6a606dbc80ab86de8903d6888077bc6
```

跟随更新采用“精确提交 + 作用对应 + 手动审计”：只吸收会改变实际行为的规则；如果原项目的新规则与用户已经确认的本项目边界冲突，先报告用户决定，不自动覆盖。

## 来源与许可

本项目是在 `youling/ai-use` 的公开方法基础上重新设计的简化实现，并按本项目用户确认的安装与运行边界进行了结构改造。

原项目使用 Apache License 2.0。本仓库保留 `LICENSE` 文件。
