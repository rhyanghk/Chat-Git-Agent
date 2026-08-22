# 项目说明

last_verified_ref: 23f0fdda391963d00f4f6081e613baba8b5876be

## 用途

提供一套简单的用户与 AI 工具长期协作规则：Chat 负责安排和验收，Agent 按正式任务工作，业务项目用自身 `.ai/` 保存以后继续工作所需的项目事实。

## 已确认的长期限制

- 用户可见说明优先使用通俗简体中文；普通目录和文件名使用英文。
- Chat 规则只安装在 Chat。
- Agent 规则只安装在 Agent 用户环境。
- 业务项目零预装；首次接入后由 Chat 根据真实项目建立 `.ai/`。
- GitHub 只用于同步和版本记录；不使用 GitHub 也要能完成完整流程。
- 项目可跟随 `youling/ai-use` 的实际规则变化更新，但不能自动推翻用户已确认的固定边界。
- Release 安装包只包含 README、INSTALL、USAGE 和实际需要安装的 Chat/Agent 规则文件。

## 主要入口

- `README.md`
- `INSTALL.md`
- `USAGE.md`
- `chat/CHAT_CORE.md`
- `agent/AGENTS.md`
- `maintenance/UPSTREAM.md`
- `maintenance/AUDIT.md`

## 外部来源

当前用于核对的原项目：

```text
youling/ai-use@1ddfeb0dd6a606dbc80ab86de8903d6888077bc6
```

## 当前发布状态

- 已审计产品内容 ref：`23f0fdda391963d00f4f6081e613baba8b5876be`。
- v1.0.0 发布 ZIP 已生成并校验。
- 当前 GitHub 连接没有 Create Release / 上传 Release asset 的可调用动作，因此正式 GitHub Release 尚未创建。
