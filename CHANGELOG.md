# Changelog

All notable changes to `proxyctl` should be documented in this file.

The format is based on Keep a Changelog principles.

## [0.2.0] - 2026-03-09

### Added

- `proxyctl bootstrap` for clean-server and prepared-server setup flows
- `scripts/bootstrap.sh` wrapper for zero-to-production bootstrap from a fresh repo checkout
- Managed Dante, PAM, and fail2ban configuration rendering with automatic backups under `/etc/proxyctl/backups`
- Monthly usage cache with `proxyctl usage --warm-cache`
- `systemd` runtime units for quota enforcement and usage-cache warm-up

### Changed

- `install.sh` now installs and enables runtime automation units
- Default monthly `usage` and `quota list` are accelerated after cache warm-up
- Documentation now covers bootstrap, runtime model, and automation timers

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
