# Contributing

## Scope

This project is an operational Bash tool for administering a Dante SOCKS5 proxy on Linux.

Contributions should keep that scope tight:

- prefer small, auditable shell changes
- avoid adding heavyweight dependencies
- preserve non-interactive CLI behavior
- keep interactive UI text concise

## Development principles

- Bash must pass `bash -n`
- prefer ASCII unless the file already uses non-ASCII text
- do not silently broaden distro support claims
- keep docs aligned with actual runtime behavior

## Before opening a change

Validate at minimum:

```bash
bash -n bin/proxyctl
bash -n scripts/install.sh
bash -n scripts/uninstall.sh
```

If you change parsing logic, test against real or representative `journalctl` output.

## Pull requests

Good PRs usually include:

- the operational problem being solved
- concrete behavior before/after
- any config or system assumptions introduced
- manual verification notes
