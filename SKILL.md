---
name: agent-local-memory
description: >
  Persistent local memory system for AI agents across conversations — file-based, zero external dependencies.
  Trigger when: (1) user asks to "remember" something, (2) user asks what you remember, (3) saving progress before context limit, (4) conversation starts — auto-check for existing memories.
metadata:
  version: "1.0"
  tags:
    - color: blue
      label: Memory Management
    - color: green
      label: Cross-Session Persistence
    - color: purple
      label: Claude Code / OpenClaw
---

# Agent Local Memory

Persistent local memory across conversations — store user preferences, project context, and behavioral feedback as plain files. No external services, no network calls, no credentials required.

## Storage Paths

| Platform | Default Memory Path |
|----------|---------------------|
| Claude Code | `~/.claude/memory/` |
| OpenClaw | `~/.openclaw/memory/` |
| Cross-platform | `~/.agent-memory/` |

## MEMORY.md Index

Maintain a `MEMORY.md` file in the memory directory as a persistent index:

- Each memory = one `.md` file with YAML frontmatter (`name` / `description` / `type`)
- `MEMORY.md` stores only links to memory files + one-line descriptions, never the full content
- Trim and merge old entries when the index exceeds 200 lines

**At conversation start**: Check whether `MEMORY.md` exists in the memory path. If it does, read the index and inform the user which memories are available.

**Before context limit**: Proactively write important content from the current conversation into memory files and update `MEMORY.md`, so the next session can resume seamlessly.

## Memory File Format

```markdown
---
name: memory-name
description: One-line summary (used to assess relevance from the index)
type: user | feedback | project | reference
---

Memory content here.
```

## Four Memory Types

See [references/memory-types.md](references/memory-types.md) for full details.

| Type | Purpose |
|------|---------|
| `user` | User preferences, role, knowledge background |
| `feedback` | Corrected AI behaviors — prevent repeating mistakes |
| `project` | Project context, decisions, deadlines |
| `reference` | External resource locations (Linear, Slack, dashboards) |

## Write Rules

Before writing, scan `MEMORY.md` — update an existing memory if one applies, do not create duplicates.

**Never write to memory:**

- Passwords, API keys, tokens, or any credentials
- Secrets, private keys, or sensitive authentication data
- Code structure, file paths, or architecture conventions (derivable from the codebase)
- Temporary state from the current conversation
- Anything already documented in project files or docs
- Git history or commit records

## Conversation Start Prompt

If `MEMORY.md` exists, output at conversation start:

> Local memory detected (N entries). Relevant memories: [list]
