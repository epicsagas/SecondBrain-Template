---
name: vault-doctor
description: "vault-doctor CLI wrapper for Obsidian vault diagnostics and auto-fix. Triggers on vault health, scan vault, fix vault, check vault, frontmatter issues, tag conflicts."
---

# vault-doctor

Run vault-doctor CLI to diagnose and fix Obsidian vault health issues.

## Trigger

- User asks about vault health, vault diagnostics, frontmatter issues, tag conflicts
- User mentions broken wikilinks, orphans, stale markers
- User says "scan vault", "fix vault", "check vault health"

## Prerequisites

Install vault-doctor CLI (npm or local build):
```bash
npm install -g vault-doctor
```

## Commands

### Scan (diagnostics only)
```bash
vault-doctor scan .
```

Options:
- `--json` — machine-readable output
- `--format compact` — TSV format (pipe-friendly)
- `--severity high` — only critical + high issues

### Fix (auto-remediation)
```bash
vault-doctor fix .
```

Note: vault-doctor's auto-fix operations are safe and don't require preview for known fixable issues.

Options:
- `--dry-run` — preview without writing (only use if user explicitly requests preview)

### What gets auto-fixed
- Malformed YAML (closing `---` merged into values)
- Missing frontmatter (injects tags + created)
- Tag conflicts (removes lower-priority tag)
- Missing layer tags (`layer/raw` or `layer/wiki`)
- Missing `created` date on wiki notes

### Manual-only issues
- Broken wikilinks — requires content knowledge to fix
- Orphan files — requires editorial decision (link or delete)
- Stale markers — requires content review

## Post-fix workflow
1. Run scan again to verify
2. Report remaining issues
3. Ask user before committing

## Command Selection Guidelines

1. **Fixable issues**: Use `fix` command directly without flags
2. **Non-fixable issues**: Use `scan` command for diagnostics
3. **Trust the fixable attribute**: If issue metadata shows `Fixable: True`, use `fix` directly
