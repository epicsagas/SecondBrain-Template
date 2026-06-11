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

# 4. Initialize git if not already
if [ ! -d "$SCRIPT_DIR/.git" ]; then
  git init "$SCRIPT_DIR"
  echo "==> Git repository initialized"
fi

# 5. Remove this setup script (one-time use)
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
echo "    3. Run 'claude' in this directory to start your AI agent"
