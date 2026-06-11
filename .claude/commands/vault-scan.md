---
description: "Run vault-doctor scan and report findings"
---

Run vault-doctor scan on the vault.

```bash
vault-doctor scan . --severity medium
```

Parse the output and report:
1. Summary of all issues by severity
2. Auto-fixable item count
3. Top 5 manual-action items (broken links, orphans)
4. Recommended action priority
