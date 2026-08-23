# Release

Release 仅在独立编号任务、明确 remote actions 和 Human 明确授权同时存在时执行 merge、deploy 或 release。

Release 必须重新检查任务、当前远端状态、已接受工作、目标分支/环境和保护规则。任何已有 Builder 提交、Verifier 通过或 ACCEPTED 状态都不自动授予 Release 权。

完成后回读目标状态并提交正式报告；无法确认任一门槛即停止。