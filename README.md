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
