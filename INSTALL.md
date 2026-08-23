# Installation and Use

先选对容器，再复制文件。**协作控制项目、Agent 执行 Skill 和业务项目仓库是三个不同位置。** 不要因为它们都与同一项目有关而混在一起。

| 你要做的事 | 使用的位置 | 不要放入 |
| --- | --- | --- |
| 讨论目标、治理、任务、revision、派发、验收 | 独立的 Chat 协作控制项目 | 业务代码仓库、执行 Agent 会话 |
| 执行一个已派发的编号任务 | 支持本地 Skill 的独立 Agent 环境 | ChatGPT Web / Claude Web 的控制会话 |
| 保存代码、测试、项目任务、报告和证据 | 对应业务项目仓库 | 本仓的通用 Chat 架构、完整 Agent Skill |

## 1. Chat 有哪些角色

| 身份 | 所在容器 | 核心责任 | 不做 |
| --- | --- | --- | --- |
| `Human` | Chat 外的真实授权者 | 目标、优先级、风险、验收和重大远端动作 | 不由模型扮演 |
| `Global Architect` | Chat 控制项目 | 跨项目规则、共享接口与治理收敛 | 不默认施工或验收 |
| `Project Architect` | Chat 控制项目 | 单项目任务、revision、边界、派发与回收 | 不扩大 Human 授权 |
| `Builder` / `Research` / `Repair` / `Verifier` / `Runner` / `Release` | 独立 Agent 执行会话 | 只做当前编号任务的执行或验证 | 不承担 Chat 派发、任务设计或最终验收 |

一个 Chat 会话只选择 `Global Architect` 或 `Project Architect` 其中一个模型工作角色。Human 始终保留目标、优先级、风险接受、最终验收、merge、deploy 和 release 的决定权。

## 2. 搭建 Chat 协作控制项目

这个“项目”是 Chat 平台中的协作空间，不是本地业务仓库。

1. 在 ChatGPT Web、Claude Web、Claude Code 的 Chat 模式或其他 Chat 平台中新建一个独立协作控制项目。
2. 载入 [00_CHAT_CONTROL/PROJECT_INSTRUCTIONS.md](00_CHAT_CONTROL/PROJECT_INSTRUCTIONS.md)、[00_CHAT_CONTROL/DATA_SOURCE_PROTOCOL.md](00_CHAT_CONTROL/DATA_SOURCE_PROTOCOL.md)、所选 Chat 工作角色规则，以及当前项目的正式控制资料。
3. 用 [50_TEMPLATES/CHAT_PROJECT_BOOTSTRAP.md](50_TEMPLATES/CHAT_PROJECT_BOOTSTRAP.md) 明确 Human、当前 Chat 工作角色、项目和唯一正式资料库。
4. 只在需要执行时，向独立 Agent 环境人工复制 `Minimal Agent Seed` 或批准的完整任务模板。

平台说明：

- ChatGPT Web：[CHATGPT_WEB.md](00_CHAT_CONTROL/PLATFORM_ADAPTERS/CHATGPT_WEB.md)。它只做 Chat 控制，不安装本地执行 Skill。
- Claude Web：[CLAUDE_WEB.md](00_CHAT_CONTROL/PLATFORM_ADAPTERS/CLAUDE_WEB.md)。它只做 Chat 控制，不安装本地执行 Skill。
- Claude Code：若当前会话是 Chat 控制，按 [CLAUDE_CODE_CHAT.md](00_CHAT_CONTROL/PLATFORM_ADAPTERS/CLAUDE_CODE_CHAT.md) 工作；若要执行任务，关闭该控制会话并重新启动独立 Agent 会话。
- 其他 Chat：[GENERIC_CHAT.md](00_CHAT_CONTROL/PLATFORM_ADAPTERS/GENERIC_CHAT.md)。不能持久化资料时，Human 每次提供所需的最小正式资料集合。

## 3. 安装 Agent 执行 Skill

`agent-executor` 只安装到 **用户级的 Agent Skill 目录**。它不进入业务项目仓库，也不进入 Chat 控制项目。

当前可安装的项目主线为 `mainline/PROJECT-0001`：

```sh
git clone --branch mainline/PROJECT-0001 --depth 1 https://github.com/rhyanghk/Chat-Git-Agent.git Chat-Git-Agent
cd Chat-Git-Agent
```

