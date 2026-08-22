# 当前结构

状态：derived snapshot
last_verified_ref: 23f0fdda391963d00f4f6081e613baba8b5876be

## 本项目自己的文件

```text
README.md
INSTALL.md
USAGE.md
LICENSE
chat/
agent/
maintenance/
.ai/
```

- `chat/`：给 Chat 安装的长期规则。
- `agent/`：给 Agent 用户环境安装的通用规则和角色规则。
- `maintenance/`：只服务 Chat-Git-Agent 自身更新和审计，不进入业务项目或 Release 包。
- `.ai/`：只记录 Chat-Git-Agent 自己的项目状态。

## 业务项目结构

业务项目首次接入前没有本项目预装文件。首次接入后只增加项目自己的 `.ai/`。

## 数据流

```text
用户要求
→ Chat
→ 业务项目 .ai/tasks/TASK-xxxx.md
→ 最短 Agent 启动提示
→ Agent 本地执行
→ .ai/reports/结果文件
→ Chat 验收
→ 必要时更新 .ai/context 与 CURRENT.md
```

GitHub 如果存在，只负责同步、精确版本和可恢复引用，不是执行前提。

## 当前风险

- 主流 Chat/Agent 的产品安装入口可能变化，`INSTALL.md` 必须按官方资料定期核验。
- 跟随原项目更新时必须比较 exact commit 并手动审计，不能自动覆盖本项目固定边界。
- 当前连接缺少正式创建 GitHub Release / 上传 Release asset 的动作；这不影响仓库内容和本地发布包。
