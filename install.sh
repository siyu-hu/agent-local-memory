#!/usr/bin/env bash
# agent-local-memory install script
#
# Usage:
#   bash install.sh            # auto-detect platform
#   bash install.sh claude     # install for Claude Code
#   bash install.sh openclaw   # install for OpenClaw

set -e

REPO="https://github.com/siyu-hu/agent-local-memory"
SKILL_NAME="agent-local-memory"

detect_platform() {
  if [ -d "$HOME/.openclaw" ]; then
    echo "openclaw"
  else
    echo "claude"
  fi
}

install_skill() {
  local platform="${1:-$(detect_platform)}"

  case "$platform" in
    claude)
      SKILLS_DIR="$HOME/.claude/skills"
      MEMORY_DIR="$HOME/.claude/memory"
      ;;
    openclaw)
      SKILLS_DIR="$HOME/.openclaw/skills"
      MEMORY_DIR="$HOME/.openclaw/memory"
      ;;
    *)
      echo "Unknown platform: $platform. Use 'claude' or 'openclaw'."
      exit 1
      ;;
  esac

  echo "=> Installing to: $SKILLS_DIR/$SKILL_NAME"

  mkdir -p "$SKILLS_DIR"
  mkdir -p "$MEMORY_DIR"

  if [ -d "$SKILLS_DIR/$SKILL_NAME" ]; then
    echo "=> Already installed, updating..."
    git -C "$SKILLS_DIR/$SKILL_NAME" pull
  else
    git clone "$REPO" "$SKILLS_DIR/$SKILL_NAME"
  fi

  echo ""
  echo "Done! Memory will be stored at: $MEMORY_DIR"
  echo ""
  echo "Try saying to your AI:"
  echo "  \"Remember, I prefer concise code with no unnecessary comments\""
  echo "  \"What do you remember about me?\""
}

install_skill "$1"