macOS / Linux 运行一个与平台对应的明确命令：

```sh
./60_AGENT_SKILL/scripts/install-agent-executor.sh --platform codex
./60_AGENT_SKILL/scripts/install-agent-executor.sh --platform claude-code
./60_AGENT_SKILL/scripts/install-agent-executor.sh --platform cursor
./60_AGENT_SKILL/scripts/install-agent-executor.sh --platform copilot
./60_AGENT_SKILL/scripts/install-agent-executor.sh --platform gemini
```

Windows PowerShell 从同一克隆目录运行：

```powershell
.\60_AGENT_SKILL\scripts\install-agent-executor.ps1 -Platform codex
.\60_AGENT_SKILL\scripts\install-agent-executor.ps1 -Platform claude-code
.\60_AGENT_SKILL\scripts\install-agent-executor.ps1 -Platform cursor
.\60_AGENT_SKILL\scripts\install-agent-executor.ps1 -Platform copilot
.\60_AGENT_SKILL\scripts\install-agent-executor.ps1 -Platform gemini
```

脚本的安装位置与平台如下。`--target <skill-root>` 可用于其他遵循 Agent Skills 的平台；该目录必须直接容纳 `agent-executor/SKILL.md`。

| Agent 平台 | 用户级安装位置 | 明确安装命令 | 发现 / 调用 |
| --- | --- | --- | --- |
| Codex | `~/.agents/skills/agent-executor` | `--platform codex` | 新会话后用 `$agent-executor` 或让匹配的编号任务自动触发 |
| Claude Code | `~/.claude/skills/agent-executor` | `--platform claude-code` | 新会话后用 `/agent-executor` 或按描述自动触发 |
| Cursor | `~/.agents/skills/agent-executor` | `--platform cursor` | 新 Agent 会话后用 `/agent-executor` 或从 Skills 选择 |
| GitHub Copilot | `~/.agents/skills/agent-executor` | `--platform copilot` | 新会话后用 `/agent-executor`；可用 `copilot plugins list --kind skill` 检查 |
| Gemini CLI | `~/.agents/skills/agent-executor` | `--platform gemini` | 在交互会话运行 `/skills reload`、`/skills list`，再提供编号任务 |
| 其他兼容平台 | 平台规定的用户级 Skill 根目录 | `--target /path/to/skill-root` | 依该平台的发现与调用方式 |

安装器遇到已存在的 `agent-executor` 会停止。它不会覆盖、删除、备份、镜像或创建第二个事实源。

## 4. 可分发的 `.skill` 包

已打包的通用 Agent Skills 文件在 [60_AGENT_SKILL/packages/agent-executor.skill](60_AGENT_SKILL/packages/agent-executor.skill)。它是一个只包含 `agent-executor/` 目录的 ZIP 格式 `.skill` 包；源目录在 [60_AGENT_SKILL/agent-executor](60_AGENT_SKILL/agent-executor)。

Gemini CLI 可直接安装这个包：

```sh
gemini skills install ./60_AGENT_SKILL/packages/agent-executor.skill --scope user
```

也可由维护者从当前源目录重新生成一个新位置的包：

```sh
./60_AGENT_SKILL/scripts/package-agent-executor.sh /path/to/empty-output-directory
```

GitHub Copilot CLI 也支持从完整 `SKILL.md` 源目录安装到用户级目录：

```sh
copilot plugins install --skill ./60_AGENT_SKILL/agent-executor/SKILL.md
```

不要通过“远程脚本直接管道执行”的方式安装；先取得并检查来源，再运行本仓脚本或平台自己的安装命令。

## 5. 安装后如何开始执行

安装只让平台能发现 Skill，**不产生任务授权**。在一个新的独立 Agent 会话中，提供精确编号任务，至少能解析：任务编号与 revision、执行角色、正式 authority source、scope、forbidden、acceptance、inputs、report 和 stop。最小派发 Seed 只负责寻址：

```text
task: TASK-000001-R001
role: Builder
startup_mode: fresh
```

完整执行规则在 [60_AGENT_SKILL/agent-executor/SKILL.md](60_AGENT_SKILL/agent-executor/SKILL.md) 及其 `references/`。当任务声明 `transport: github_relay`，开始前和结束前必须同步完整业务项目仓库；没有 GitHub 时使用任务指定的本地正式资料库即可。
