#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_BIN="$ROOT_DIR/bin/proxyctl"
DST_BIN="/usr/local/bin/proxyctl"
DOC_DIR="/usr/local/share/doc/proxyctl"

if [[ "${EUID}" -ne 0 ]]; then
  echo "run as root: sudo ./scripts/install.sh" >&2
  exit 1
fi

install -d -m 0755 "$(dirname "$DST_BIN")"
install -m 0755 "$SRC_BIN" "$DST_BIN"

install -d -m 0755 "$DOC_DIR"
install -m 0644 "$ROOT_DIR/docs/OPERATIONS.md" "$DOC_DIR/OPERATIONS.md"

echo "installed:"
echo "  $DST_BIN"
echo "  $DOC_DIR/OPERATIONS.md"
