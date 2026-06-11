---
tags: [layer/raw, type/reference]
---

# AGENTS.md

This repository is a second brain operating on top of LLM agents.

## Roles

1. **Obsidian vault** — ZK + PARA + LYT hybrid knowledge management
2. **Alcove docs root** — provides project docs to AI agents via `alcove` MCP server
3. **Git repository** — Conventional Commits

**Never copy documents from this repository to public project repos.**

## Structure

```
├── 00-Inbox/               # Capture zone (obsidian-forge classification target)
├── 01-Projects/            # Active projects
├── 02-Areas/               # Ongoing interest areas
├── 03-Resources/           # Reference materials
├── 04-Writing/             # Writing projects
├── 10-Zettelkasten/        # Permanent concept notes (layer/wiki, 300+ chars)
├── 99-Archives/projects/   # All project docs (active + inactive)
├── index.md                # ← Agent entry point (static, no Dataview)
├── Home.md                 # Dashboard (Dataview, not for agents)
├── TAGGING.md              # Tag and frontmatter rules
└── vault.toml              # obsidian-forge config
```

## Karpathy 3-Layer Architecture

| Layer | Location | Content | Automation |
|-------|----------|---------|------------|
| **Raw** | `99-Archives/projects/`, `00-Inbox/`, `02-Areas/` | Project docs, captures, areas | `of process-all`, git sync |
| **Wiki** | `10-Zettelkasten/` | Refined atomic concept notes (300+ chars) | Manual curation + `of strengthen-graph` |
| **Graph** | wikilink connection structure | Backlinks between Raw↔Wiki, bridge notes | `of strengthen-graph` |

### Layer Rules
- Raw is the source of truth for project state
- Wiki: 300+ chars (excluding frontmatter), `layer/wiki` tag required, link to ≥1 Project/Area
- Graph is auto-generated — do not manually edit bridge notes
- Content flow: Raw → Wiki (manual refinement) → Graph (automated)

## Tag Rules

- **Hierarchy:** `topics/<name>`, `status/<name>`, `type/<name>`
- **Layer:** `layer/raw`, `layer/wiki` (mandatory)
- **Limit:** max 7 tags per file, project tag first
- Full rules → `TAGGING.md`

## Frontmatter Rules

All new/modified `.md` files require YAML frontmatter:

```yaml
---
project: {folder-name}
tags: [{folder-name}, layer/raw, type/{doc-type}]
---
```

**Required tags:** `layer/raw` (or `layer/wiki` for `10-Zettelkasten/`), project tag first, max 7.
**Type mapping:** PRD→`prd`, ARCHITECTURE→`architecture`, CONVENTIONS→`convention`, DECISIONS→`decision`, PROGRESS→`progress`, DEBT→`debt`, SECRETS_MAP→`reference`, reports/→`report`, specs/→`spec`, research/→`research`.
**Exceptions:** `_template/`, `*/seeded/`, `.obsidian/`, `.git/`, `.claude/` — no frontmatter needed.

### Auto-fix (execute without asking)
- Missing `layer/raw` or `layer/wiki` → add based on location
- `tags: []` → fill with appropriate tags
- Non-hierarchical tags → normalize via `TAGGING.md` mapping

### Semi-auto (propose and wait for approval)
- Orphan file linking, broken wikilink removal, tag limit cleanup

## Project Document Schema

| File | Purpose |
|------|---------|
| `PRD.md` | Product requirements |
| `ARCHITECTURE.md` | Tech stack, module structure |
| `PROGRESS.md` | Release history, milestones |
| `DECISIONS.md` | Architecture Decision Records (ADR) |
| `CONVENTIONS.md` | Naming, patterns, prohibitions |
| `SECRETS_MAP.md` | Environment variable names and rotation policy (never include values) |
| `DEBT.md` | Technical debt and workarounds |

Supporting folders: `reports/`, `specs/`, `plans/`, `research/`, `archive/`, `strategy/`

## Agent Session Workflow

### Navigation
1. Start at `index.md` (static, no Dataview)
2. Areas → `02-Areas/02-Areas` MOC
3. Projects → `99-Archives/projects/{name}/{name}` MOC
4. Wiki → `10-Zettelkasten/` individual notes
5. Search fallback → alcove `search_project_docs` / `search_vault`

### When Creating/Modifying Files
1. Follow frontmatter rules (see above)
2. Follow `TAGGING.md` tag rules
3. Use `[[]]` for wikilinks, markdown `[]()` for external links
4. Link related docs in See Also section within same project

### On Session End
1. Summarize changes
2. Save newly discovered patterns/feedback to Memory
3. Commit with Conventional Commits

## Included Skills

### Vault Management
- `vault-doctor` — vault-doctor CLI diagnostics/repair
- `vault-fix` / `vault-scan` — Slash commands for vault maintenance

### Development
- `skill-forge` — Skill creation/optimization

### Plugin-provided Skills (install separately)
- `obsidian-forge:*` — Graph strengthening, inbox processing, vault sync
- `epic:*` — Development pipeline (spec/go/check/ship/evolve)
- `epicsagas:*` — Decision-making (five-whys, devil's advocate, biz-risk)

## Document Authoring Rules

- All internal documents exist only in this repository
- Diagrams: Mermaid format only
- Commits: Conventional Commits (`type(scope): description`)

## Language Rules (Token-Efficient Hybrid Strategy)

To reduce LLM token costs, files read by agents are written in English.

### Per-File Language Standard

| Category | Language | Target |
|----------|----------|--------|
| **Agent infrastructure** | English | AGENTS.md, CLAUDE.md, index.md, SKILL.md, commands/*.md, agents/*.md |
| **Project deliverables** | English | PRD, ARCHITECTURE, DECISIONS, CONVENTIONS, PROGRESS, DEBT, SECRETS_MAP, reports/, specs/, research/ |
| **ZK concept notes** | Bilingual | Title allows mixed, body in English |
| **Inbox captures** | User's choice | 00-Inbox/* |

### Rules
- No mixed scripts within a single file — pick one (ZK exception)
- Exception: technical terms, commands, code, proper nouns, library names
- New project deliverables → write in English
