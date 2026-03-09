# Changelog

All notable changes to `proxyctl` should be documented in this file.

The format is based on Keep a Changelog principles.

## [0.1.0] - 2026-03-09

### Added

- Interactive Bash TUI for Dante proxy administration
- Russian and English interface support
- User lifecycle management for SOCKS accounts
- Telegram, generic, and URI access output formats
- UFW management helpers for SOCKS access rules
- Audit reporting with fail2ban awareness
- Per-user traffic usage reporting from Dante logs
- Per-user traffic quotas with daily systemd enforcement
- UDP relay readiness checks for Telegram calls

### Operational assumptions

- Ubuntu-style environment
- `dante-server`, `systemd`, `ufw`, `journalctl`
- PAM-based authentication
