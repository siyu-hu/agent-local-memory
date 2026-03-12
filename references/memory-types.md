# Memory Types Reference

## user — User Profile

Stores the user's role, goals, preferences, and knowledge background to personalize future responses.

**When to write**: When you learn about the user's role, tech stack preferences, or communication style.

**Example**:

```markdown
---
name: user_profile
description: Senior Go engineer, new to React frontend
type: user
---

- 10 years of Go experience, strong backend background
- Just getting started with React — frame frontend concepts as backend analogues
- Communication style: concise and direct, dislikes verbose explanations
```

---

## feedback — Behavior Correction

Records behaviors the user has corrected, preventing the same mistake from recurring in future sessions. This is the highest-priority memory type.

**When to write**: When the user says "don't do that", "I've told you before", "stop doing…", or any explicit correction.

**File structure**: Lead with the rule, then a `**Why:**` line (the reason given) and a `**How to apply:**` line (scope of the rule).

**Example**:

```markdown
---
name: feedback_no_db_mock
description: Integration tests must use a real database, never mocks
type: feedback
---

Integration tests must connect to a real database — mocking is not allowed.

**Why:** A prior incident where mocked tests passed but the prod migration failed, causing an outage.

**How to apply:** Whenever writing tests that involve database operations, always connect to the test database directly. Never use mocks.
```

---

## project — Project Context

Records project goals, key decisions, owners, and deadlines — information that cannot be inferred from the codebase.

**When to write**: When you learn the motivation behind a decision, a milestone, or an important constraint.

**Note**: Always convert relative dates ("next Friday") to absolute dates before writing.

**File structure**: Lead with the fact or decision, then a `**Why:**` line (the motivation) and a `**How to apply:**` line (how it should shape your suggestions).

**Example**:

```markdown
---
name: project_auth_rewrite
description: Auth middleware rewrite is compliance-driven, not tech debt
type: project
---

The auth middleware is being rewritten. Target completion: 2026-04-01.

**Why:** Legal flagged the current session token storage as non-compliant with new regulations. This is not a tech debt cleanup.

**How to apply:** Scope decisions should prioritize compliance over engineering elegance.
```

---

## reference — External Resources

Records locations and purposes of external systems, tools, and documentation for quick lookup.

**When to write**: When you learn about a Linear project, Slack channel, Grafana dashboard, or any other external resource.

**Example**:

```markdown
---
name: ref_linear_bugs
description: Pipeline bugs are tracked in Linear project INGEST
type: reference
---

Pipeline-related bugs are tracked in Linear project "INGEST".

When investigating data pipeline issues, check Linear INGEST for known issues first.
```

---

## General Principles

| Principle | Detail |
|-----------|--------|
| No duplicates | Scan `MEMORY.md` before writing — update existing entries, don't create new ones |
| No derivable content | Code structure, file paths, and git history don't belong in memory |
| `feedback` is highest priority | These prevent repeated mistakes — always follow them |
| `project` decays fastest | Review periodically and delete or update stale entries |
| Convert relative dates | "Next week" → "2026-03-19" — memories must stay interpretable over time |
