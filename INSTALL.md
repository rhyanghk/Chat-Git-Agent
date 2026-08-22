# 安装

只需要安装两个来源文件集合：`chat/` 给 Chat，`agent/` 给 Agent。业务项目本身不要预装本仓库文件。

## 1. Chat 安装

需要的文件只有：

```text
chat/CHAT_CORE.md
```

### ChatGPT Projects

1. 新建或打开一个 ChatGPT Project。
2. 把 `chat/CHAT_CORE.md` 上传到 Project sources。
3. 打开 **Project settings → Project instructions**，加入：

```text
将项目来源中的 CHAT_CORE.md 作为本项目长期工作规则。
涉及项目初始化、恢复、任务创建或修改、Agent 派发、验收、交接、长期记录或仓库写入前，先读取并遵守 CHAT_CORE.md。
如果规则与用户当前明确指令冲突，以用户当前明确指令为准；无法核验时报告 BLOCKED，不要猜。
```

ChatGPT 官方说明 Projects 可以保存项目文件和项目指令，并在项目内持续使用这些内容。

### Claude Projects

1. 新建或打开 Claude Project。
2. 在 Project knowledge 中上传 `chat/CHAT_CORE.md`。
3. 点击 **Set project instructions**，加入与上面相同的三行启动指令。

Claude 官方说明 Project knowledge 会用于该项目内的聊天，Project instructions 会应用到该项目所有聊天。

### Gemini Gems

1. 在 Gemini 网页端打开 **Explore Gems → New Gem**。
2. 在 **Knowledge → Add files** 上传 `chat/CHAT_CORE.md`。
3. 在 Gem instructions 中加入与上面相同的三行启动指令并保存。

Gemini 官方说明 Gems 支持 instructions 和 Knowledge 文件。

### 其他支持项目知识文件的 Chat

如果产品支持“项目级长期指令 + 知识文件”，安装方法相同：上传 `chat/CHAT_CORE.md`，再用一条很短的项目指令要求它在项目治理动作前读取该文件。不要把 Agent 规则一起上传。

---

## 2. Agent 通用文件安装

Release 中需要安装的 Agent 文件：

```text
agent/AGENTS.md
agent/roles/ARCHITECT.md
agent/roles/BUILDER.md
agent/roles/RESEARCH.md
agent/roles/REPAIR.md
agent/roles/VERIFIER.md
agent/roles/RELEASE.md
```

先把它们保存到统一的用户目录，避免多个 Agent 产品各保存一套角色文件。

### macOS / Linux

在 Release 解压目录执行：

```bash
mkdir -p "$HOME/.chat-git-agent/agent/roles"
cp agent/AGENTS.md "$HOME/.chat-git-agent/agent/AGENTS.md"
cp agent/roles/*.md "$HOME/.chat-git-agent/agent/roles/"
```

统一目录为：

```text
~/.chat-git-agent/agent/AGENTS.md
~/.chat-git-agent/agent/roles/*.md
```

### Windows PowerShell

在 Release 解压目录执行：

```powershell
New-Item -ItemType Directory -Force "$HOME\.chat-git-agent\agent\roles" | Out-Null
Copy-Item .\agent\AGENTS.md "$HOME\.chat-git-agent\agent\AGENTS.md" -Force
Copy-Item .\agent\roles\*.md "$HOME\.chat-git-agent\agent\roles\" -Force
```

统一目录为：

```text
%USERPROFILE%\.chat-git-agent\agent\AGENTS.md
%USERPROFILE%\.chat-git-agent\agent\roles\*.md
```

---

## 3. OpenAI Codex

Codex 会从 `$CODEX_HOME/AGENTS.md` 读取用户级长期规则；标准本地配置通常位于 `~/.codex`。

### macOS / Linux

```bash
mkdir -p "${CODEX_HOME:-$HOME/.codex}"
ln -sfn "$HOME/.chat-git-agent/agent/AGENTS.md" "${CODEX_HOME:-$HOME/.codex}/AGENTS.md"
```

目标文件：

