# 执行协议

仅在 Skill 的启动、恢复、GitHub 中继、证据或检查指令需要细节时读取。

## 任务合同

可执行任务必须包含：`task`、`role`、`startup_mode`、`authority_source`、`transport`、`project`、`scope`、`forbidden`、`acceptance`、`inputs`、`report` 和 `stop`。`github_relay` 任务还必须包含仓库、任务位置、基线分支、工作分支、完整同步范围和全部 `remote_actions`；缺失字段一律禁止，不作推断。

## 七项开工检查

1. 角色：身份、角色和会话无歧义；
2. 入口：正式资料位置和精确 revision 可读；
3. 授权：当前角色只拥有任务声明的最小权限；
4. 访问：输入可读、输出可写，能力不等于授权；
5. 当前任务：只处理这一份精确任务；
6. 边界：scope、forbidden、acceptance 和 stop 已读清；
7. 状态：正式资料与项目当前状态没有无法解释的冲突。

任一失败即 `BLOCKED`。`BOOTSTRAP_CHECK` 只执行这七项，不执行任务。

## 本地执行与恢复

本地任务读取正式资料和任务输入；需要写入时使用隔离且被授权的项目副本。`startup_mode: resume` 只用于同一任务、同一 revision、同一角色和可解释现场；只刷新当前任务、当前项目状态、相关输入和上次报告后的正式变化。出现无法解释的变化时停止，不通过扫描全历史或原地改写任务恢复。

## GitHub 中继

1. 在读取任务、实施、验证和回写前刷新远端引用；
2. 记录默认分支、main（如存在）、任务位置、基线、工作分支和本地起点；
3. 在隔离 clone 或 worktree 中同步完整声明项目树、必要 submodule 和 LFS；
4. 任务位置或远端不可读时返回 `BLOCKED_REMOTE_SYNC`；漂移不可解释时返回 `BLOCKED_REMOTE_DRIFT`；
5. 完成后再次刷新远端；工作分支有未解释推进时停止，不覆盖、不 force push；
6. 仅在 `remote_actions` 明确允许时回写指定工作分支，随后回读远端结果并报告。

同步不授权默认分支写入、merge、deploy、release、删除分支或同步无关本地状态。

## 变更、验证与结束

scope、role、baseline、transport、forbidden、acceptance、inputs、report 或 stop 变化时，请求新 revision 并停止。共享接口、安全、权限或正式状态冲突时同样停止。

证据强于自述；准确说明已验证和未验证的内容。Builder、Research、Repair、Runner 与 Verifier 的提交不等于接受。完成后在任务指定位置写正式报告并停止。

