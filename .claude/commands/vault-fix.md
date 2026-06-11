---
description: "Run vault-doctor auto-fix, verify, and offer to commit"
---

Run vault-doctor auto-fix on the vault.

Step 1 — Scan first:
```bash
vault-doctor scan . --json
```

Step 2 — Fix:
```bash
vault-doctor fix .
```

Step 3 — Verify:
```bash
vault-doctor scan . --severity high
```

After completion, report:
1. Number of files fixed and what changed
2. Remaining issues (if any)
3. Ask user whether to commit
