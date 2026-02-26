#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SOURCE="$SCRIPT_DIR/skills"
SKILLS_TARGET="$HOME/.claude/skills"

if [ ! -d "$SKILLS_SOURCE" ]; then
  echo "ERROR: skills/ directory not found at $SKILLS_SOURCE"
  exit 1
fi

mkdir -p "$HOME/.claude"

if [ -e "$SKILLS_TARGET" ]; then
  echo "WARNING: $SKILLS_TARGET already exists."
  read -rp "Overwrite? (y/N): " confirm
  if [[ "$confirm" != [yY] ]]; then
    echo "Aborted."
    exit 0
  fi
  rm -rf "$SKILLS_TARGET"
fi

# Detect OS for symlink strategy
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
  # Windows: use cmd mklink (requires admin or Developer Mode)
  SKILLS_SOURCE_WIN="$(cygpath -w "$SKILLS_SOURCE")"
  SKILLS_TARGET_WIN="$(cygpath -w "$SKILLS_TARGET")"
  cmd //c "mklink /D \"$SKILLS_TARGET_WIN\" \"$SKILLS_SOURCE_WIN\"" 2>/dev/null \
    || { echo "ERROR: mklink failed. Enable Developer Mode or run as admin."; exit 1; }
else
  ln -s "$SKILLS_SOURCE" "$SKILLS_TARGET"
fi

echo "Linked: $SKILLS_TARGET -> $SKILLS_SOURCE"
echo "Done. Skills are now available to Claude Code."
