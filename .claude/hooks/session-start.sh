#!/bin/bash
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

REPO_URL="https://ArianZargaran:${GITHUB_TOKEN}@github.com/ArianZargaran/swe-newsletter.git"
WORK_DIR="/home/user"

git config --global --add safe.directory "$WORK_DIR"
git config --global user.email "newsletter-bot@ari.soy"
git config --global user.name "Newsletter Bot"

mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

if [ ! -d ".git" ]; then
  git clone "$REPO_URL" .
else
  git remote set-url origin "$REPO_URL"
  git pull origin main
fi
