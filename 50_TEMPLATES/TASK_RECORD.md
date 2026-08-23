# 正式任务记录

Project Architect 或已授权 Human 在新建任务、改变合同或恢复需要新 revision 时使用。执行 Agent 只能读取当前 revision，不能原地改写它。

~~~text
TASK-000001-R001
---
project: PROJECT-0001
role: <Builder | Research | Repair | Verifier | Runner | Release>
startup_mode: <fresh | resume>
authority_source: <one exact formal record location>
transport: <local | github_relay>
scope: <exact owned work>
forbidden: <exact prohibitions>
acceptance: <observable conditions>
inputs:
  - <required file or record>
report: REPORT-TASK-000001-R001-<ROLE>-001.md
stop: <completion or blocked condition>
~~~

当 `transport: github_relay` 时，在同一任务记录中追加：

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

缺少的远端动作一律 `forbidden`。scope、role、baseline、transport、forbidden、acceptance、inputs、report 或 stop 变化时，必须创建新 revision。

