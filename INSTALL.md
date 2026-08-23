# 安装与首次使用

本仓有两个不同的安装/配置动作：**配置 Chat 协作控制项目**，或**安装执行型 Agent Skill**。业务项目仓库不承担任一动作。

## 1. 先确定当前身份

| 身份 | 工作位置 | 负责什么 | 不负责什么 |
| --- | --- | --- | --- |
| `Human` | Chat 外 | 目标、优先级、风险接受、验收和重大远端动作决定 | 由模型扮演 |
| `Global Architect` | Chat 控制项目 | 跨项目规则、共享接口和治理收敛 | 默认施工或最终验收 |
| `Project Architect` | Chat 控制项目 | 单项目任务、revision、边界、派发与回收 | 扩大 Human 授权 |
| `Builder`、`Research`、`Repair`、`Verifier`、`Runner`、`Release` | 独立 Agent 执行会话 | 只执行或验证当前编号任务 | 设计任务、派发或最终验收 |

一个 Chat 会话只能选择一个模型控制角色：`Global Architect` 或 `Project Architect`。执行角色不能在该 Chat 会话中工作。

## 2. 配置 Chat 协作控制项目

这不是安装 Skill，也不是上传业务项目。配置后，Chat 只知道自己的控制边界、控制角色和读取正式记录的入口。

### 一次性静态配置

1. 将 [PROJECT_INSTRUCTIONS.md](00_CHAT_CONTROL/PROJECT_INSTRUCTIONS.md) 的正文放入平台的项目指令、Custom Instructions 或等价位置。
2. 将 [CONTROL_ROLES.md](00_CHAT_CONTROL/CONTROL_ROLES.md) 放入项目的静态资料区；若平台不支持项目资料，保存其正式位置并在新会话提供。
3. 记录两个位置：本仓的 `governance_source`（用于按需取得正式模板）和当前业务项目的 `authority_store`（用于读取项目记录）。两者不得混为一个“上传到 Chat 的副本”。

不要在配置时上传或复制业务代码、当前任务、decision、报告或完整 Agent Skill。需要创建或读取某个正式记录时，Chat 按 `PROJECT_INSTRUCTIONS.md` 的路径从相应来源按需读取。

### 各 Chat 平台的配置方法

| 平台 | 一次性配置 | 每次开始控制会话 |
| --- | --- | --- |
| **ChatGPT Web** | 新建 **Project**；在项目指令处粘贴 `PROJECT_INSTRUCTIONS.md`；将 `CONTROL_ROLES.md` 放入 **Sources**；记录 `governance_source` 与 `authority_store` 的访问方式。 | 从该 Project 新建 Chat，发送下方启动卡；按卡片指针读取当前记录。 |
| **Claude Web** | 新建独立 Project；在自定义项目指令处粘贴 `PROJECT_INSTRUCTIONS.md`；把 `CONTROL_ROLES.md` 放入项目知识或文件；记录两个来源的访问方式。 | 在该 Project 内新建会话，发送启动卡。 |
| **Claude Code 的控制会话** | 建立独立控制工作区，不打开业务项目仓；把项目指令放入该工作区的 `CLAUDE.md` 或当前会话指令；将角色资料作为只读文件。 | 以控制角色启动新会话，提供启动卡；不安装执行 Skill、不修改业务代码。 |
| **其他不支持本地 Skill 的 Chat** | 有 Project 功能时按上面两份静态资料配置；没有时保存短项目指令和角色资料的位置。 | 每个新会话提供启动卡和所需资料的精确位置；不粘贴完整历史。 |

