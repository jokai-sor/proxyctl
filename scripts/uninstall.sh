#!/usr/bin/env bash
set -euo pipefail

DST_BIN="/usr/local/bin/proxyctl"
DOC_DIR="/usr/local/share/doc/proxyctl"

if [[ "${EUID}" -ne 0 ]]; then
  echo "run as root: sudo ./scripts/uninstall.sh" >&2
  exit 1
fi

rm -f "$DST_BIN"
rm -rf "$DOC_DIR"

echo "removed:"
echo "  $DST_BIN"
echo "  $DOC_DIR"
