# 安装与首次使用

先区分三个位置：**Chat 协作控制项目**用于讨论目标、任务和验收；**Agent 执行环境**用于执行一个已派发任务；**业务项目仓库**只保存该业务项目的资料。三者不能因为服务同一项目而混在一起。

## 1. 先确定身份与工作位置

| 当前身份 | 使用的位置 | 当前职责 | 不能做什么 |
| --- | --- | --- | --- |
| `Human` | Chat 外 | 决定目标、优先级、风险、验收与重大远端动作 | 由模型扮演 |
| `Global Architect` | Chat 协作控制项目 | 跨项目规则、共享接口和治理收敛 | 默认施工或最终验收 |
| `Project Architect` | Chat 协作控制项目 | 单项目任务、revision、边界、派发与回收 | 扩大 Human 授权 |
| `Builder`、`Research`、`Repair`、`Verifier`、`Runner`、`Release` | 独立 Agent 执行会话 | 只执行或验证当前编号任务 | 设计任务、派发任务、最终验收 |

一个 Chat 会话只能选择一个模型控制角色：`Global Architect` 或 `Project Architect`。`Human` 始终在 Chat 外；执行角色不能在 Chat 控制会话中承担。

## 2. 配置 Chat 协作控制项目

这里的“配置”**不是安装 Skill**，也不是上传业务项目。它只让 Chat 在控制工作中知道自己的边界、当前角色和去哪里读取正式记录。

### 固定配置与按需资料

首次配置时，只放入两份通用静态资料：

1. 将 [PROJECT_INSTRUCTIONS.md](00_CHAT_CONTROL/PROJECT_INSTRUCTIONS.md) 的正文放入平台的 Project Instructions、Custom Instructions 或等价项目指令位置。
2. 将 [CONTROL_ROLES.md](00_CHAT_CONTROL/CONTROL_ROLES.md) 作为只读角色参考资料；平台没有项目文件功能时，Human 在首次会话附上或提供其正式位置。

然后指定一个 `authority_store`：当前项目唯一的正式资料库。它可以是数据库、受控文档库、平台连接的资料源或项目版本库；必须写清 URL、路径、资料库名称或查询方式。

**不要在安装时上传或复制**当前任务、decision、报告、业务代码或完整 Agent Skill。它们仍留在正式资料库或业务项目中。每次实际工作时，Chat 根据当前任务或决策的精确指针按需读取相关文档；项目指令已要求它这样做。

### 各 Chat 平台的配置方法

| 平台 | 一次性配置 | 每次开始控制会话 |
| --- | --- | --- |
| **ChatGPT Web** | 新建一个 **Project**；在项目指令处粘贴 `PROJECT_INSTRUCTIONS.md` 正文；将 `CONTROL_ROLES.md` 放入该项目的 **Sources**。若正式资料库可作为连接源使用，连接它；否则只保存其精确访问说明。 | 从该 Project 新建 Chat，发送下方的启动卡。不要把可变项目控制记录作为 Project Sources 的副本上传。 |
| **Claude Web** | 新建一个独立 Project；在该 Project 的自定义指令位置粘贴 `PROJECT_INSTRUCTIONS.md`；将 `CONTROL_ROLES.md` 放入项目知识或文件。记录唯一正式资料库的访问方式。 | 在该 Project 内新建会话，发送启动卡；只按卡片指针读取当前项目记录。 |
| **Claude Code 的控制会话** | 建立一个独立的控制工作区，不打开业务项目仓库；把 `PROJECT_INSTRUCTIONS.md` 的正文放入该工作区的 `CLAUDE.md` 或当前会话指令，将 `CONTROL_ROLES.md` 作为同一控制工作区的只读参考。 | 以控制角色启动一个新会话，提供启动卡。不要在这个控制工作区安装执行 Skill 或修改业务代码。 |
| **不支持本地 Skill 的其他 Chat** | 若平台有 Project、项目指令或项目文件功能，按上面两份静态资料配置；没有持久项目功能时，把短项目指令保存为固定提示，并保留 `CONTROL_ROLES.md` 的正式位置。 | 每个新会话提供短项目指令、角色参考位置和启动卡；只附当前事项所需的精确资料。 |

