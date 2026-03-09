#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_BIN="$ROOT_DIR/bin/proxyctl"
DST_BIN="/usr/local/bin/proxyctl"
DOC_DIR="/usr/local/share/doc/proxyctl"
SYSTEMD_DIR="/etc/systemd/system"
QUOTA_SERVICE="proxyctl-quota-enforce.service"
QUOTA_TIMER="proxyctl-quota-enforce.timer"
USAGE_CACHE_SERVICE="proxyctl-usage-cache-warm.service"
USAGE_CACHE_TIMER="proxyctl-usage-cache-warm.timer"

if [[ "${EUID}" -ne 0 ]]; then
  echo "run as root: sudo ./scripts/install.sh" >&2
  exit 1
fi

install -d -m 0755 "$(dirname "$DST_BIN")"
install -m 0755 "$SRC_BIN" "$DST_BIN"

install -d -m 0755 "$DOC_DIR"
install -m 0644 "$ROOT_DIR/docs/OPERATIONS.md" "$DOC_DIR/OPERATIONS.md"

install -d -m 0755 "$SYSTEMD_DIR"
install -m 0644 "$ROOT_DIR/systemd/$QUOTA_SERVICE" "$SYSTEMD_DIR/$QUOTA_SERVICE"
install -m 0644 "$ROOT_DIR/systemd/$QUOTA_TIMER" "$SYSTEMD_DIR/$QUOTA_TIMER"
install -m 0644 "$ROOT_DIR/systemd/$USAGE_CACHE_SERVICE" "$SYSTEMD_DIR/$USAGE_CACHE_SERVICE"
install -m 0644 "$ROOT_DIR/systemd/$USAGE_CACHE_TIMER" "$SYSTEMD_DIR/$USAGE_CACHE_TIMER"

systemctl daemon-reload
systemctl enable --now "$QUOTA_TIMER"
systemctl enable --now "$USAGE_CACHE_TIMER"

echo "installed:"
echo "  $DST_BIN"
echo "  $DOC_DIR/OPERATIONS.md"
echo "  $SYSTEMD_DIR/$QUOTA_SERVICE"
echo "  $SYSTEMD_DIR/$QUOTA_TIMER"
echo "  $SYSTEMD_DIR/$USAGE_CACHE_SERVICE"
echo "  $SYSTEMD_DIR/$USAGE_CACHE_TIMER"
