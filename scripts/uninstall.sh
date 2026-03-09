#!/usr/bin/env bash
set -euo pipefail

DST_BIN="/usr/local/bin/proxyctl"
DOC_DIR="/usr/local/share/doc/proxyctl"
SYSTEMD_DIR="/etc/systemd/system"
QUOTA_SERVICE="proxyctl-quota-enforce.service"
QUOTA_TIMER="proxyctl-quota-enforce.timer"
USAGE_CACHE_SERVICE="proxyctl-usage-cache-warm.service"
USAGE_CACHE_TIMER="proxyctl-usage-cache-warm.timer"

if [[ "${EUID}" -ne 0 ]]; then
  echo "run as root: sudo ./scripts/uninstall.sh" >&2
  exit 1
fi

systemctl disable --now "$QUOTA_TIMER" >/dev/null 2>&1 || true
systemctl disable --now "$USAGE_CACHE_TIMER" >/dev/null 2>&1 || true
rm -f "$SYSTEMD_DIR/$QUOTA_SERVICE" "$SYSTEMD_DIR/$QUOTA_TIMER"
rm -f "$SYSTEMD_DIR/$USAGE_CACHE_SERVICE" "$SYSTEMD_DIR/$USAGE_CACHE_TIMER"
systemctl daemon-reload

rm -f "$DST_BIN"
rm -rf "$DOC_DIR"

echo "removed:"
echo "  $DST_BIN"
echo "  $DOC_DIR"
echo "  $SYSTEMD_DIR/$QUOTA_SERVICE"
echo "  $SYSTEMD_DIR/$QUOTA_TIMER"
echo "  $SYSTEMD_DIR/$USAGE_CACHE_SERVICE"
echo "  $SYSTEMD_DIR/$USAGE_CACHE_TIMER"
