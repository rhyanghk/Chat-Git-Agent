# 安装

本项目分成三层：Chat 规则、Agent 规则、业务项目。只安装前两层；业务项目保持零预装。下面的“源文件 → 目标”是文件放置关系，不是跨平台统一目录，也不提供文件复制、移动或安装命令。

## 1. Chat 安装

需要安装的唯一 Chat 规则源文件：

```text
chat/CHAT_CORE.md
```

### ChatGPT Projects

- `chat/CHAT_CORE.md` → Project sources。
- 在 Project settings → Project instructions 中加入：

  ```text
  将项目来源中的 CHAT_CORE.md 作为本项目长期工作规则。
  涉及项目初始化、恢复、任务创建或修改、Agent 派发、验收、交接、长期记录或仓库写入前，先读取并遵守 CHAT_CORE.md。
  如果规则与用户当前明确指令冲突，以用户当前明确指令为准；无法核验时报告 BLOCKED，不要猜。
  ```

官方入口：[Projects in ChatGPT](https://help.openai.com/en/articles/10169521-projects-in-chatgpt)（Project sources、Project settings 和 Project instructions）。

### Claude Projects

- `chat/CHAT_CORE.md` → Project knowledge。
- 在 Set project instructions 中加入与 ChatGPT Projects 相同的三行启动指令。

官方入口：[How can I create and manage projects?](https://support.anthropic.com/en/articles/9519177-how-can-i-create-and-manage-projects)（Project knowledge、Set project instructions）。

### Gemini Gems

- `chat/CHAT_CORE.md` → Gem 的 Knowledge → Add files。
- 在 Gem instructions 中加入与 ChatGPT Projects 相同的三行启动指令。

官方入口：[Tips for creating custom Gems](https://support.google.com/gemini/answer/15235603)（New Gem、instructions 和 Knowledge）。

其他 Chat 产品只有在同时提供“项目级长期指令”和“项目知识文件”入口时才按同一原则安装；没有可核验入口时标记为 unsupported，不猜固定目录。

## 2. Agent 规则文件

Release 中的 Agent 源文件为：

```text
agent/AGENTS.md
agent/roles/ARCHITECT.md
agent/roles/BUILDER.md
agent/roles/RESEARCH.md
agent/roles/REPAIR.md
agent/roles/VERIFIER.md
agent/roles/RELEASE.md
```

每个平台只把通用规则接入它实际读取的入口。角色规则不是跨平台约定的自动目录；如果平台不自动发现 `roles/*.md`，必须在任务启动时显式提供匹配角色文件。

### OpenAI Codex

- `agent/AGENTS.md` → `$CODEX_HOME/AGENTS.md`。
- `agent/roles/<ROLE>.md` → 用户在 `$CODEX_HOME` 下自选的管理位置，例如 `$CODEX_HOME/role-rules/<ROLE>.md`；该位置不是 Codex 自动读取目录。
- Codex 官方会读取 `$CODEX_HOME` 中的 `AGENTS.md` / `AGENTS.override.md`，但没有在该入口规则中自动选择 `roles/*.md` 的约定。每次 Agent 启动时，按 Chat 提示读取匹配的角色文件，或把该文件内容作为任务上下文提供。

官方依据：[Unrolling the Codex agent loop](https://openai.com/index/unrolling-the-codex-agent-loop/)（`$CODEX_HOME` 与 `AGENTS.md` 加载顺序）。

### Claude Code

- macOS/Linux：`agent/AGENTS.md` → 用户自选的 `~/.claude/chat-git-agent/AGENTS.md`；Windows：对应用户目录下的 `.claude/chat-git-agent/AGENTS.md`。这是源文件的管理位置，不是 Claude Code 的自动入口。
- macOS/Linux：`~/.claude/CLAUDE.md`；Windows：用户目录下的 `.claude/CLAUDE.md` → 写入 `@<上述 AGENTS.md 的绝对路径>`，让 Claude Code 读取通用规则。
- `agent/roles/<ROLE>.md` → 同一用户管理位置下的 `roles/<ROLE>.md`；在当前角色的 Claude Code 指令文件中显式加入 `@<该角色文件的绝对路径>`，或按任务提示提供该文件。Claude Code 不会因为存在 `roles/` 就自动选择角色。

官方依据：[How Claude remembers your project](https://code.claude.com/docs/en/memory)（用户级 `CLAUDE.md`、`@path` 导入和 `AGENTS.md` 兼容方式）。

### OpenCode

- `agent/AGENTS.md` → `~/.config/opencode/AGENTS.md`（OpenCode 官方的全局规则入口）。
- `agent/roles/<ROLE>.md` → 用户自选的 `~/.config/opencode/chat-git-agent/roles/<ROLE>.md`；该目录不是 OpenCode 自动扫描的角色目录。
- 在 `~/.config/opencode/opencode.json` 的 `instructions` 数组中加入当前任务所需角色文件的路径，或按任务启动提示显式提供该文件。OpenCode 支持通过 `instructions` 配置加载额外文件，但不会自动按 `roles/<ROLE>.md` 选择角色。

官方依据：[Rules | OpenCode](https://opencode.ai/docs/rules/)（全局 `AGENTS.md`、规则优先级和 `instructions` 配置）。

### Cursor Agent

- `agent/AGENTS.md` → Cursor Settings → Rules → User Rules；将通用规则作为用户级纯文本规则保存。
- `agent/roles/<ROLE>.md` → 同一 User Rules UI；开始某个角色的任务时，把匹配角色规则追加到 User Rules，或按任务提示显式提供该文件内容。Cursor User Rules 不提供 `roles/*.md` 自动选择机制。
- 不把这些文件放进业务项目的 `.cursor/rules`；这样会破坏业务项目零预装边界。

官方依据：[Cursor Rules](https://cursor.com/docs/rules)（User Rules、Project Rules、AGENTS.md 和规则类型）；当前官方资料没有为 User Rules 提供固定用户级文件目录，因此只写 UI 入口。

## 3. 角色读取要求

Agent 启动时按以下顺序读取：当前平台已安装的通用规则、Chat 启动提示、指定 revision 的 TASK、任务列出的必要项目文件、匹配的角色规则。若平台不能自动读取角色文件，Chat 或用户必须通过该平台支持的导入机制或任务上下文显式提供；不能猜测、静默跳过或把通用规则复制进业务项目。

## 4. 业务项目

业务项目什么都不要预装。首次使用时，把真实项目交给已安装 `CHAT_CORE.md` 的 Chat，并明确说：

```text
初始化这个项目。
```

Chat 只按真实项目建立该项目自己的 `.ai/`。本仓库的 `CHAT_CORE.md`、`AGENTS.md`、`roles/` 和安装说明都不进入业务项目。

## 5. GitHub

GitHub 只是可选的同步和版本记录工具，不是运行前提。没有 GitHub 时，按本地文件和本地 ref 完成同一套安装与协作流程。
