# 安装与全流程使用

安装完成后，Chat 与 Agent 可以通过共享资料库、GitHub 中继或 Human 原样复制完成完整闭环。Chat 控制项目、Agent Skill 和业务项目仓库是三个不同位置，不能混放。

## 1. 配置 Chat 协作控制项目

这不是安装 Skill，也不是上传业务项目。Chat 只需要两份通用静态资料：

1. 将 [PROJECT_INSTRUCTIONS.md](CHAT_CONTROL/PROJECT_INSTRUCTIONS.md) 的正文放入平台的项目指令、Custom Instructions 或等价位置。
2. 将 [CONTROL_RUNTIME.md](CHAT_CONTROL/CONTROL_RUNTIME.md) 作为项目静态资料上传或提供。它包含控制角色、完整任务流程和所有正式记录格式。

为每个业务项目准备一个唯一 `authority_store`：数据库、受控文档库、项目版本库或其他 Human 能定位的正式记录位置。它在首次正式 TASK、TASK-STATE、DECISION、REPORT 或交接前必须绑定；新项目的只读发现与架构草案阶段可先为 `pending`。资料库至少要能保存可定位的正式记录原文，并说明 Chat、Human 和 Agent 的读写方式。不要把业务代码、当前任务、报告或完整 Agent Skill 上传为 Chat 项目的固定资料。若该 Chat 没有资料库读写权限，Human 原样记录 Chat 输出的正式记录，再把精确位置（以及读不到时的原样副本）交回当前会话。

一个控制项目管理两个或以上业务项目时，在同一正式资料库建立 `CHAT_CONTROL_REGISTRY`；它只登记每个项目的资料库、项目位置、当前主责和当前状态位置。

| 平台 | 一次性操作 | 如何开始新控制会话 |
| --- | --- | --- |
| **ChatGPT Web** | 新建 **Project**；在项目指令处粘贴 `PROJECT_INSTRUCTIONS.md`；将 `CONTROL_RUNTIME.md` 放入 **Sources**。 | 从该 Project 新建 Chat，发送下方启动卡。 |
| **Claude Web** | 新建独立 Project；在自定义项目指令处粘贴项目指令；将控制运行文件放入项目知识或文件。 | 在该 Project 内新建会话，发送启动卡。 |
| **Claude Code 的控制会话** | 建立独立控制工作区，不打开业务项目仓；将项目指令放入 `CLAUDE.md` 或当前会话指令，并把控制运行文件放在同一工作区。 | 以控制角色新建会话，发送启动卡；不安装执行 Skill、不修改业务代码。 |
| **其他不支持本地 Skill 的 Chat** | 有 Project 功能时按上面两份资料配置；没有时每次新会话提供两份资料。 | 发送启动卡；按运行文件选择 `local`、`github_relay` 或 `human_copy`。 |

