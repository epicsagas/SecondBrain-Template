---
name: TAGGING
description: Vault-wide tagging and frontmatter convention
type: reference
tags: [layer/raw, type/reference]
---

# Tagging Convention

## Tag Categories

### 1. Layer Tags (required)
Defines the knowledge maturity level in the **Karpathy 3-Layer Architecture**.

| Tag | Layer | Meaning |
|-----|-------|---------|
| `layer/raw` | Raw | Captured notes, project docs, area notes |
| `layer/wiki` | Wiki | Refined, atomic Zettelkasten notes (300+ chars) |

### 2. Project Tags (required for Raw layer)
Match the **folder name exactly** (e.g., `my-project`). This is the primary axis for graph organization.

### 3. Hierarchical Taxonomy

#### 3.1 Status Tags (`status/`)
Track the maturity and health of a note.
- `status/seed` — Early stage concept or capture
- `status/evergreen` — Mature, well-linked concept
- `status/debt` — Missing info or technical debt

#### 3.2 Type Tags (`type/`)
Define the document schema.
- `type/moc` — Map of Content (hub file)
- `type/prd`, `type/architecture`, `type/decision`, `type/convention`, `type/progress`
- `type/report`, `type/spec`, `type/plan`, `type/reference`

#### 3.3 Topic Tags (`topics/`)
Subject matter classification.
- Example: `topics/rust`, `topics/ai`, `topics/ai/rag`, `topics/ai/llm`, `topics/mcp`

## Rules

1. **Max 7 tags per file**
2. **Project tag is always first** (for `layer/raw`)
3. **Layer tag is mandatory**
4. **Hierarchical prefixes** (`topics/`, `status/`, `type/`) are mandatory for all non-project tags.
5. **No empty `tags: []`**

## Frontmatter Schema

### Standard (Project Docs)
```yaml
---
project: <folder-name>
tags: [<project>, layer/raw, type/<doc-type>, topics/<topic>]
---
```

### Zettelkasten (Wiki)
```yaml
---
tags: [layer/wiki, status/evergreen, topics/<topic>]
---
```

## Tag Normalization Map

Map non-standard tags to canonical form. Customize this for your own taxonomy.

| Non-standard | Canonical | Note |
|-------------|-----------|------|
| `architecture` | `type/architecture` | When document type |
| `adr` | `type/decision` | Architecture Decision Record |
| `reference` | `type/reference` | When document type |
| `resource` | `type/reference` | When document type |
| `evaluation` | `type/report` | |
| `analysis` | `type/report` | |

**Auto-normalization rules:**
- Topic tags without `topics/` prefix → add `topics/{tag}`
- Document type tags without `type/` prefix → add `type/{tag}`
- Project names (matching folder name) → no prefix needed

## Relations & Linking

- **Wikilinks `[[]]`** for vault-internal references (preferred)
- **Markdown links `[]()`** for relative links within same project
- **See Also section** at end of file for related docs across projects
- **MOC hub pattern**: `{project}/{project}.md` links to all project docs

## Backlink Health Rules

1. Every project MOC (`{project}/{project}.md`) includes wikilinks to sub-documents
2. `index.md` links to all project MOCs
3. Project sub-documents (reports/, specs/, research/) are linked from MOC
4. Orphan files (0 incoming links) reviewed quarterly
5. Broken wikilinks identified via `vault-doctor scan` or `of check-links`
