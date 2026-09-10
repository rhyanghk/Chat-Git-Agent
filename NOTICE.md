# Notice

## TASK-000010-R001：持续适配与审计

更新依据为 ai-use@51fd98a8866878fd3a290be0d615166f876b026d 的 Agent Interface 2.3.0 与 DISPATCH_PAIR：五字段卡、四类运行位置、上下文提示与精确寻址 Seed。保留本仓独立 Chat/Agent、六执行角色、完整编号 TASK、三种传输和非 GitHub 资料库；本仓模板集中于 CONTROL_RUNTIME，不另建模板源。Global Architect 经明确 Human 授权可有限派治理 Runner 检查；无项目纯检查在两端一致处理，均不扩展业务权限。后续审计结论见本节追加记录。


### TASK-000010-R001 审计范围、映射与边界

审计基线：ai-use 的 51fd98a8866878fd3a290be0d615166f876b026d；目标为本仓全部适用的规则与协议功能。上游导航或历史示例与当前规范矛盾时，按其 canonical home 及版本优先级取当前语义，例如 START_HERE 的旧 Seed 不覆盖 Agent Interface 2.3.0。

| 上游功能及规范来源 | 本仓等效落点 | 本轮结论 |
| --- | --- | --- |
| Human 主权、权限分离、事实优先；AGENTS / CONSTITUTION | CONTROL_RUNTIME 1.2；EXECUTION_PROTOCOL 权威顺序；六角色权限 | 两端顺序已统一，能力不产生授权 |
| 分层按需读取、缺失与过期规则隔离；NAMESPACE / READING_MAP / PROGRESSIVE_CONTEXT_BOOT | Skill 入口、角色精确路由及执行协议；Chat 短入口路由运行合同 | 必需全文不可读阻塞，可选资料不撤销已建立权限边界 |
| Ordered Bootstrap 与启动证据；BOOTSTRAP_CHECK_PROTOCOL | CONTROL_RUNTIME 1.6 与 bootstrap；Runner 七项检查 | 首次、接任均需当前证据正式可恢复；登记 claim 不等于就绪 |
| workspace 角色登记；WORKSPACE_BOOTSTRAP_PROTOCOL / HUMAN_WORKSPACE_BOOTSTRAP | governance_source、authority_store、CHAT_CONTROL_REGISTRY | 无项目/资产合法，治理及控制资料来源仍须登记 |
| 持续推进；AGENT_INTERFACE 1.4 | CONTROL_RUNTIME 1.7 与全流程 | 已授权就绪继续；无工作、仅启动、优先级冲突、真实门槛分别停止 |
| DIRECT/DELEGATE、Maintenance Lane；AGENT_INTERFACE 1.0–1.5 | 控制层 1.4、独立 Builder/Repair/Runner/Release TASK | 按既有 Chat/执行分离架构适配，不让 Chat 施工 |
| 派发卡、运行位置、Seed、完成卡；AGENT_INTERFACE 2.3.0 / DISPATCH_PAIR | CONTROL_RUNTIME 第 4 节；EXECUTION_PROTOCOL；五段 REPORT | 新五字段卡与四类运行位置、最小寻址、旧记录兼容 |
| 架构现状、复用与自研判断；ARCHITECT_RECONNAISSANCE | CONTROL_RUNTIME 1.5 | 外部现状先于方案判断，授权与架构就绪分开 |
| 生命周期、恢复、收敛、依赖与资源；SESSION_LIFECYCLE | 控制层当前活跃图、TASK/STATE/DECISION、执行协议 resume | 只恢复当前范围；依赖与事实须实时核对 |
| 能力、交接 REQUEST/ACCEPTED 与后置检查；50_TEMPLATES 相关文件 | CONTROL_RUNTIME 1.6 与交接模板；Runner 检查 | 普通/失联、Project/Global 路径均有明确授权及证据门槛 |
| 检查点、恢复与指针；DURABLE_TRACE_PRINCIPLE / pointer_response | checkpoint_reports、完整 REPORT、CHANGE、正式位置回执 | 阶段与最终报告分开，LOCAL_ONLY 不冒充持久恢复 |
| 验证深度、Incident、目标保护；CONSTITUTION 5–8 | CONTROL_RUNTIME 1.3；Verifier/Release；执行协议中继 | 默认最多一位独立 Verifier；合并须绑定审查目标并原子保护 |
| 语言、访问与工具截断；LANGUAGE_POLICY / Bootstrap / MCP 使用指南的通用部分 | 控制层 2.4；执行协议访问、完整性与失败报告 | 不猜认证/权限，截断不当全文，禁止静默切换 transport |
| 可复现项目要求；SESSION_LIFECYCLE 10 | README 最低可复现契约、TASK inputs/project_rules | 依赖、运行/测试入口与环境语义留在项目 |
| 来源边界、完整输出、版本溯源；DEPOSITOR_PROMPT 0.1.3 / PROMPT_VERSIONING | 控制层 2.1–2.2；执行协议输入与证据边界 | 无来源与无发现分离，AI 建议不升格为 Human 决定 |

保留此前已记录的架构差异：本仓不引入 Human SSOT 的个人状态存储、Depositor/Assets 新角色或 provider 记忆系统；来源整理能力映射到现有 Chat/REPORT，而不是建立个人状态仓。上游允许的 Architect 直接施工/合并由本仓独立执行 TASK 与 Human/Release 边界承接；GitHub 独占事实源改为唯一 authority_store 与三种明确传输；上游目录、Issue 编号和指针显示格式不机械复制。DeepSeek++ 扩展源码修补、其开发机路径及认证配置不是本仓实现，不复制过时工具断言；通用完整读取和认证边界已覆盖。历史提示词、案例与导航索引用于解释及回归，不构成第二份当前合同。

