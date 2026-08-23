# GitHub Relay Task Addendum

将本模板作为 TASK_RECORD 的 github_relay 部分。

~~~text
github_relay:
  repository: <owner/repository>
  task_location: <exact project task location>
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

除列为 allowed 的动作外，一律 forbidden。Builder、Research、Repair、Verifier 与 Runner 不得 merge、deploy 或 release。