ChatGPT Web Project 可以在 **Sources** 中保存文件和连接资料源，项目指令会应用于该 Project 的会话；Web Project 不会直接读取本地文件夹。官方说明见 [ChatGPT Projects](https://learn.chatgpt.com/docs/projects)。

### Chat 会话启动卡

```text
当前模型角色: <Global Architect | Project Architect>
当前项目: <PROJECT-0001>
governance_source: <本仓的精确 URL 或可读位置>
authority_store: <业务项目正式资料库的 URL、路径、名称或查询方式>
当前事项: <TASK、DECISION、项目记录，或 none>

请按项目指令读取当前事项需要的资料；角色、来源、项目、指针或访问缺失时只返回 BLOCKED 和缺失项。
```

首次建立或恢复控制项目时，读取并填写 [CHAT_PROJECT_BOOTSTRAP.md](50_TEMPLATES/CHAT_PROJECT_BOOTSTRAP.md)。

## 3. 安装 Agent 执行 Skill

`agent-executor` 只安装到用户级 Agent Skill 目录，不进入 Chat 控制项目或业务项目仓库。

```sh
git clone --branch mainline/PROJECT-0001 --depth 1 https://github.com/rhyanghk/Chat-Git-Agent.git Chat-Git-Agent
cd Chat-Git-Agent
```

macOS / Linux：运行与你的平台相符的一条命令。

```sh
./60_AGENT_SKILL/scripts/install-agent-executor.sh --platform codex
./60_AGENT_SKILL/scripts/install-agent-executor.sh --platform claude-code
./60_AGENT_SKILL/scripts/install-agent-executor.sh --platform cursor
./60_AGENT_SKILL/scripts/install-agent-executor.sh --platform copilot
./60_AGENT_SKILL/scripts/install-agent-executor.sh --platform gemini
```

Windows PowerShell：在同一克隆目录运行。

```powershell
.\60_AGENT_SKILL\scripts\install-agent-executor.ps1 -Platform codex
.\60_AGENT_SKILL\scripts\install-agent-executor.ps1 -Platform claude-code
.\60_AGENT_SKILL\scripts\install-agent-executor.ps1 -Platform cursor
.\60_AGENT_SKILL\scripts\install-agent-executor.ps1 -Platform copilot
.\60_AGENT_SKILL\scripts\install-agent-executor.ps1 -Platform gemini
```

| Agent 平台 | 用户级安装目录 | 安装后调用 |
| --- | --- | --- |
| Codex | `~/.agents/skills/agent-executor` | 新会话输入 `$agent-executor`，再提供编号任务 |
| Claude Code | `~/.claude/skills/agent-executor` | 新会话输入 `/agent-executor`，再提供编号任务 |
| Cursor | `~/.agents/skills/agent-executor` | 新 Agent 会话从 Skills 选择或输入 `/agent-executor` |
| GitHub Copilot | `~/.agents/skills/agent-executor` | 新会话输入 `/agent-executor`；可用 `copilot plugins list --kind skill` 检查 |
| Gemini CLI | `~/.agents/skills/agent-executor` | 运行 `/skills reload`、`/skills list`，再提供编号任务 |
| 其他兼容平台 | 平台规定的用户级 Skill 根目录 | 使用 `--target /path/to/skill-root`，再按平台方式调用 |

安装器遇到已有 `agent-executor` 会停止；不会覆盖、删除、备份、镜像或创建第二份事实源。

## 4. 使用 `.skill` 包或开始任务

[agent-executor.skill](60_AGENT_SKILL/packages/agent-executor.skill) 是只含 `agent-executor/` 的可分发包。Gemini CLI 可安装该包：

```sh
gemini skills install ./60_AGENT_SKILL/packages/agent-executor.skill --scope user
```

GitHub Copilot CLI 可从源 `SKILL.md` 安装：

```sh
copilot plugins install --skill ./60_AGENT_SKILL/agent-executor/SKILL.md
```

安装只让平台发现 Skill，**不产生授权**。在新 Agent 会话中提供精确任务：

```text
task: TASK-000001-R001
role: Builder
startup_mode: fresh
```

完整合同位于正式资料库，至少包含 scope、forbidden、acceptance、inputs、report 与 stop。任务声明 `transport: github_relay` 时，执行 Agent 才同步完整业务项目；没有该声明时，不要求 GitHub。