独立情景推演覆盖新项目无任务、无项目 Global 交接、纯检查 none、公共 Seed/local、human_copy 阶段恢复、无来源/无发现；后续复核覆盖治理登记、业务访问误用 none 与 Release head 保护。发现的模板 none 遗漏、注册表豁免残留和安装传输歧义均已修复。该证据是独立模型的文档情景输出，不是生产会话/远端动作的实测成功。

验证边界：结构校验、六角色精确定位、源包逐文件一致性、安装器新装/拒绝覆盖/不支持平台停止及 Shell 语法检查在本环境执行。未实测 Windows PowerShell、各厂商平台自动加载、真实跨设备交接或生产 merge/deploy。合同语义审计与这些平台运行保证分开；不将静态检查或模型推演包装成全平台端到端通过。

## TASK-000008-R001：启动门槛与继续分类修复

按角色和动作区分 primary 条件，明确普通交接接受不以接收方预持 claim 为前提、Global Architect 使用正式治理授权。首次及接任启动在既有 bootstrap 内保存七项检查与正式来源，READY 前仅允许有授权的初始化／交接／检查动作；新增启动后继续、无就绪工作、仅启动、优先级待裁决和真实阻塞分类。Runner 只报告实际目标环境证据，不取得控制权限。依据仍为 ai-use@11a82a1 的 Bootstrap Check Protocol；不新增权威记录类型或资料库，旧记录不追溯改标。本轮验证不代表全功能或模型行为审计通过。

## TASK-000006-R001：第三轮审计缺口修复

将 checkpoint_reports 纳入 CHANGE 字段枚举与两端合同变更清单；在 Chat 入口与通用派发门槛中路由既有失联恢复有限授权例外；明确 human_copy 阶段报告等待落库、复核后继续与最终报告停止等待验收的不同边界。保留原权限、检查点、传输及 primary 约束，不新增上游架构差异。验证限于静态合同、分发包一致性和安装器行为，不代表模型行为或全功能语义等效审计通过。

## TASK-000005-R001：第二轮审计缺口修复

补齐阶段 REPORT 检查点、GitHub 私有源认证寻址、失联交接有限 recovery 授权、NOT_WRITTEN 失败状态与语言覆盖。源语义依据仍为 ai-use@11a82a1 的 BOOTSTRAP_CHECK_PROTOCOL、DURABLE_TRACE_PRINCIPLE、LANGUAGE_POLICY；以本仓既有 TASK / REPORT / DECISION / HANDOFF 适配，不引入上游新存储或自动传输切换。旧任务需新 revision 才加入检查点分配；旧报告与授权不追溯修改。此记录不是全功能审计通过声明。

## TASK-000004-R001：四项审计缺口修复

范围：统一 TASK 的 task / project_id；补齐六类执行环境依赖；增加有条件的架构现状核对；将现有 CONTROL_ROLE_HANDOFF 扩展为保留 REQUEST / ACCEPTED 的版本化证据链。依据为同一上游 11a82a1 的 docs/AGENT_INTERFACE.md、docs/ARCHITECT_RECONNAISSANCE.md、50_TEMPLATES/architect_handoff_transaction.md 与 architect_handoff_check.md。

适配仍使用现有 Chat 控制合同和六执行角色：核对结果作为架构决定的输入，不新增权威记录类型；检查由已授权 Runner TASK 提供环境证据，接收方负责控制角色交接核对。四项修复不代表全功能审计通过，未覆盖项继续保留为待审计，不自动豁免。

本仓以 `youling/ai-use` 为方法论来源，在 Apache License 2.0 下进行结构性适配。

适配内容包括：

- 将 GitHub 从全局强制事实源调整为按任务声明的 `github_relay`；
- 分离 Chat 协作控制项目、纯执行 Agent Skill 与业务项目仓；
- 保留角色治理，并为六个执行角色提供明确权限文件；
- 使用精确编号与 revision，拒绝内容哈希与防御性写入；
- 将 ChatGPT Web、Claude Web、Claude Code 控制会话与通用 Chat 的配置方法集中写入 `INSTALL.md`。

原项目版权与许可证文本保留于 `LICENSE`。

## TASK-000003-R001：来源边界与输出适配

本次相关更新锁定于 [youling/ai-use 的 11a82a1](https://github.com/youling/ai-use/commit/11a82a164eca3dcc8f7d25cbbbdb10b2719b091e)，范围为 Human SSOT Depositor Prompt 0.1.1–0.1.3、`human/PROMPT_VERSIONING.md` 及 PR #41 / #42 的失败案例。0.1.3 是提示词版本，不是整个 ai-use 仓库版本。本次不是全量上游同步。

| 上游能力 | 本仓等效落点 |
| --- | --- |
| 排除投递控制指令、限定真实来源 | CONTROL_RUNTIME 第 2.1 节；EXECUTION_PROTOCOL 输入与证据边界 |
| 无来源与无需保存分离 | Chat 非权威整理结果；Agent 缺输入仍 BLOCKED 并完整报告 |
| 无 Git / 显式输出完整结果 | Chat 显式整理；Agent 已声明的 human_copy，禁止自动改合同 |
| 生成协议版本与来源链 | 本仓 summary/report 规则独立 1.0.0；旧结果不追溯改标 |
| 失败样本回归 | CONTROL_RUNTIME 第 2.2 节场景；不把预期写成已运行结果 |

不引入上游 Human SSOT 存储、Depositor 角色或新的权威记录类型，不复制上游真实用户测试内容。保留本仓的六执行角色、完整 TASK 门槛、三种传输、Human 最终授权及项目 ID 与仓库位置隔离。版本治理文档中的旧 prompt-only 示例以 0.1.3 的 `SOURCE_CONTEXT_UNAVAILABLE` 为准。
