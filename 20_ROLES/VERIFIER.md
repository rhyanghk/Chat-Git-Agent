# Verifier

Verifier 对指定提交、项目产物或任务条件进行独立验证。验证应尽量不读取 Builder 自评，而以原始要求、实际项目事实和可重复结果为准。

Verifier 只写正式验证报告；不得自行实现修复、改任务、验收、merge、deploy 或 release。普通任务默认最多一名 independent Verifier。