```text
$CODEX_HOME/AGENTS.md
# 未自定义 CODEX_HOME 时通常为：
~/.codex/AGENTS.md
```

### Windows PowerShell

Windows 如果不使用符号链接，直接复制主规则：

```powershell
$CodexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { "$HOME\.codex" }
New-Item -ItemType Directory -Force $CodexHome | Out-Null
Copy-Item "$HOME\.chat-git-agent\agent\AGENTS.md" "$CodexHome\AGENTS.md" -Force
```

更新 Chat-Git-Agent 后，再执行一次复制即可。

---

## 4. Claude Code

Claude Code 的用户级长期规则文件是：

```text
~/.claude/CLAUDE.md
```

Claude Code 支持在 `CLAUDE.md` 中用 `@path` 导入其他文件，所以不需要复制主规则正文。

### macOS / Linux

```bash
mkdir -p "$HOME/.claude"
printf '%s\n' '@~/.chat-git-agent/agent/AGENTS.md' > "$HOME/.claude/CLAUDE.md"
```

### Windows PowerShell

```powershell
New-Item -ItemType Directory -Force "$HOME\.claude" | Out-Null
Set-Content -Path "$HOME\.claude\CLAUDE.md" -Value '@~/.chat-git-agent/agent/AGENTS.md'
```

目标文件：

```text
~/.claude/CLAUDE.md
```

---

## 5. OpenCode

OpenCode 官方支持全局规则文件：

```text
~/.config/opencode/AGENTS.md
```

### macOS / Linux

```bash
mkdir -p "$HOME/.config/opencode"
ln -sfn "$HOME/.chat-git-agent/agent/AGENTS.md" "$HOME/.config/opencode/AGENTS.md"
```

### Windows PowerShell

```powershell
New-Item -ItemType Directory -Force "$HOME\.config\opencode" | Out-Null
Copy-Item "$HOME\.chat-git-agent\agent\AGENTS.md" "$HOME\.config\opencode\AGENTS.md" -Force
```

目标文件：

```text
~/.config/opencode/AGENTS.md
```

---

## 6. Cursor Agent

Cursor 当前官方的全局规则入口是 **Customize → Rules → User Rules**，不是一个官方固定的用户级规则文件目录。

在 User Rules 中加入：

```text
Before starting an Agent task, read the user rule file at ~/.chat-git-agent/agent/AGENTS.md (Windows: %USERPROFILE%\.chat-git-agent\agent\AGENTS.md) and follow it. When the task specifies a role, also read the matching file under ~/.chat-git-agent/agent/roles/ before execution. If these files are not accessible, stop and report BLOCKED_RULES_UNAVAILABLE.
```

这是 UI 安装方式；不要为了 Cursor 在每个业务项目创建 `.cursor/rules`，否则会破坏“业务项目零预装”的边界。

---

## 7. 业务项目

业务项目**什么都不要复制**。

第一次使用时，把真实项目交给已经安装 `CHAT_CORE.md` 的 Chat，并明确说：

```text
初始化这个项目。
```

Chat 会根据真实代码、配置和现有文档建立该项目自己的 `.ai/`。

---

## 8. GitHub

GitHub 可选。使用 GitHub 时正常 clone / pull / push；Agent 开工前先同步到本地，完成并验证后再按任务授权同步回远端。

不使用 GitHub 时，本地项目文件和 `.ai/` 仍然可以完成完整流程。

## 官方依据

- ChatGPT Projects: https://help.openai.com/en/articles/10169521-projects-in-chatgpt
- Claude Projects: https://support.claude.com/en/articles/9519177-how-can-i-create-and-manage-projects
- Gemini Gems: https://support.google.com/gemini/answer/15235603
- OpenAI Codex / AGENTS.md: https://openai.com/index/unrolling-the-codex-agent-loop/
- Claude Code / CLAUDE.md: https://code.claude.com/docs/en/memory
- OpenCode rules: https://opencode.ai/docs/rules/
- Cursor rules: https://cursor.com/docs/rules
