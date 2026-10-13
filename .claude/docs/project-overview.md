# Project Overview

## Purpose

NixOS flake-based dotfiles repository for declarative system configuration. Manages multiple machines with shared modules and host-specific overrides.

## Tech Stack

- **Nix Language**: All configuration in `.nix` files
- **NixOS**: Linux distribution with declarative configuration
- **flake-parts**: Modular flake framework for organization
- **home-manager**: User environment management (dotfiles, packages, services)
- **disko**: Declarative disk partitioning (LUKS + Btrfs)
- **stylix**: System-wide theming
- **omarchy**: Custom desktop environment (`github:codingismy11to7/omarchy`; a commented-out `path:` URL in `flake.nix` switches to a local checkout)
- **NixOS-WSL**: For the WSL hosts
- **nixpkgs release-26.05**: Stable channel
- **nixpkgs-unstable**: Available for selective packages

## Codebase Structure

```
flake.nix              # Main entry point (inputs, outputs); hosts auto-discovered from hosts/
flake.lock             # Pinned dependency versions
modules/
├── core.nix           # System imports (explicit list of */core.nix)
├── home.nix           # Home Manager integration (explicit list of */home.nix)
├── options.nix        # Custom dotfiles.* options
├── boot/core.nix      # Bootloader, kernel, plymouth
├── users/core.nix     # User account creation
├── fish/              # Fish shell configuration
├── nvim/home.nix      # Neovim configuration
├── omarchy/           # Desktop environment
├── stylix/            # Theming
├── wsl/               # WSL-specific config
├── zellij/            # Terminal multiplexer
└── ... (many more)
hosts/
├── nixorge/           # Personal machine
├── nixvm/             # Virtual machine
├── nixxy386/          # Work machine
├── nixowsl/           # Personal WSL (headless)
└── cm-wsl/            # Work WSL (headless)
.scripts/
├── deploy             # Deploy to remote machine
├── dev-mode           # Hot-reload development
└── vm-deploy          # Deploy to a VM
```

## Custom Options (config.dotfiles.*)

See `modules/options.nix` for the authoritative list. Current options:

- `hostname`: Machine hostname
- `headless`: Whether system has no GUI (default: false)
- `wsl`: Whether this is a WSL system (default: false)
- `virtManager`: Enable virt-manager (default: !headless)
- `consoleKeyMap`: Console keyboard (default: "dvorak")
- `keyboardLayout`/`keyboardVariant`: X keyboard settings
- `timeZone`: System timezone (default: "America/New_York")
- `personal.username`: User account (default: "steven")
- `personal.fullName`: Full name (default: "Steven Scott")
- `personal.gitEmail`: Git email (required per-host)
- `kernel`: "zen" | "latest" | "default" (default: "latest")
- `gaming`: Enable gaming packages
- `videoEncoding`: Enable Handbrake/MakeMKV
- `browser`: Which browser ("brave", "chromium", "google-chrome")
- `fastfetchLogo`: Optional custom fastfetch logo path
- `syncthing.devices`: Syncthing device name → ID map
- `omarchyTheme`: Theme name (default: "ethereal")
- `stylixFromImage`: Generate colors from wallpaper
- `dotfilesPath`: Absolute path to this repo on the machine
- `wireshark`: Enable Wireshark
- `nixdatifier`: Put the nixdatifier binary on PATH on headless hosts (opt-in; GUI hosts always get the tray app)

## Adding a New Host

1. Create `hosts/<hostname>/` with:
   - `default.nix` - Entry point
   - `config.nix` - Host-specific options
   - `hardware.nix` - Hardware detection
   - `disk-config.nix` - Disk layout (not needed for WSL hosts)
2. `git add` the new directory — `flake.nix` picks up every directory under `hosts/` automatically, but flakes only see tracked files
3. Set required options (especially `personal.gitEmail`)

## Adding a New Module

Create `modules/<name>/core.nix` and/or `home.nix`, then add it to the import list in `modules/core.nix` or `modules/home.nix` — imports are explicit, not auto-discovered.
