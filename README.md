# proxyctl

[English](README.md) | [Русский](README.ru.md)

`proxyctl` is a Bash CLI/TUI for operating a personal or small-scale Dante SOCKS5 proxy on Ubuntu.

It wraps the routine administration tasks that usually end up scattered across `systemctl`, `ufw`, `journalctl`, `passwd`, and direct edits to `/etc/danted.conf`.

## Features

- Interactive terminal UI with Russian/English interface
- Dante service control and diagnostics
- Proxy user lifecycle management
- Access output formats for generic SOCKS, Telegram link, and URI
- UFW management for SOCKS access
- Fail2ban-aware audit reporting
- Per-user traffic accounting from Dante logs
- Per-user monthly traffic quotas with automatic enforcement
- Daily systemd timer for quota enforcement
- Voice-call readiness checks for Telegram via UDP relay diagnostics

## Scope

`proxyctl` assumes a system-managed Dante deployment on Linux, currently tuned for Ubuntu-style environments with:

- `systemd`
- `ufw`
- `journalctl`
- `dante-server`
- PAM-based auth

It is not a generic multi-distro framework and it is not a hosted control panel.

## Repository layout

```text
bin/proxyctl              Main executable
scripts/bootstrap.sh      Clean-server bootstrap wrapper
docs/OPERATIONS.md        Operational usage and command reference
scripts/install.sh        Install helper
scripts/uninstall.sh      Uninstall helper
systemd/*.service         Optional runtime automation units
systemd/*.timer           Optional runtime automation timers
```

## Quick install

```bash
git clone <your-repo-url>
cd proxyctl
sudo ./scripts/install.sh
```

That installs:

- `bin/proxyctl` -> `/usr/local/bin/proxyctl`
- `docs/OPERATIONS.md` -> `/usr/local/share/doc/proxyctl/OPERATIONS.md`
- `systemd/proxyctl-quota-enforce.*` -> `/etc/systemd/system/`
- `systemd/proxyctl-usage-cache-warm.*` -> `/etc/systemd/system/`

And enables:

- daily quota enforcement timer
- periodic monthly usage-cache warm timer

## Bootstrap a clean server

For a fresh Ubuntu VPS, use the repository bootstrap wrapper:

```bash
git clone <your-repo-url>
cd proxyctl
sudo ./scripts/bootstrap.sh --proxy-password-random
```

Useful variants:

```bash
sudo ./scripts/bootstrap.sh --proxy-password-random --allow-ip 203.0.113.10
sudo ./scripts/bootstrap.sh --proxy-user alice --proxy-password 'strong-pass' --format telegram
sudo ./scripts/bootstrap.sh --dry-run
```

What bootstrap does:

- installs `dante-server`, `ufw`, and optionally `fail2ban`
- writes managed `danted`, PAM, and fail2ban config
- creates or adopts the initial proxy user
- enables and restarts the required services
- configures SOCKS TCP and UDP UFW rules
- prints access data and runs `doctor`

## Quick usage

```bash
sudo proxyctl
sudo proxyctl help
sudo proxyctl bootstrap --dry-run
sudo proxyctl doctor
sudo proxyctl user add alice --random --format telegram
sudo proxyctl usage
sudo proxyctl usage --warm-cache
sudo proxyctl quota list
```

## What it manages

`proxyctl` works with these system paths:

- `/etc/danted.conf`
- `/etc/pam.d/danted`
- `/etc/proxyctl/lang`
- `/etc/proxyctl/quotas.conf`
- `/etc/proxyctl/cache/usage-YYYY-MM.db`
- `/etc/proxyctl/backups/*`
- `/etc/systemd/system/proxyctl-quota-enforce.service`
- `/etc/systemd/system/proxyctl-quota-enforce.timer`
- `/etc/systemd/system/proxyctl-usage-cache-warm.service`
- `/etc/systemd/system/proxyctl-usage-cache-warm.timer`

It also expects the Dante fail2ban jail to exist if you use the audit/security features.

## Runtime model

`proxyctl` is intentionally operational rather than abstract:

- it expects an already installed and configured `dante-server`
- it reads traffic data from `journalctl`
- monthly usage reporting is accelerated with a local cache under `/etc/proxyctl/cache`
- quota enforcement is executed by a daily systemd timer
- usage-cache warm-up is executed by a periodic systemd timer

## Publishing notes

This repository is prepared for GitHub publication, but it still reflects the operational choices of the current implementation:

- root-oriented administration model
- Ubuntu/Debian command assumptions
- direct system file edits

If you want broader adoption, the next step is to split runtime config from product code and add tests for the log parsers.

## License

MIT. See [LICENSE](LICENSE).
