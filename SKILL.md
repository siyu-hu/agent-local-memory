---
name: agent-local-memory
description: |
  为 AI Agent 提供跨对话的本地持久记忆系统，纯文件存储，无需外部服务。
  触发时机：(1) 用户说"记住"某件事 (2) 用户询问"你还记得"某事 (3) 对话接近 context limit 前保存进度 (4) 每次对话开始时自动检查已有记忆。

  Persistent local memory system for AI agents — file-based, zero external dependencies.
  Trigger when: (1) user asks to "remember" something (2) user asks what you remember (3) saving progress before context limit (4) auto-check at conversation start.
metadata:
  version: "1.0"
  tags:
    - color: blue
      label: 记忆管理
    - color: green
      label: 跨对话持久化
    - color: purple
      label: Claude Code / OpenClaw
---

# Agent Local Memory

跨对话本地持久记忆系统 — 让 AI 在不同会话之间记住用户偏好、项目上下文和行为反馈，纯文件存储，无需外部服务。

## 存储路径

| 平台 | 默认记忆路径 |
|------|-------------|
| Claude Code | `~/.claude/memory/` |
| OpenClaw | `~/.openclaw/memory/` |
| 跨平台统一 | `~/.agent-memory/` |

用户可在 CLAUDE.md 或 OPENCLAW.md 中自定义路径。

## MEMORY.md 索引机制

记忆目录下维护一个 `MEMORY.md` 作为常驻索引：

- 每条记忆 = 独立 `.md` 文件，带 YAML frontmatter（name / description / type）
- `MEMORY.md` 只存指向各记忆文件的链接 + 一句话描述，不存记忆正文
- 超过 200 行时，合并精简旧条目

**对话开始时**：检查记忆目录下 `MEMORY.md` 是否存在。若存在，读取索引并告知用户当前有哪些记忆。

**接近 context limit 前**：主动将本次对话的重要内容写入记忆文件，更新 `MEMORY.md`，确保下次对话可无缝继续。

## 记忆文件格式

```markdown
---
name: 记忆名称
description: 一句话描述（供索引判断相关性）
type: user | feedback | project | reference
---

记忆正文
```

## 四类记忆

详见 [references/memory-types.md](references/memory-types.md)。

| 类型 | 用途 |
|------|------|
| `user` | 用户偏好、角色、知识背景 |
| `feedback` | 用户纠正过的 AI 行为，防止重复犯错 |
| `project` | 项目上下文、决策原因、截止日期 |
| `reference` | 外部资源位置（Linear、Slack、Dashboard 等） |

## 写入规则

写入前先扫 `MEMORY.md`，有可更新的记忆则更新，不重复新建。

**不该写入的内容**：

- 代码结构、文件路径、架构约定（读代码可得）
- 当前对话的临时状态
- 已在 CLAUDE.md / 项目文档中记录的内容
- git 历史、提交记录

## 对话开始提示

若 `MEMORY.md` 存在，对话开始时输出：

> 检测到本地记忆（N 条）。相关记忆：[列表]
