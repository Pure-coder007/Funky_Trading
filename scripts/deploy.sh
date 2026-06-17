#!/usr/bin/env bash

set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <server-user> <server-host> [remote-dir]"
  echo "Example: $0 root 143.198.113.215 /var/www/funky"
  exit 1
fi

SERVER_USER="$1"
SERVER_HOST="$2"
REMOTE_DIR="${3:-/var/www/funky}"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

rsync -avz --delete \
  --exclude ".git" \
  --exclude ".DS_Store" \
  --exclude "README.md" \
  --exclude "scripts" \
  "${ROOT_DIR}/" "${SERVER_USER}@${SERVER_HOST}:${REMOTE_DIR}/"

echo "Site files synced to ${SERVER_USER}@${SERVER_HOST}:${REMOTE_DIR}"
