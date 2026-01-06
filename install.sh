#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${HOME}/.config/nvim"
BACKUP_DIR="${HOME}/.config/nvim.bak.$(date +%Y%m%d%H%M%S)"

mkdir -p "$(dirname "$TARGET")"

if [ -L "$TARGET" ]; then
  CURRENT_TARGET="$(readlink "$TARGET")"
  if [ "$CURRENT_TARGET" = "$REPO_DIR" ]; then
    echo "Already linked: $TARGET -> $REPO_DIR"
    exit 0
  fi
  mv "$TARGET" "$BACKUP_DIR"
  echo "Backed up existing symlink to: $BACKUP_DIR"
elif [ -e "$TARGET" ]; then
  mv "$TARGET" "$BACKUP_DIR"
  echo "Backed up existing path to: $BACKUP_DIR"
fi

ln -s "$REPO_DIR" "$TARGET"
echo "Linked: $TARGET -> $REPO_DIR"
