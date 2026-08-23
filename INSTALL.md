# 安装与全流程使用

安装完成后，Chat 与 Agent 可以通过共享资料库、GitHub 中继或 Human 原样复制完成完整闭环。Chat 控制项目、Agent Skill 和业务项目仓库是三个不同位置，不能混放。

## 1. 配置 Chat 协作控制项目

这不是安装 Skill，也不是上传业务项目。Chat 只需要两份通用静态资料：

1. 将 [PROJECT_INSTRUCTIONS.md](00_CHAT_CONTROL/PROJECT_INSTRUCTIONS.md) 的正文放入平台的项目指令、Custom Instructions 或等价位置。
2. 将 [CONTROL_RUNTIME.md](00_CHAT_CONTROL/CONTROL_RUNTIME.md) 作为项目静态资料上传或提供。它包含控制角色、完整任务流程和所有正式记录格式。

再为每个业务项目指定一个唯一 `authority_store`：数据库、受控文档库、项目版本库或其他 Human 能定位的正式记录位置。不要把业务代码、当前任务、报告或完整 Agent Skill 上传为 Chat 项目的固定资料。若该 Chat 没有资料库读写权限，Human 原样记录 Chat 输出的正式记录，再把精确位置（以及读不到时的原样副本）交回当前会话。

| 平台 | 一次性操作 | 如何开始新控制会话 |
| --- | --- | --- |
| **ChatGPT Web** | 新建 **Project**；在项目指令处粘贴 `PROJECT_INSTRUCTIONS.md`；将 `CONTROL_RUNTIME.md` 放入 **Sources**。 | 从该 Project 新建 Chat，发送下方启动卡。 |
| **Claude Web** | 新建独立 Project；在自定义项目指令处粘贴项目指令；将控制运行文件放入项目知识或文件。 | 在该 Project 内新建会话，发送启动卡。 |
| **Claude Code 的控制会话** | 建立独立控制工作区，不打开业务项目仓；将项目指令放入 `CLAUDE.md` 或当前会话指令，并把控制运行文件放在同一工作区。 | 以控制角色新建会话，发送启动卡；不安装执行 Skill、不修改业务代码。 |
| **其他不支持本地 Skill 的 Chat** | 有 Project 功能时按上面两份资料配置；没有时每次新会话提供两份资料。 | 发送启动卡；按运行文件选择 `local`、`github_relay` 或 `human_copy`。 |

ChatGPT Web Project 的项目指令会应用于该 Project 的会话，**Sources** 可保存文件和连接资料源；Web Project 不会直接读取本地文件夹。官方说明见 [ChatGPT Projects](https://learn.chatgpt.com/docs/projects)。

### Chat 启动卡

```text
当前模型角色: <Global Architect | Project Architect>
当前项目: <PROJECT-0001>
authority_store: <唯一正式资料库的 URL、路径、名称或查询方式>
当前事项: <TASK、DECISION、项目记录，或 none>

请先读取 CONTROL_RUNTIME.md，再按其中流程处理当前事项；缺少角色、项目、资料库、指针或访问时只返回 BLOCKED 和缺失项。
```

## 2. 从 Chat 派发到 Agent，再回到 Chat

1. Human 用启动卡建立 Chat 控制会话；Chat 按 `CONTROL_RUNTIME.md` 创建 `CHAT_CONTROL_BOOTSTRAP` 和编号 `TASK`。
2. Chat 为每个执行角色创建独立任务。任务明确写 `transport: local`、`github_relay` 或 `human_copy`。
3. Human 启动一个装有 `agent-executor` 的独立 Agent 会话：
   - Agent 可读取 `authority_source` 时，只复制控制运行文件中的完整 `SEED-TASK-...`；
   - Agent 不可读取时，使用 `human_copy`，复制完整 `TASK` 记录，不能只复制摘要。
4. Agent 只按当前任务工作并产出 `REPORT`：
   - `local` / `github_relay`：写入任务指定位置后给出报告位置；
   - `human_copy`：原样返回完整 `REPORT`，`delivery_state: RETURNED_FOR_HUMAN_RECORDING`，不声称已提交。
5. 只有在 `human_copy` 中，Human 将该 `REPORT` 原样写入 `authority_store`，再将报告位置提供给 Chat。任一传输方式下，如果该 Chat 无法直接读取资料库，同时提供 REPORT 的原样副本和该位置。
6. Chat 从正式资料库或 Human 提供的原样正式记录读取结果、验证和风险；Human 决定是否接受、是否创建新 revision，以及是否授权 merge、deploy 或 release。

这样一个 Chat 可以向多个平台、多个执行角色派发；每个 Agent 仍只处理一个独立编号任务。

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

| Agent 平台 | 用户级安装目录 | 调用方式 |
| --- | --- | --- |
| Codex | `~/.agents/skills/agent-executor` | 新会话输入 `$agent-executor`，再提供任务 Seed 或完整 TASK |
| Claude Code | `~/.claude/skills/agent-executor` | 新会话输入 `/agent-executor`，再提供任务 Seed 或完整 TASK |
| Cursor | `~/.agents/skills/agent-executor` | 新 Agent 会话从 Skills 选择或输入 `/agent-executor` |
| GitHub Copilot | `~/.agents/skills/agent-executor` | 新会话输入 `/agent-executor`；可用 `copilot plugins list --kind skill` 检查 |
| Gemini CLI | `~/.agents/skills/agent-executor` | 运行 `/skills reload`、`/skills list`，再提供任务 |
| 其他兼容平台 | 平台规定的用户级 Skill 根目录 | 使用 `--target /path/to/skill-root`，再按平台方式调用 |

安装器遇到已有 `agent-executor` 会停止；不会覆盖、删除、备份、镜像或创建第二份事实源。

## 4. `.skill` 包与首次执行

[agent-executor.skill](60_AGENT_SKILL/packages/agent-executor.skill) 是可分发包。Gemini CLI 可安装该包：

```sh
gemini skills install ./60_AGENT_SKILL/packages/agent-executor.skill --scope user
```

GitHub Copilot CLI 可从源 `SKILL.md` 安装：

```sh
copilot plugins install --skill ./60_AGENT_SKILL/agent-executor/SKILL.md
```

安装只让平台发现 Skill，不产生授权。共享资料库可达时提供控制运行文件规定的完整 Seed：

```text
SEED-TASK-000001-R001
---
task: TASK-000001-R001
role: Builder
startup_mode: fresh
authority_source: <完整 TASK 的精确位置>
transport: local
github_repository: none
github_task_location: none
```

使用 `human_copy` 时，提供控制运行文件生成的完整 `TASK` 记录。Skill 会据此工作并返回完整 `REPORT`，由 Human 原样记录到唯一正式资料库；记录后的精确位置再交回 Chat。
