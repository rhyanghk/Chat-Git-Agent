# 协作空间初始化协议

**分类：L2 场景参考。** 仅在新组织、新设备首次建立协作空间，或新的 Global Architect 需要确认全局容器时读取；普通项目任务不默认读取。

## 目的

定位各职责容器、登记唯一正式资料库，并确认控制角色能否安全接手。不要根据仓库名称猜职责，也不要自动创建任何仓库、平台项目或组织设置。

## 容器

| 容器 | 作用 |
| --- | --- |
| `governance` | 本仓：通用规则、协议、模板和执行 Skill 分发。 |
| `control_project` | Chat 平台项目或独立控制工作区，保存短项目指令、角色参考和正式资料库入口；不是业务代码仓。 |
| `agent_skill` | 纯执行 Skill 的安装或分发位置。 |
| `project` | 一个具体业务项目，可在本地、GitHub 或其他版本系统。 |
| `asset` | 可选的业务资产事实源。 |

## 登记记录

~~~yaml
workspace_registry:
  version: PROJECT-0001
  governance:
    source: <location>
  control_project:
    platform: <platform>
    authority_store: <one formal location>
  agent_skill:
    source: <location | none>
  projects:
    - id: PROJECT-0001
      location: <location>
      transport: <local | github_relay>
  asset:
    source: <location | none>
~~~

`workspace_registry` 只是一次正式登记记录，不是每个业务项目都必须创建的新数据库。它只记录已决定使用的容器及其位置。

## 完成条件

只有需要的容器均已定位、唯一正式资料库可访问、控制角色边界已确认时，状态才可为 `READY`。缺项返回 `WAITING_FOR_HUMAN`；资料、角色或位置冲突返回 `BLOCKED`。

边界：GitHub 只在某个项目选择 `github_relay` 时登记；不得把通用资料复制进业务项目。

