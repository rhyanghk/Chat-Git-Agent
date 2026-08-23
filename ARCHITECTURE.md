# Architecture

本仓是通用治理与分发仓，不是某个业务项目仓。

## 运行边界

~~~text
协作控制项目  ── 编号化任务/结果指针 ──>  Agent 执行环境
      ↑                                          ↓
      └────────── Human 决策与验收 ──────────────┘

Agent 执行环境  ── 仅任务授权范围 ──>  业务项目仓库
~~~

协作控制项目、Agent 执行 Skill 和业务项目仓库是三个容器。它们可以位于不同平台、不同设备或不同服务中，但不能因方便而合并职责。

## 信息流

1. Human 给出目标或批准已有项目决定。
2. Global Architect 或 Project Architect 在协作控制项目中建立编号化任务。
3. Human 或被明确授权的控制角色派发最小任务 seed。
4. Agent 从正式任务记录读取合同并执行。
5. Agent 写入一份正式结果报告；github_relay 时同步项目结果到 GitHub。
6. Verifier 在需要时独立验证。
7. Human 决定接受、拒绝、继续、merge、deploy 或 release。

没有一个步骤允许执行 Agent 把自己的建议、提交或自评变成接受决定。