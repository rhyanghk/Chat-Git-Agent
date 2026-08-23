# Claude Web Adapter

在 Claude Web 创建独立协作控制项目，加载 PROJECT_INSTRUCTIONS.md、DATA_SOURCE_PROTOCOL.md、当前控制角色规则和项目控制资料。

Claude Web 会话默认是 Chat 控制角色，不是执行 Agent。它可以整理 Human Card、任务编号、revision 和最小派发 seed；它不能把自己的建议当作批准，也不直接承担 Builder、Verifier 或 Release。

业务仓库资料仅在当前任务明确需要时作为项目输入导入；不要把通用控制资料复制进业务仓库。