ChatGPT Projects 的共享内容是项目指令、文件和连接资料源；它不直接访问你的本地文件夹。项目内应从同一 Project 新建不同的控制会话，而不是把所有工作压进一个聊天。官方说明见 [ChatGPT Projects](https://learn.chatgpt.com/docs/projects)。

### Chat 会话启动卡

建立或恢复控制会话时，Human 只需给出指针，不复制完整任务：

```text
当前模型角色: <Global Architect | Project Architect>
当前项目: <PROJECT-0001>
正式资料库: <URL、路径、资料库名称或查询方式>
当前事项: <TASK、DECISION 或项目记录的精确位置>

请按项目指令读取完成当前事项所需的文档；资料、角色、项目或指针缺失时只返回 BLOCKED 和缺失项。
```

需要首次登记或恢复控制项目时，用 [CHAT_PROJECT_BOOTSTRAP.md](50_TEMPLATES/CHAT_PROJECT_BOOTSTRAP.md)。完成后检查：模型角色、项目、正式资料库和当前事项均有明确位置；若任一缺失，不开始派发或验收。

## 3. 安装 Agent 执行 Skill

`agent-executor` 只安装到**用户级 Agent Skill 目录**。它不进入 Chat 控制项目，也不进入业务项目仓库。

当前可安装的新主线是 `mainline/PROJECT-0001`：

```sh
git clone --branch mainline/PROJECT-0001 --depth 1 https://github.com/rhyanghk/Chat-Git-Agent.git Chat-Git-Agent
cd Chat-Git-Agent
```

macOS / Linux：运行与你的 Agent 平台对应的一条命令。

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

| Agent 平台 | 安装目录 | 安装后调用 |
| --- | --- | --- |
| Codex | `~/.agents/skills/agent-executor` | 新会话输入 `$agent-executor`，再提供编号任务 |
| Claude Code | `~/.claude/skills/agent-executor` | 新会话输入 `/agent-executor`，再提供编号任务 |
| Cursor | `~/.agents/skills/agent-executor` | 新 Agent 会话从 Skills 选择或输入 `/agent-executor` |
| GitHub Copilot | `~/.agents/skills/agent-executor` | 新会话输入 `/agent-executor`；可用 `copilot plugins list --kind skill` 检查 |
| Gemini CLI | `~/.agents/skills/agent-executor` | 运行 `/skills reload`、`/skills list`，再提供编号任务 |
| 其他兼容平台 | 平台规定的用户级 Skill 根目录 | 用 `--target /path/to/skill-root` 安装，再依平台方式调用 |

安装器遇到已有的 `agent-executor` 会停止；不会覆盖、删除、备份、镜像或制造第二个事实源。

## 4. 使用 `.skill` 分发包

可直接分发的文件是 [agent-executor.skill](60_AGENT_SKILL/packages/agent-executor.skill)，它只包含 `agent-executor/`。源目录为 [60_AGENT_SKILL/agent-executor](60_AGENT_SKILL/agent-executor)。

Gemini CLI 可以直接安装该包：

```sh
gemini skills install ./60_AGENT_SKILL/packages/agent-executor.skill --scope user
```

GitHub Copilot CLI 可以从源 `SKILL.md` 安装：

```sh
copilot plugins install --skill ./60_AGENT_SKILL/agent-executor/SKILL.md
```

维护者需要重新打包时，输出目录必须为空：

```sh
./60_AGENT_SKILL/scripts/package-agent-executor.sh /path/to/empty-output-directory
```

## 5. 在 Agent 中开始任务

安装只让平台发现 Skill，**不产生授权**。在新的独立 Agent 会话中，提供可解析的正式任务：任务编号和 revision、角色、正式资料库、scope、forbidden、acceptance、inputs、report 和 stop。最小派发 Seed 只负责寻址：

```text
task: TASK-000001-R001
role: Builder
startup_mode: fresh
```

任务声明 `transport: github_relay` 时，执行 Agent 在开始前和结束前必须同步完整业务项目仓库；没有该声明时，按任务指定的本地或其他正式资料库执行。完整规则见 [agent-executor/SKILL.md](60_AGENT_SKILL/agent-executor/SKILL.md)。

