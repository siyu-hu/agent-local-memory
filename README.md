# agent-local-memory

**Give your AI a memory that survives across conversations.**

File-based · Zero external services · Claude Code + OpenClaw

[中文介绍 ↓](#中文介绍)

---

Claude forgets everything when a conversation ends. `agent-local-memory` is a lightweight skill that fixes this — storing structured memories as plain local files, automatically indexed and retrieved across sessions. No database, no cloud sync, no API keys.

## Why not the built-in memory?

| | Built-in Claude Memory | agent-local-memory |
|---|---|---|
| Platform | Claude Code only | Claude Code + OpenClaw |
| Structure | Unstructured | 4 typed categories |
| Index | None | Always-loaded `MEMORY.md` |
| Before context limit | No handling | Proactively saves progress |
| Portable | No | Install anywhere, fork & customize |

## Install

**One-liner (recommended)**

```bash
# Claude Code
curl -fsSL https://raw.githubusercontent.com/siyu-hu/agent-local-memory/main/install.sh | bash -s claude

# OpenClaw
curl -fsSL https://raw.githubusercontent.com/siyu-hu/agent-local-memory/main/install.sh | bash -s openclaw
```

**Manual**

```bash
# Claude Code
git clone https://github.com/siyu-hu/agent-local-memory ~/.claude/skills/agent-local-memory

# OpenClaw
git clone https://github.com/siyu-hu/agent-local-memory ~/.openclaw/skills/agent-local-memory
```

**Update**

```bash
git -C ~/.claude/skills/agent-local-memory pull
```

## How it works

Once installed, just talk to your AI naturally:

```
Remember, I never want mock databases in tests.
What do you remember about our project?
Save today's progress to memory before we wrap up.
```

The skill handles the rest:

1. **Session start** — checks for existing memories and surfaces relevant ones
2. **Typed storage** — files are organized into four categories
3. **MEMORY.md index** — a lean index keeps context overhead minimal
4. **Before context limit** — proactively writes session progress so nothing is lost

## Memory types

| Type | Stores | Example |
|------|--------|---------|
| `user` | Preferences, role, background | "Senior Go engineer, new to React" |
| `feedback` | Corrected behaviors, rules | "Never mock the database in tests" |
| `project` | Decisions, deadlines, context | "Auth rewrite is compliance-driven" |
| `reference` | External resource locations | "Bugs tracked in Linear / INGEST" |

## Storage paths

| Platform | Memory path |
|----------|-------------|
| Claude Code | `~/.claude/memory/` |
| OpenClaw | `~/.openclaw/memory/` |
| Custom | Edit the path in `SKILL.md` |

## License

MIT

---

## 中文介绍

**让你的 AI 在对话结束后仍然记得你。**

Claude 每次对话结束后都会失忆。`agent-local-memory` 是一个轻量化 Skill，通过纯本地文件存储为 AI Agent 赋予持久记忆——无需数据库、无需云同步、无需 API Key，支持 Claude Code 和 OpenClaw。

### 与官方记忆功能的区别

| | 官方 Claude Code 记忆 | agent-local-memory |
|---|---|---|
| 平台支持 | 仅 Claude Code | Claude Code + OpenClaw |
| 记忆结构 | 无结构 | 4 类结构化记忆 |
| 索引 | 无 | MEMORY.md 常驻索引 |
| Context limit 处理 | 无 | 主动写入保存进度 |
| 可移植 | 不可 | 可安装、可 fork 定制 |

### 快速安装

```bash
# Claude Code
curl -fsSL https://raw.githubusercontent.com/siyu-hu/agent-local-memory/main/install.sh | bash -s claude

# OpenClaw
curl -fsSL https://raw.githubusercontent.com/siyu-hu/agent-local-memory/main/install.sh | bash -s openclaw
```

### 四类记忆

| 类型 | 用途 | 典型例子 |
|------|------|---------|
| `user` | 用户画像、偏好、背景 | "Go 工程师，不喜欢冗余注释" |
| `feedback` | 纠错记录，防止重复 | "集成测试不得 mock 数据库" |
| `project` | 项目上下文、决策、截止日期 | "认证重写由合规驱动，非技术债" |
| `reference` | 外部资源位置 | "Bug 跟踪在 Linear 项目 INGEST" |
