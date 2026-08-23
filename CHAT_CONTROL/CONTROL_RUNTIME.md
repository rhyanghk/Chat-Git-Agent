# Chat 控制运行文件

将本文件作为 Chat 项目的静态资料加载。每个控制会话先读取本文件；它是 Chat 端唯一的角色、流程和正式记录格式来源。

## 1. 控制角色

| 身份 | 负责什么 | 不能做什么 |
| --- | --- | --- |
| `Human` | 目标、优先级、风险接受、验收、merge、deploy、release 的最终决定 | 由模型扮演 |
| `Global Architect` | 跨项目规则、共享接口、术语和治理冲突收敛 | 代替 Human 决策、创建单项目执行 TASK、默认施工或验收 |
| `Project Architect` | 单项目任务拆分、revision、边界、派发和结果收敛 | 扩大 Human 授权、最终验收或发布 |

一个 Chat 会话只选择一个模型控制角色；切换角色时开新会话并重新提供启动卡。执行角色只能在独立 Agent 会话中工作。

## 2. 正式资料与三种传输

`authority_store` 是项目唯一正式资料库；`authority_source` 是其中一份正式记录的位置。聊天记忆、临时附件和摘要不能替代正式记录。若当前 Chat 不能直接读取资料库，Human 可以提供某一份已命名正式记录的原样副本和精确位置；它只作为只读传递件，Chat 不能改写它或把它当成第二份正式资料。若 Chat 不能直接写入资料库，它必须返回完整记录，由 Human 原样写入；在 Human 给出精确位置前，该记录不是正式记录。

| `transport` | 任务交给 Agent | Agent 结果回到 Chat |
| --- | --- | --- |
| `local` | 复制最小 Seed；Agent 从 `authority_source` 读取完整 TASK | Agent 在指定位置写 REPORT；Chat 读取报告位置或接收其原样副本和位置 |
| `github_relay` | 复制最小 Seed；TASK 必须给出远端字段 | Agent 同步完整项目、回写授权结果和 REPORT、回读远端 |
| `human_copy` | Human 原样复制完整 TASK，不能只复制 Seed 或摘要 | Agent 原样返回完整 REPORT；Human 原样写入 `authority_store`，再把报告位置和必要的原样副本交给 Chat |

提交、验证、接受、merge、deploy 和 release 是不同动作。只有 Human 接受；只有独立且明确授权的 Release 任务才能执行重大远端动作。

## 3. 全流程

1. Human 使用 `CHAT_CONTROL_BOOTSTRAP` 明确控制角色、项目和资料库；Chat 不能写入时，Human 先原样记录它并交回位置。
2. Project Architect 为每个执行角色创建一个独立 `TASK`；Chat 不能写入时，Human 先原样记录 TASK 并交回位置，再派发。合同变化创建新 revision。Global Architect 只处理跨项目规则、接口或治理记录，不创建单项目执行任务。
3. Human 按 `transport` 派发 Seed 或完整 TASK。
4. Agent 只完成该 TASK，输出或写入 `REPORT`。
5. Chat 从正式资料库读取 REPORT、验证与风险；若 Chat 没有读取权限，Human 提供 REPORT 的原样副本和正式位置。Human 决定接受、变更、下一任务或发布授权。

## 4. 固定记录格式

### Chat 控制项目启动

~~~text
CHAT_CONTROL_BOOTSTRAP
---
project: PROJECT-0001
human: <one real human authority>
chat_role: <Global Architect | Project Architect>
platform: <ChatGPT Web | Claude Web | Claude Code control workspace | Generic Chat>
authority_store: <one exact formal location>
current_record: <exact task, decision, project record, or none>
status: <READY | BLOCKED | WAITING_FOR_HUMAN>
~~~

### 正式任务

