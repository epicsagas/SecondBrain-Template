#!/usr/bin/env bash
# setup.sh — Initialize a new Second Brain vault from this template
# Usage: ./setup.sh "MyVaultName"

set -euo pipefail

VAULT_NAME="${1:?Usage: ./setup.sh <vault-name>}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Initializing vault: $VAULT_NAME"

# 1. Set vault name in vault.toml
sed -i.bak "s/{{VAULT_NAME}}/$VAULT_NAME/g" "$SCRIPT_DIR/vault.toml"
rm -f "$SCRIPT_DIR/vault.toml.bak"

# 2. Set vault name in index.md
sed -i.bak "s/{{VAULT_NAME}}/$VAULT_NAME/g" "$SCRIPT_DIR/index.md"
rm -f "$SCRIPT_DIR/index.md.bak"

# 3. Set vault name in Home.md
sed -i.bak "s/{{VAULT_NAME}}/$VAULT_NAME/g" "$SCRIPT_DIR/Home.md"
rm -f "$SCRIPT_DIR/Home.md.bak"

# 4. Create symlinks for cross-tool compatibility
#    .agents/ is the source of truth; symlinks make it visible to each tool.

echo "==> Creating cross-tool symlinks..."

# Ensure .claude/ directory exists (may not if settings.json is missing)
mkdir -p "$SCRIPT_DIR/.claude"

# Claude Code: .claude/skills/ and .claude/agents/ → .agents/
# Remove existing directories if present (from template), then symlink
if [ -d "$SCRIPT_DIR/.claude/skills" ] && [ ! -L "$SCRIPT_DIR/.claude/skills" ]; then
  rm -rf "$SCRIPT_DIR/.claude/skills"
fi
ln -sfn ../.agents/skills "$SCRIPT_DIR/.claude/skills"

if [ -d "$SCRIPT_DIR/.claude/agents" ] && [ ! -L "$SCRIPT_DIR/.claude/agents" ]; then
  rm -rf "$SCRIPT_DIR/.claude/agents"
fi
ln -sfn ../.agents/agents "$SCRIPT_DIR/.claude/agents"

# Claude Code: .claude/rules/ → .agents/rules/
if [ ! -L "$SCRIPT_DIR/.claude/rules" ]; then
  ln -sfn ../.agents/rules "$SCRIPT_DIR/.claude/rules"
fi

echo "    .claude/skills/ → .agents/skills/"
echo "    .claude/agents/ → .agents/agents/"
echo "    .claude/rules/  → .agents/rules/"
echo "    .codex/agents/  (TOML format, ready)"

# 5. Initialize git if not already
if [ ! -d "$SCRIPT_DIR/.git" ]; then
  git init "$SCRIPT_DIR"
  echo "==> Git repository initialized"
fi

# 6. Remove this setup script (one-time use)
read -p "Remove setup.sh? [Y/n] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
  rm -- "$0"
  echo "==> setup.sh removed"
fi

echo ""
echo "==> Done! Next steps:"
echo "    1. Install prerequisites (see README.md)"
echo "    2. Open this folder in Obsidian"
echo "    3. Run your agent tool (claude, codex, agy, cursor)"
echo ""
echo "    Cross-tool compatibility:"
echo "      Claude Code: .claude/ → .agents/ (symlinked)"
echo "      Codex:       .claude/skills/ shared, .codex/agents/ (TOML)"
echo "      Cursor:      reads .claude/ natively"
echo "      Antigravity: reads .agents/ natively"
