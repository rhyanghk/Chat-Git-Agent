# 执行协议

仅在 Skill 的启动、恢复、GitHub 中继、证据或检查指令需要细节时读取。

## 任务合同与权威

可执行任务必须包含：`task`、`project`、`project_location`、`project_rules`、`role`、`startup_mode`、`authority_source`、`transport`、`baseline`、`human_authorization`、`scope`、`forbidden`、`acceptance`、`inputs`、`report` 和 `stop`。`project_location` 必须给出当前 Agent 可核对的项目副本或项目来源；`project_rules` 必须逐项给出项目本地规则、合同或明确 `none`。不从当前目录、历史消息或仓库名猜测这两项。

`transport` 只能是 `local`、`github_relay` 或 `human_copy`。`github_relay` 任务还必须包含仓库、任务位置、基线分支、工作分支、完整同步范围和全部 `remote_actions`；`human_copy` 任务还必须包含完整的 `human_copy` 区块，声明 `dispatch: full_task_record`、`result: full_result_report` 和记录者。缺失字段一律禁止，不作推断。

冲突只按以下顺序判断：当前有效的 `human_authorization` 指向的 Human 决定 → TASK 明示且当前有效的正式治理或项目决定 → `project_rules` 与项目本地合同 → 当前 TASK → 较早报告或历史记录 → 聊天消息。低层不能覆盖高层；任一冲突不能由当前执行角色安全解释时，提交 `CHANGE` 并停止。

`local` 与 `github_relay` 可以先收到 `SEED-TASK-...`，但 Seed 必须含 `task`、`role`、`startup_mode`、`authority_source`、`transport`，并在 GitHub 中继时含仓库和任务位置。收到 Seed 后必须先读取完整 TASK；不能读取时返回 `BLOCKED`。`human_copy` 不接受 Seed。

## 七项开工检查

1. 角色：身份、角色和会话无歧义；
2. 入口：正式 TASK、项目位置和精确 revision 可读；
3. 授权：当前角色只拥有任务声明的最小权限，能力不等于授权；
4. 访问：任务点名的项目规则、输入和项目副本可读；`local` 与 `github_relay` 的声明输出可写；`human_copy` 已收到完整 TASK、可以原样返回完整 REPORT；
5. 当前任务：只处理这一份精确任务；
6. 边界：scope、forbidden、acceptance 和 stop 已读清；
7. 状态：正式资料、项目规则与项目当前状态没有无法解释的冲突。

任一失败即 `BLOCKED`。检查结论必须进入该 TASK 指定的 REPORT：`BOOTSTRAP_CHECK` 在“结果”逐项列出以上七项；`CAPABILITY_SELF_CHECK` 在“结果”逐项列出运行时、工具、认证状态、目标访问、环境和限制。两类检查均使用 Runner TASK，不修改业务项目。

## 本地执行与恢复

本地任务读取正式资料、`project_rules` 和任务输入；需要写入时使用物理隔离且被授权的项目副本，不同 branch 共享同一工作目录不算隔离。不得覆盖、reset、clean、stash 或删除不属于当前任务的现场；不得通过备份、镜像或临时合同绕开合同边界。

`startup_mode: resume` 只用于同一任务、同一 revision、同一角色和可解释现场；只刷新当前 TASK、当前 TASK-STATE、项目状态、相关输入和上次 REPORT 后的正式变化。出现无法解释的变化时停止，不通过扫描全历史、重写任务或臆测项目位置恢复。

## 人工原样传递

仅当任务明确声明 `transport: human_copy` 时使用：

1. 输入必须是完整、编号的 TASK，含全部合同字段和 `human_copy` 区块；Seed、截图、摘要或改写后的转述一律返回 `BLOCKED`；
2. 先读取任务指定的 `project_location`、`project_rules` 和输入；任务要求读取但当前不可访问的项目资料或正式资料时返回 `BLOCKED`；
3. 只按任务范围执行；任务允许写入且目标可访问时，只写明示的项目输出；任务没有授予时不得借由人工传递扩大写入权限；
4. 按固定格式返回完整 REPORT，`delivery_state` 必须为 `RETURNED_FOR_HUMAN_RECORDING`；不得省略结果、交付、验证、剩余风险或下一步；
5. 报告由任务指定的记录者原样写入正式资料库。执行 Agent 在返回后停止，不声称已记录、已接受、已 merge、已 deploy 或已 release。

## GitHub 中继

1. 在读取任务、实施、验证和回写前刷新远端引用；
2. 记录默认分支、main（如存在）、任务位置、基线、工作分支和本地起点；
3. 在隔离 clone 或 worktree 中同步完整声明项目树、必要 submodule 和 LFS，并读取任务指定的项目规则；
4. 任务位置或远端不可读时返回 `BLOCKED_REMOTE_SYNC`；漂移不可解释时返回 `BLOCKED_REMOTE_DRIFT`；
5. 完成后再次刷新远端；工作分支有未解释推进时停止，不覆盖、不 force push；
6. 仅在 `remote_actions` 明确允许时回写指定工作分支，随后回读远端结果并报告。

同步不授权默认分支写入、merge、deploy、release、删除分支或同步无关本地状态。

## 变更、验证与结束

project、project_location、project_rules、role、startup_mode、authority_source、baseline、`human_authorization`、transport、scope、forbidden、acceptance、inputs、report、stop、`github_relay` 区块或 `human_copy` 区块变化时，请求新 revision 并停止。共享接口、安全、权限、秘密、正式状态或项目规则冲突时同样停止。

证据强于自述；准确说明已验证和未验证的内容。不得输出 password、token、private key、secret 或完整环境变量值。Builder、Research、Repair、Runner 与 Verifier 的提交不等于接受。 `local` 与 `github_relay` 完成后在任务指定位置写正式 REPORT 并停止；`human_copy` 只返回完整 REPORT 并停止。
