# 四类记忆详解 / Memory Types Reference

## user — 用户画像

记录用户的角色、目标、偏好和知识背景，帮助未来对话个性化响应。

**写入时机**：了解到用户角色、技术栈偏好、沟通风格时。

**示例**：

```markdown
---
name: user_profile
description: 用户是资深 Go 工程师，首次接触 React 前端
type: user
---

- 有 10 年 Go 经验，熟悉后端架构
- 刚开始接触 React，解释前端概念时建议类比后端
- 沟通风格：简洁直接，不喜欢冗余解释
```

---

## feedback — 行为纠错

记录用户纠正过的 AI 行为，防止同样的错误在下次对话中重复出现。这是最重要的一类记忆。

**写入时机**：用户说"不要这样"、"我之前说过"、"别再…" 时。

**文件结构**：以规则为首行，加 `**Why:**` 说明原因，`**How to apply:**` 说明适用范围。

**示例**：

```markdown
---
name: feedback_no_db_mock
description: 集成测试必须连接真实数据库，不得 mock
type: feedback
---

集成测试必须连接真实数据库，不允许使用 mock。

**Why:** 上季度曾出现 mock 测试通过但 prod 迁移失败的事故。

**How to apply:** 写任何涉及数据库操作的测试时，不使用 mock，直接连接测试数据库。
```

---

## project — 项目上下文

记录项目目标、关键决策、负责人、截止日期等不易从代码中推断的信息。

**写入时机**：获知项目背景、决策原因、里程碑时。

**注意**：相对日期（"本周五"）必须转换为绝对日期再写入。

**文件结构**：以事实为首行，加 `**Why:**` 说明动机，`**How to apply:**` 说明如何影响建议。

**示例**：

```markdown
---
name: project_auth_rewrite
description: 认证中间件重写，由合规要求驱动，非技术债清理
type: project
---

认证中间件正在重写，目标完成日期：2026-04-01。

**Why:** 法务部门要求 session token 存储方式必须符合新合规标准，不是技术债驱动。

**How to apply:** 重写范围决策优先考虑合规，而非工程优雅性。
```

---

## reference — 外部资源

记录外部系统、工具、文档的位置和用途，方便快速定位。

**写入时机**：获知 Linear 项目、Slack 频道、Grafana Dashboard 等外部资源时。

**示例**：

```markdown
---
name: ref_linear_bugs
description: pipeline bug 跟踪在 Linear 项目 INGEST
type: reference
---

pipeline 相关 bug 跟踪位置：Linear 项目 "INGEST"。

涉及数据管道问题时，先去 Linear INGEST 查看已知 issue。
```

---

## 通用原则

| 原则 | 说明 |
|------|------|
| 不写重复记忆 | 写入前先扫 MEMORY.md，有则更新，无则新建 |
| 不写可推断内容 | 代码结构、文件路径、git 历史无需写入 |
| feedback 优先级最高 | 防止重复犯错，每次都要遵守 |
| project 衰减最快 | 定期检查是否过期，及时删除或更新 |
| 相对时间转绝对时间 | "下周" → "2026-03-19"，确保记忆跨时间仍可解读 |
