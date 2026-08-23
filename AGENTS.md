# AGENTS.md — L0

这是机器侧 L0 执行规则。只读本文件、当前精确任务、当前角色规则和任务明确列出的项目文件；不要递归读取全仓。

版本：PROJECT-0001

## Authority

- Human 拥有目标、优先级、风险接受、验收和重大远端动作的最终权威。
- 区分 Human 明确要求、项目约束和你的建议；建议不得升级为要求。
- 能力不等于权限。工具、网络、仓库可写或历史上下文均不产生授权。
- 当前任务、角色、scope、forbidden、acceptance、authority source、报告位置任一不明确时停止并报告 BLOCKED。

## Role and scope

- 只执行精确编号任务和分配角色。
- 不改变角色、任务 revision、基线、范围、禁止项、验收、传输方式、authority source 或报告位置。
- 发现额外问题只形成下一步，不顺手扩大工作。
- 不自行 merge、deploy、release、force push、删除分支、重写历史或破坏性清理。

## Durable records

- 聊天、会话和临时草稿不是任务合同。
- 使用任务声明的唯一 durable authority source；冲突时按 CONSTITUTION.md 的优先级处理。
- 正式产物使用精确编号。不得创建内容哈希、哈希命名、备份副本、镜像或未经授权的临时记录。
- 所有具有事实价值的修改、验证、状态和风险必须写入任务声明的正式位置。

## Workspace

- 写任务使用物理隔离工作区；不要在未知或他人现场覆盖、reset、clean、stash 或丢弃内容。
- 本地工作区只承担当前任务执行，不能替代正式记录。

## GitHub relay

仅当任务声明 transport: github_relay 时：

1. 在读任务和实现前刷新远端；
2. 同步完整声明项目树、必要子模块和 LFS；
3. 记录任务指定的默认分支、main（如有）、任务基线、工作分支和本地状态；
4. 在隔离工作区执行；
5. 结束前再次刷新远端；
6. 仅在明确 remote actions 允许时回写指定工作分支；
7. 回读远端结果后才能报告提交。

远端不可刷新则 BLOCKED_REMOTE_SYNC；无法解释的漂移则 BLOCKED_REMOTE_DRIFT。

## Evidence and verification

- evidence > self-report。结论不得超过证据强度。
- 未验证必须明确说明。Verifier 独立验证，不自行修复或验收。
- 普通复杂或高风险默认最多一名 independent Verifier；Incident Mode 才扩大验证。

## Output

- 人类可见输出默认简体中文；代码、路径、命令和固定机器标识保留原样。
- 不打印 secret、密码、token、private key 或完整环境变量值。
- 正式完成报告依次包含：任务编号和 revision、结果、交付、验证、剩余风险、下一步。

## Reading

需要额外资料时先读 READING_MAP.md；只读取当前场景对应的 L2 文件。