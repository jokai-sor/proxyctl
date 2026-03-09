# GitHub Publishing Notes

## Suggested repository description

Operational Bash CLI/TUI for managing a Dante SOCKS5 proxy on Ubuntu.

## Suggested topics

`bash`, `dante`, `socks5`, `proxy`, `ubuntu`, `systemd`, `ufw`, `telegram`

## Suggested first release title

`proxyctl v0.1.0`

## Suggested release notes

### Highlights

- Interactive terminal UI for Dante proxy administration
- SOCKS user management with Telegram-friendly access output
- Audit, traffic usage, and quota enforcement features
- UFW and fail2ban-aware operational checks
- UDP relay diagnostics for Telegram voice-call support

### Notes

- The tool is currently tuned for Ubuntu-style systems
- It assumes a system-managed `dante-server` installation
- Quota accounting is derived from Dante logs, not packet capture
