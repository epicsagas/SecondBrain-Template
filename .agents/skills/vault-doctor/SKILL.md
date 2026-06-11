---
name: vault-doctor
description: "vault-doctor CLI wrapper for Obsidian vault diagnostics and auto-fix. Triggers on vault health, scan vault, fix vault, check vault, frontmatter issues, tag conflicts, vault-fix, vault-scan."
---

# vault-doctor

Run vault-doctor CLI to diagnose and fix Obsidian vault health issues.

## Trigger

- User asks about vault health, vault diagnostics, frontmatter issues, tag conflicts
- User mentions broken wikilinks, orphans, stale markers
- User says "scan vault", "fix vault", "check vault health"
- User invokes `/vault-scan` or `/vault-fix`

## Prerequisites

Install vault-doctor CLI:
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

Options:
- `--dry-run` — preview without writing (only if user explicitly requests)

### What gets auto-fixed
- Malformed YAML (closing `---` merged into values)
- Missing frontmatter (injects tags + created)
- Tag conflicts (removes lower-priority tag)
- Missing layer tags (`layer/raw` or `layer/wiki`)
- Missing `created` date on wiki notes

### Manual-only issues
- Broken wikilinks — requires content knowledge
- Orphan files — requires editorial decision
- Stale markers — requires content review

## Workflows

### /vault-scan (read-only diagnostics)

1. Run `vault-doctor scan . --severity medium`
2. Parse and report:
   - Summary of all issues by severity
   - Auto-fixable item count
   - Top 5 manual-action items
   - Recommended action priority

### /vault-fix (scan + fix + verify)

1. **Scan**: `vault-doctor scan . --json`
2. **Fix**: `vault-doctor fix .`
3. **Verify**: `vault-doctor scan . --severity high`
4. **Report**: files fixed, changes made, remaining issues
5. Ask user whether to commit

## Command Selection Guidelines

1. **Fixable issues**: Use `fix` directly without flags
2. **Non-fixable issues**: Use `scan` for diagnostics
3. **Trust the fixable attribute**: If `Fixable: True`, use `fix` directly