ChatGPT Web Project 的项目指令会应用于该 Project 的会话，**Sources** 可保存文件和连接资料源；Web Project 不会直接读取本地文件夹。官方说明见 [ChatGPT Projects](https://learn.chatgpt.com/docs/projects)。

### Chat 启动卡

```text
新项目显示名: <optional Human-controlled label or none>
项目位置: <optional exact repository or path, or none>
authority_store: <exact formal location or pending>
authority_access: <Chat read/write | Chat read only | Human recording (default) | other exact condition>
当前事项: <TASK、TASK-STATE、DECISION、项目记录，或 none>

请先读取 CONTROL_RUNTIME.md。新项目自动以 Project Architect、自动生成的不透明 project_id 和 DISCOVERY 启动；project_id 不影响项目名称、仓库名称或项目位置。正式动作按第 1.6 节绑定资料库、角色授权及适用的 primary claim，并核对项目位置和规则；业务就绪还须启动证据正式落库。
```

当前接口适配 ai-use Agent Interface 2.3.0，派发卡与 Seed 的唯一模板在 CONTROL_RUNTIME 第 4 节。新 Seed 只寻址，完整 TASK 仍是执行门槛；human_copy 不使用 Seed。治理会话无对应项目主责时的检查派发，以及 project_location: none 的纯检查例外，分别遵循控制合同第 1.6 节与执行协议；不用于业务任务。

## 2. 从 Chat 派发到 Agent，再回到 Chat

1. Human 用启动卡建立 Chat 控制会话；Chat 按 `CONTROL_RUNTIME.md` 自动创建 `Project Architect / DISCOVERY` 的 `CHAT_CONTROL_BOOTSTRAP`。这一步生成控制用 `project_id`，但不影响项目名称、仓库名称或项目位置；没有实际任务时不创建 TASK 或 TASK-STATE。
2. Chat 为每个执行角色创建独立任务。任务明确写 `project_location`、`project_rules`、`transport: local`、`github_relay` 或 `human_copy`。
3. Human 启动一个装有 `Chat-Git-Agent` 的独立 Agent 会话：
   - TASK 已声明 local 或 github_relay 且 Agent 可读取完整 TASK 时，只复制控制运行文件“Agent 启动 Seed”中的当前寻址格式；
   - TASK 已声明 human_copy 时，复制完整 `TASK` 记录，不能只复制摘要。访问故障不自动切换 transport；需要变更时先创建新 revision。
4. Agent 只按当前任务工作并产出 `REPORT`：
   - `local` / `github_relay`：写入任务指定位置后给出报告位置；
   - `human_copy`：原样返回完整 `REPORT`，`delivery_state: RETURNED_FOR_HUMAN_RECORDING`，不声称已提交。
5. 只有在 `human_copy` 中，Human 将该 `REPORT` 原样写入 `authority_store`，再将报告位置提供给 Chat。任一传输方式下，如果该 Chat 无法直接读取资料库，同时提供 REPORT 的原样副本和该位置。
6. Chat 从正式资料库或 Human 提供的原样正式记录读取结果、验证和风险；Human 决定是否接受、是否创建新 revision，以及是否授权 merge、deploy 或 release。Chat 将 Human 决定写为 `DECISION`，并以新的 `TASK-STATE` 记录结果。

首次与接任启动按 `CONTROL_RUNTIME.md` 第 1.6–1.7 节记录角色授权、逐项检查证据及继续／停止分类；旧 bootstrap 不追溯补标 READY。Global Architect 与交接接收方按各自门槛处理，不统一要求项目 primary claim。

失联恢复仅按 `CONTROL_RUNTIME.md` 第 4 节的有限授权例外操作。检查点 `checkpoint_reports` 分配变化须新 revision；`human_copy` 阶段报告须等待落库并按执行协议复核后继续，最终报告则停止等待验收。

这样一个 Chat 可以向多个平台、多个执行角色派发；每个 Agent 仍只处理一个独立编号任务。

## 3. 发送一条安装指令给 Agent

需要整理交流时，向 Chat 指定来源范围并说明是否仅显式输出，由控制运行文件第 2.1 节处理；无需安装新角色或新资料库。测试 / 不回写时不产生外部写入。无 Git 的执行任务应在派发前声明 `human_copy`；已派发任务不得自动改变 transport。REPORT 的“验证”同时保留实际生成规则版本和来源覆盖。

`Chat-Git-Agent` 只安装到用户级 Agent Skill 目录，不进入 Chat 控制项目或业务项目仓库。把下列文字原样发送给具有本地文件和网络访问权限的 Agent：

```text
请安装 Chat-Git-Agent Skill。使用 https://github.com/rhyanghk/Chat-Git-Agent 的 main 分支，读取 AGENT_SKILL/scripts 中与当前平台相符的安装器，将 AGENT_SKILL/chat-git-agent 安装到用户级 Skill 目录。不得覆盖、删除、备份或镜像已有的 chat-git-agent；如已存在或当前平台不支持本地 Skill，返回 BLOCKED。安装后重新加载 Skills 或开始新 Agent 会话，并确认 Chat-Git-Agent 会作为每次执行任务的默认入口。
```

安装 Agent 根据自身平台选择下列目标；Human 不必手工拼接多条命令。

| 平台 | 用户级安装位置 | 明确调用名 |
| --- | --- | --- |
| Codex | `~/.agents/skills/chat-git-agent` | `$chat-git-agent` |
| Claude Code | `~/.claude/skills/chat-git-agent` | `/chat-git-agent` |
| Cursor | `~/.agents/skills/chat-git-agent` | `/chat-git-agent` 或 Skills 选择器 |
| GitHub Copilot | `~/.agents/skills/chat-git-agent` | `/chat-git-agent` |
| Gemini CLI | `~/.agents/skills/chat-git-agent` | `/skills reload` 后由 Skills 选择器调用 |
| 其他兼容平台 | 平台规定的用户级 Skill 根目录 | `chat-git-agent` |

Skill 的规范名是 `chat-git-agent`，显示名和分发包名是 `Chat-Git-Agent`。支持隐式调用的平台会依据其元数据自动选择该 Skill。

### 强制默认 Agent 规则

将下列规则写入平台的**用户级 Agent 指令**，不要写入业务项目仓库。它使不支持隐式调用的平台也不能绕过 Skill：

```text
每次开始或恢复 Agent 执行任务时，先调用 Chat-Git-Agent。只有在读取当前精确编号 TASK、角色权限、项目位置、项目规则和任务指定资料后才允许读取、修改、验证或运行项目；任一项缺失、不可读或冲突时只返回 BLOCKED。不得把此规则用于控制会话、任务设计、派发、验收、merge、deploy 或 release 决策。
```

平台若完全不加载本地 Skill，也没有用户级 Agent 指令入口，就不能技术性强制自动调用；该平台只能作为 Chat 使用，或在每次 Agent 会话开始时原样提供上述规则。

## 4. 手动安装与首次执行

安装 Agent 也可以执行下列命令；`<platform>` 只能是 `codex`、`claude-code`、`cursor`、`copilot` 或 `gemini`。

```sh
git clone --depth 1 https://github.com/rhyanghk/Chat-Git-Agent.git Chat-Git-Agent
cd Chat-Git-Agent
./AGENT_SKILL/scripts/install-chat-git-agent.sh --platform <platform>
```

Windows PowerShell：

```powershell
.\AGENT_SKILL\scripts\install-chat-git-agent.ps1 -Platform <platform>
```

[Chat-Git-Agent.skill](AGENT_SKILL/packages/Chat-Git-Agent.skill) 是可分发包。Gemini CLI 可安装该包：

```sh
gemini skills install ./AGENT_SKILL/packages/Chat-Git-Agent.skill
```

GitHub Copilot CLI 可从源 `SKILL.md` 安装：

```sh
copilot plugins install --skill ./AGENT_SKILL/chat-git-agent/SKILL.md
```

安装只让平台发现 Skill，不产生授权。共享资料库可达时，使用 [CONTROL_RUNTIME.md 的 Agent 启动 Seed](CHAT_CONTROL/CONTROL_RUNTIME.md#agent-启动-seed)；按地址选择私仓工单、公仓工单或任务记录，不在安装文档维护第二份模板。

使用 `human_copy` 时，提供控制运行文件生成的完整 `TASK` 记录。Skill 会据此工作并返回完整 `REPORT`，由 Human 原样记录到唯一正式资料库；记录后的精确位置再交回 Chat。

新建控制工作空间需在 bootstrap/registry 记录 governance_source 与 authority_store；无业务项目使用空 projects，不省略治理登记。旧记录通过新 revision 补齐，不追溯改标。Release 合并检查须验证已审查 head 的原子保护能力；不支持保护时停止，不用成功读取冒充可安全写入。

## 5. 首次闭环验证

长任务派发前补齐 checkpoint_reports；私有 GitHub 源在首次访问前提供 access 提示。验证写入失败时返回完整 NOT_WRITTEN 且不自动转 human_copy；未知写入结果先回读；旧架构师失联时仅凭正式 Human recovery 授权补派检查，不能派业务；英文模板不覆盖中文默认，而明确 Human 语言要求可覆盖。均按控制运行文件及执行协议执行，不改写旧记录。

升级后重新提供两份 Chat 静态资料和更新的执行 Skill（已有安装仍遵守安装器停止规则）。新派发检查 `task` 与标题一致、`project_id` 独立且不改仓库位置；旧 `project` 合同先由控制层发新 revision。按控制运行文件测试当前五字段派发卡、四类运行位置与寻址 Seed、架构现状核对触发及交接各阶段；任一交接前置证据缺失不得接受，接受后仍须启动检查通过。不得将更新文档视为既有任务或交接已重新验证。

在真实业务任务前，使用一个可丢弃的测试项目完成一次最小闭环：

1. 建立 Chat 控制项目，确认它以 `Project Architect / DISCOVERY` 和自动生成的 `project_id` 启动；确认该 ID 不改变项目名称、仓库名称或项目位置。首次正式任务前，再绑定 `authority_store` 并确认读写方式。
2. 创建一份仅执行 `BOOTSTRAP_CHECK` 的 Runner TASK：必须写明 `project_location`、`project_rules`、REPORT 位置和 `transport`。Agent 返回或写入完整 REPORT。
3. 创建一份只读 Research 或 Verifier TASK，确认 Agent 能读取任务、项目规则和正式资料，但不会把聊天内容当合同。
4. 创建一份范围极小的 Builder TASK，在隔离副本内完成可观察改动并提交 REPORT；Chat 记录 REPORT 后，Human 写入 `DECISION` 与新的 `TASK-STATE`。
5. 如要使用 `github_relay`，在可丢弃仓库额外验证完整项目同步、隔离分支、授权回写和远端回读。
6. 如要使用 `human_copy`，额外验证 Human 逐字复制完整 TASK、完整 REPORT 和正式记录位置，不用摘要替代。

任一步无法满足时，记录 `BLOCKED`，先修正资料库、项目位置、规则或平台安装，不把测试结论当作接受业务任务。
