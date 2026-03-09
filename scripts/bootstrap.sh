#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ "${EUID}" -ne 0 ]]; then
  echo "run as root: sudo ./scripts/bootstrap.sh [options]" >&2
  exit 1
fi

bash "$ROOT_DIR/scripts/install.sh"
exec /usr/local/bin/proxyctl bootstrap "$@"
