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
docs/OPERATIONS.md        Operational usage and command reference
scripts/install.sh        Install helper
scripts/uninstall.sh      Uninstall helper
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

## Quick usage

```bash
sudo proxyctl
sudo proxyctl help
sudo proxyctl doctor
sudo proxyctl user add alice --random --format telegram
sudo proxyctl usage
sudo proxyctl quota list
```

## What it manages

`proxyctl` works with these system paths:

- `/etc/danted.conf`
- `/etc/pam.d/danted`
- `/etc/proxyctl/lang`
- `/etc/proxyctl/quotas.conf`
- `/etc/systemd/system/proxyctl-quota-enforce.service`
- `/etc/systemd/system/proxyctl-quota-enforce.timer`

It also expects the Dante fail2ban jail to exist if you use the audit/security features.

## Publishing notes

This repository is prepared for GitHub publication, but it still reflects the operational choices of the current implementation:

- root-oriented administration model
- Ubuntu/Debian command assumptions
- direct system file edits

If you want broader adoption, the next step is to split runtime config from product code and add tests for the log parsers.

## License

MIT. See [LICENSE](LICENSE).
