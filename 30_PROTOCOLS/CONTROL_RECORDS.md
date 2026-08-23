# Control Records Protocol

本协议定义控制记录的唯一权威与状态。它不要求所有项目使用 GitHub。

## Authority map

- 通用规则、模板与 Skill：本仓。
- 控制项目：指定平台项目与其唯一正式资料库。
- 业务项目事实：对应业务项目仓库或本地项目资料。
- github_relay 任务：指定项目 GitHub 的指定任务位置。
- 执行工作区：临时现场，不是权威记录。

## Status

~~~text
DRAFT → APPROVED → DISPATCHED → ACKNOWLEDGED → IN_PROGRESS
      → SUBMITTED → VERIFIED → ACCEPTED → CLOSED
~~~

控制角色建立和修订任务；执行角色提交；Verifier 验证；Human 接受。不得由同一执行角色定义、实现、验证和接受同一工作。

## Single-record rule

每个任务、decision、dispatch、report 和 evidence 只有一个正式位置。不得为同一对象写入镜像、副本、补丁聊天合同或防御性备份。