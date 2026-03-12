#!/usr/bin/env bash
# agent-local-memory 安装脚本 / Install script
# 用法 / Usage:
#   bash install.sh            # 自动检测平台 / auto-detect platform
#   bash install.sh claude     # 安装到 Claude Code
#   bash install.sh openclaw   # 安装到 OpenClaw

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
      echo "未知平台: $platform。请使用 'claude' 或 'openclaw'。"
      echo "Unknown platform: $platform. Use 'claude' or 'openclaw'."
      exit 1
      ;;
  esac

  echo "=> 安装到 / Installing to: $SKILLS_DIR/$SKILL_NAME"

  mkdir -p "$SKILLS_DIR"
  mkdir -p "$MEMORY_DIR"

  if [ -d "$SKILLS_DIR/$SKILL_NAME" ]; then
    echo "=> 已存在，更新中 / Already exists, updating..."
    git -C "$SKILLS_DIR/$SKILL_NAME" pull
  else
    git clone "$REPO" "$SKILLS_DIR/$SKILL_NAME"
  fi

  echo ""
  echo "✓ 安装完成 / Installation complete!"
  echo ""
  echo "记忆存储路径 / Memory storage: $MEMORY_DIR"
  echo ""
  echo "现在可以对 AI 说 / Now say to your AI:"
  echo "  \"记住，我喜欢简洁的代码风格\""
  echo "  \"Remember, I prefer concise code style\""
}

install_skill "$1"
