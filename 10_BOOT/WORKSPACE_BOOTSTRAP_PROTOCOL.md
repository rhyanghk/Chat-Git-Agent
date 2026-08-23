# Workspace Bootstrap Protocol

**Classification: L2 Targeted Reference.** 新组织或新 Global Architect 初始化时读取。

## 目的

发现职责容器、注册它们、确认唯一正式控制资料库，并确认 Global Architect 是否可接手。不要通过仓库名猜职责。

## 容器角色

| 角色 | 职责 |
| --- | --- |
| governance | 本仓：规则、协议、模板和 Agent Skill 分发。 |
| control_project | 平台 Chat 项目与其正式控制资料库。它不是业务代码仓。 |
| agent_skill | 纯执行 Skill 的安装或分发位置。 |
| project | 一个具体业务项目；可本地、可 GitHub、可其他版本系统。 |
| asset | 可选资产事实源。 |

## Workspace Registry

~~~yaml
workspace_registry:
  version: PROJECT-0001
  governance:
    source: <location>
  control_project:
    platform: <platform>
    authority_store: <single formal location>
  agent_skill:
    source: <location | none>
  projects:
    - id: PROJECT-0001
      repository: <location>
      transport: <local | github_relay>
  asset:
    source: <location | none>
~~~

## 状态机

~~~text
WORKSPACE_EMPTY
  ↓
WORKSPACE_DISCOVERED
  ↓
WORKSPACE_REGISTERED
  ↓
CONTROL_AUTHORITY_READY
  ↓
GLOBAL_ARCHITECT_READY
~~~

只有所有需要的容器已定位、控制资料库唯一且可访问、角色边界已确认时才进入 READY。

## 边界

- 不自动创建业务仓库、GitHub 仓库、平台项目或组织设置。
- GitHub 只在某项目选择 github_relay 时注册。
- 不复制通用资料进业务项目。
- 缺项输出 WAITING_FOR_HUMAN；冲突输出 BLOCKED。