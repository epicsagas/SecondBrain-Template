---
project: root
tags: [dashboard, layer/raw, type/moc]
---

# {{VAULT_NAME}}

## Raw Layer — Projects & Capture

### Active Projects

```dataview
TABLE description as "Description"
FROM "01-Projects" OR "99-Archives/projects"
WHERE contains(tags, "type/moc")
SORT file.name ASC
```

### Ongoing Interests

<!-- Add your area links here -->
<!-- | Area | Link | |------|------| | Topic | [[02-Areas/Topic-Name]] | -->

### Inbox
```dataview
LIST FROM "00-Inbox"
SORT file.mtime DESC
```

## Wiki Layer — Compiled Knowledge

### Zettelkasten
```dataview
LIST FROM "10-Zettelkasten"
WHERE contains(tags, "layer/wiki")
SORT file.name ASC
```

## Graph Layer — Connections

### Writing
- [[04-Writing/04-Writing|Writing MOC]]

### Archived Projects
```dataview
LIST FROM "99-Archives/projects"
WHERE contains(tags, "type/moc")
SORT file.name ASC
```

### Vault Governance
- [[index]] — Agent entry point (static, no Dataview)
- [[TAGGING]] — Tag and frontmatter conventions
- `vault.toml` — Vault configuration

---

## All Maps of Content
```dataview
LIST
FROM ""
WHERE contains(tags, "type/moc")
SORT file.name ASC
```
