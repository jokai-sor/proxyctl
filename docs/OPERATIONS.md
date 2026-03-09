# Operations

## Installation

```bash
sudo ./scripts/install.sh
sudo proxyctl help
```

## Bootstrap

Clean server:

```bash
sudo ./scripts/bootstrap.sh --proxy-password-random
```

Installed proxyctl:

```bash
sudo proxyctl bootstrap --proxy-password-random
sudo proxyctl bootstrap --proxy-password-random --allow-ip 203.0.113.10
sudo proxyctl bootstrap --dry-run
```

The bootstrap command:

- installs required packages
- writes managed Dante/PAM/fail2ban config
- creates or updates the initial proxy user
- enables and restarts services
- configures UFW SOCKS and UDP relay rules
- runs `doctor` at the end

Install also enables:

- `proxyctl-quota-enforce.timer`
- `proxyctl-usage-cache-warm.timer`

## Interactive mode

```bash
sudo proxyctl
```

Hotkeys:

- `h` help
- `b` back
- `q` quit

## Core command groups

```bash
proxyctl service ...
proxyctl bootstrap ...
proxyctl user ...
proxyctl firewall ...
proxyctl config ...
proxyctl lang ...
proxyctl audit ...
proxyctl usage ...
proxyctl quota ...
proxyctl doctor
```

## Service

```bash
sudo proxyctl service status
sudo proxyctl service restart
sudo proxyctl service logs --since "2 hours ago"
sudo proxyctl service logs --follow
sudo proxyctl service connections
```

## Users

```bash
sudo proxyctl user list
sudo proxyctl user adopt proxy-user
sudo proxyctl user add alice --random
sudo proxyctl user add alice --random --format telegram
sudo proxyctl user passwd alice --random
sudo proxyctl user access alice --format uri
sudo proxyctl user access alice --reset-password --format telegram
sudo proxyctl user lock alice
sudo proxyctl user unlock alice
sudo proxyctl user delete alice
```

## Firewall

```bash
sudo proxyctl firewall status
sudo proxyctl firewall allow-ip 203.0.113.10
sudo proxyctl firewall revoke-ip 203.0.113.10
sudo proxyctl firewall open-public
sudo proxyctl firewall close-public
```

## Config

```bash
sudo proxyctl config show
sudo proxyctl config port
sudo proxyctl config port 2080
sudo proxyctl config backup
sudo proxyctl config restore /etc/danted.conf.bak.2026-03-07-170500
```

## Audit

```bash
sudo proxyctl audit
sudo proxyctl audit --since "24 hours ago"
```

## Usage and quotas

```bash
sudo proxyctl usage
sudo proxyctl usage --warm-cache
sudo proxyctl usage --since "1 hour ago" --user proxy-user
sudo proxyctl usage --user proxy-user
sudo proxyctl quota list
sudo proxyctl quota set proxy-user 30
sudo proxyctl quota enforce --dry-run
sudo proxyctl quota enforce
sudo proxyctl quota del proxy-user
```

## Automation

```bash
sudo systemctl status --no-pager proxyctl-quota-enforce.timer
sudo systemctl status --no-pager proxyctl-usage-cache-warm.timer
sudo systemctl start proxyctl-usage-cache-warm.service
sudo systemctl start proxyctl-quota-enforce.service
```

## Notes

- Traffic accounting is derived from Dante logs, not packet capture.
- Quota enforcement is lock-based: over-limit users are blocked with `passwd -l`.
- Default monthly `usage` and `quota list` are accelerated by a local cache in `/etc/proxyctl/cache`.
- Voice-call support requires `udpassociate`, `udp.portrange`, and matching UFW UDP rules.
- This tool is designed around Ubuntu-style operational assumptions.
