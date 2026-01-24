# AGENTS.md

Quickemu is a Bash wrapper around QEMU that automates VM creation for ~1000 operating systems (Linux, macOS, Windows, BSDs). Two main tools: `quickget` downloads ISOs and creates configs; `quickemu` launches VMs with optimised hardware detection.

## Project structure

```
quickemu        # Main VM launcher script (Bash)
quickget        # OS downloader and config generator (Bash)
quickreport     # System diagnostics tool (Bash)
chunkcheck      # Download verification utility (Bash)
flake.nix       # Nix flake for packaging
package.nix     # Nix package definition
devshell.nix    # Development environment
```

## Development environment

```shell
nix develop                    # Enter devshell with all dependencies
direnv reload                  # Update .direnv/bin/quickemu for testing
```

The devshell patches `quickemu` to use Nix store paths for OVMF and Samba, writing to `.direnv/bin/quickemu`.

## Build and test commands

- Lint scripts: `shellcheck quickemu quickget quickreport chunkcheck`
- Test quickget URLs: `./quickget --check <os> [release] [edition]`
- List all supported OSes: `./quickget --list`
- Run VM: `./quickemu --vm <name>.conf`

## Code style

All scripts are Bash 4.0+ with ShellCheck compliance.

| File | Indent | Notes |
|------|--------|-------|
| quickemu | 2 spaces | Main VM launcher |
| quickget | 4 spaces | OS definitions and download logic |

**General conventions:**

- UTF-8, LF line endings, final newline
- Trim trailing whitespace (except Markdown)
- Functions use `function name() {` syntax
- Many functions are invoked indirectly via dynamic dispatch - `SC2317` is disabled globally in quickget

## Adding a new OS to quickget

Follow the [guide in the wiki](https://github.com/quickemu-project/quickemu/wiki/06-Advanced-quickget-features#adding-a-new-os-to-quickget). Each OS requires:

1. Entry in `os_info()` case statement
2. `releases_<os>()` function returning available versions
3. `editions_<os>()` function if multiple editions exist
4. Download URL construction logic

## Commit message format

Commits must follow [Conventional Commits](https://www.conventionalcommits.org/). PR titles are validated against this format.

**Common prefixes:**

- `fix(quickget):` - Fix distro downloads, update editions/releases
- `fix(quickemu):` - Fix VM configuration or runtime issues
- `feat(quickget):` - Add new OS support
- `feat(quickemu):` - Add new VM features
- `ci:` - CI/workflow changes
- `docs:` - Documentation updates

**Examples from recent history:**

```
fix(quickget): update Zorin OS download method and editions
fix(quickget): handle Solus Xfce beta naming for older releases
fix(quickget): remove Athena OS (no longer getting updates)
```

## Pull request guidelines

- PR titles must match Conventional Commits format (enforced by CI)
- Single-commit PRs: commit message must match PR title
- Run `shellcheck` before submitting
- Test affected OS downloads with `./quickget --check <os> <release>`

## CI workflows

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| lint-shellcheck | PR | ShellCheck with severity: warning |
| lint-pr | PR | Validates PR title matches Conventional Commits |
| test-quickget | PR | Tests quickget functionality |
| test-build-quickemu | PR | Build verification |
| flake-checker | PR | Nix flake validation |

## Platform support

- Host: Linux (x86_64, aarch64), macOS (x86_64, aarch64)
- OVMF/UEFI firmware: Linux only
- Bash 4.0+ required (explicit version check at runtime)

## Key dependencies

Runtime: qemu, cdrtools, curl, jq, spice-gtk, swtpm, samba, zsync
Linux-specific: OVMF, usbutils, mesa-demos
