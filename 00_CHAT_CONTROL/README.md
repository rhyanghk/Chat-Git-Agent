# Chat Control Project

本目录定义协作控制项目。它适用于 ChatGPT Web、Claude Web、Claude Code 的 Chat 用法及其他 Chat 平台；它不是业务代码仓，也不是 Agent 执行 Skill。

## 职责

- 加载项目指令和正式控制资料；
- 让 Human、Global Architect、Project Architect 以明确角色协作；
- 建立、修订、派发、回收和收敛编号化任务；
- 维护任务、决定与结果的指针，而不把聊天文本变成合同；
- 在人工复制派发时，复制最小 pointer 或正式模板，不复制临时聊天解释。

## 不做

- 不直接承担 Builder、Research、Repair、Verifier、Runner 或 Release 工作；
- 不把通用规则写进业务仓库；
- 不根据模型建议自行扩大授权、验收或执行远端重大动作；
- 不要求业务项目使用 GitHub。

先读 PROJECT_INSTRUCTIONS.md，再读 DATA_SOURCE_PROTOCOL.md 和所选平台适配文件。