# agent-local-memory

> 为 Claude Code 和 OpenClaw 提供跨对话的本地持久记忆
> Persistent local memory skill for Claude Code & OpenClaw

AI Agent 天生不具备跨对话记忆能力。`agent-local-memory` 是一个轻量化 Skill，通过纯文件存储为 Agent 赋予持久记忆——无需外部服务，支持 Claude Code 和 OpenClaw。

---

## 与官方记忆功能的区别 / vs. Built-in Memory

| | 官方 Claude Code 记忆 | agent-local-memory |
|---|---|---|
| 平台支持 | 仅 Claude Code | Claude Code + OpenClaw |
| 记忆分类 | 无结构 | 4 类结构化（user / feedback / project / reference）|
| 索引机制 | 无 | MEMORY.md 常驻索引 |
| Context limit 处理 | 无 | 主动写入保存进度 |
| 可分发/共享 | 不可 | 可安装、可 fork 定制 |

---

## 快速安装 / Quick Install

### 一键脚本（推荐）

```bash
# Claude Code
curl -fsSL https://raw.githubusercontent.com/siyu-hu/agent-local-memory/main/scripts/install.sh | bash -s claude

# OpenClaw
curl -fsSL https://raw.githubusercontent.com/siyu-hu/agent-local-memory/main/scripts/install.sh | bash -s openclaw
```

### 手动安装

```bash
# Claude Code
git clone https://github.com/siyu-hu/agent-local-memory ~/.claude/skills/agent-local-memory

# OpenClaw
git clone https://github.com/siyu-hu/agent-local-memory ~/.openclaw/skills/agent-local-memory
```

### 更新

```bash
git -C ~/.claude/skills/agent-local-memory pull
# 或
git -C ~/.openclaw/skills/agent-local-memory pull
```

---

## 使用方式 / Usage

安装后，直接在对话中说：

```
记住，我不喜欢用 mock 测试
你还记得上次我们讨论的项目架构吗？
把今天的进度保存到记忆里
```

Skill 会自动：

1. **对话开始时** 检查已有记忆，告知相关内容
2. **按类型存储** user / feedback / project / reference
3. **维护 MEMORY.md 索引**，控制 context 占用
4. **接近 context limit 前** 主动保存本次对话进度

---

## 记忆存储路径 / Memory Storage

| 平台 | 路径 |
|------|------|
| Claude Code | `~/.claude/memory/` |
| OpenClaw | `~/.openclaw/memory/` |
| 自定义 | 修改 `SKILL.md` 中的存储路径说明 |

---

## 四类记忆 / Memory Types

| 类型 | 用途 | 典型例子 |
|------|------|---------|
| `user` | 用户画像、偏好、背景 | "用户是 Go 工程师，不喜欢冗余解释" |
| `feedback` | 纠错记录，防止重复 | "集成测试不得 mock 数据库" |
| `project` | 项目上下文、决策、截止日期 | "认证重写由合规驱动，非技术债" |
| `reference` | 外部资源位置 | "bug 跟踪在 Linear 项目 INGEST" |

详细说明见 [references/memory-types.md](references/memory-types.md)。

---

## License

MIT
