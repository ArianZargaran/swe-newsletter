#!/bin/bash
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

REPO_URL="https://ArianZargaran:${GITHUB_TOKEN}@github.com/ArianZargaran/swe-newsletter.git"
WORK_DIR="/home/user"

cd "$WORK_DIR"

if [ ! -d ".git" ]; then
  git clone "$REPO_URL" .
else
  git remote set-url origin "$REPO_URL"
  git pull origin main
fi
