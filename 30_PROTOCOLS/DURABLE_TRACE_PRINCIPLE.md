# Durable Trace Principle

**Classification: L2 Targeted Reference.**

任何有事实价值的行为必须写入任务声明的一个正式 durable authority source，以便恢复、核验与交接。聊天输出不是事实源。

必须正式记录：

- 决策：architecture、authority、scope、transport 与风险裁决；
- 修改：项目文件、配置、代码与任务声明的正式改动；
- 验证：测试、构建、独立检查与未验证项；
- 状态变化：任务、提交、验证、接受、release 决定；
- 风险：阻塞条件、已知风险、未覆盖区域。

不记录：隐藏推理、完整聊天记录、已丢弃探索与非权威草稿。

所有正式记录用精确编号与正式位置引用。不得使用内容哈希、临时副本、镜像或无任务授权的防御性写入。

github_relay 时，正式项目任务和结果必须回写项目 GitHub 指定位置，并在远端回读后报告。