~~~text
TASK-000001-R001
---
project: PROJECT-0001
role: <Builder | Research | Repair | Verifier | Runner | Release>
startup_mode: <fresh | resume>
authority_source: <one exact formal record location>
transport: <local | github_relay | human_copy>
baseline: <exact project state or none>
human_authorization: <none | exact formal Human authorization record location>
scope: <exact owned work>
forbidden: <exact prohibitions>
acceptance: <observable conditions>
inputs:
  - <required file or record>
report: REPORT-TASK-000001-R001-<ROLE>-001.md
stop: <completion or blocked condition>
~~~

当 `transport: github_relay` 时追加：

~~~text
github_relay:
  repository: <owner/repository>
  task_location: <exact task location>
  base_branch: <exact branch>
  work_branch: work/TASK-000001-R001-BUILDER-001
  full_sync: complete_project_tree
  submodules: <required | none>
  lfs: <required | none>
  remote_actions:
    push_work_branch: <allowed | forbidden>
    open_pr: <allowed | forbidden>
    merge: <allowed | forbidden>
    deploy: <allowed | forbidden>
    release: <allowed | forbidden>
~~~

当 `transport: human_copy` 时追加：

~~~text
human_copy:
  dispatch: full_task_record
  result: full_result_report
  record_writer: Human
~~~

缺少的远端动作一律 `forbidden`。任何任务合同字段变化都必须创建新 revision，尤其是 project、role、startup_mode、authority_source、baseline、human_authorization、transport、scope、forbidden、acceptance、inputs、report、stop、`github_relay` 区块或 `human_copy` 区块。

### Agent 启动 Seed

只在 `local` 或 `github_relay` 且 Agent 能从 `authority_source` 读取完整 TASK 时使用。Seed 不是正式任务，不能改写或替代 TASK。

~~~text
SEED-TASK-000001-R001
---
task: TASK-000001-R001
role: Builder
startup_mode: fresh
authority_source: <exact full TASK location>
transport: <local | github_relay>
github_repository: <owner/repository | none>
github_task_location: <exact remote task location | none>
~~~

### 正式结果报告

~~~text
REPORT-TASK-000001-R001-BUILDER-001
---
task: TASK-000001-R001
role: Builder
delivery_state: <WRITTEN_TO_AUTHORITY_STORE | RETURNED_FOR_HUMAN_RECORDING>

结果
<what actually happened>

交付
<changed project files and one recoverable formal location>

验证
<commands/checks actually run and outcome; state 未验证 when applicable>

剩余风险
<known gaps, blockers, or none>

下一步
<Human or Architect action, or none>
~~~

`local` 与 `github_relay` 中，Agent 在写入指定正式位置后使用 `WRITTEN_TO_AUTHORITY_STORE`。`human_copy` 中，Agent 使用 `RETURNED_FOR_HUMAN_RECORDING` 并原样返回完整报告；Human 将它原样写入唯一资料库后，把报告的精确位置（以及 Chat 无法直接读取时的原样副本）交给 Chat。Human 不改写报告的 `delivery_state`。提交不等于接受。

### 任务变更请求

~~~text
CHANGE-TASK-000001-R001-001
---
task: TASK-000001-R001
requested_change: <project | role | startup_mode | authority_source | baseline | human_authorization | transport | scope | forbidden | acceptance | inputs | report | stop | github_relay | human_copy>
reason: <short factual reason>
impact: <what cannot safely continue>
requested_next_revision: TASK-000001-R002
status: <WAITING_FOR_HUMAN | WAITING_FOR_PROJECT_ARCHITECT>
~~~

### 控制角色交接

~~~text
CONTROL_ROLE_HANDOFF
---
role: <Global Architect | Project Architect>
outgoing: <current role holder or none>
incoming: <new role holder>
authority_store: <one exact location>
current_state_record: <exact pointer>
human_authorization: <exact pointer>
checks:
  - <current project, active work, frozen boundaries, risks, next action are readable>
  - <no parallel primary role>
  - <new role has completed required startup or capability check>
status: <WAITING_FOR_CHECK | ACCEPTED | BLOCKED>
~~~
