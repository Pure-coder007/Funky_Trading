#!/usr/bin/env bash

set -euo pipefail

APP_DIR="${1:-/var/www/funky}"
BRANCH="${2:-main}"

if [[ ! -d "${APP_DIR}/.git" ]]; then
  echo "Git repository not found in ${APP_DIR}"
  exit 1
fi

git -C "${APP_DIR}" fetch origin
git -C "${APP_DIR}" checkout "${BRANCH}"
git -C "${APP_DIR}" pull --ff-only origin "${BRANCH}"

echo "Updated ${APP_DIR} from origin/${BRANCH}"
