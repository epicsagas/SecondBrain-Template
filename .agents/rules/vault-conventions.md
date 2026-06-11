---
description: Obsidian vault conventions — frontmatter, tagging, wikilinks, and layer rules
alwaysApply: true
---

# Vault Conventions

## Frontmatter

All `.md` files require YAML frontmatter:

```yaml
---
project: {folder-name}
tags: [{folder-name}, layer/raw, type/{doc-type}]
---
```

- **Required tags**: `layer/raw` (or `layer/wiki` for `10-Zettelkasten/`), project tag first, max 7
- **Exceptions**: `_template/`, `.obsidian/`, `.git/`, `.claude/`

## Tag Hierarchy

- `topics/<name>`, `status/<name>`, `type/<name>`
- `layer/raw`, `layer/wiki` (mandatory)
- Max 7 tags per file

## Links

- Wikilinks `[[]]` for internal references
- Markdown `[]()` for external URLs
- Mermaid for diagrams only

## Language

- Agent infrastructure: English
- Personal memos: User's choice
- No mixing within a single file
