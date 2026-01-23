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
- **omarchy**: Custom desktop environment (referenced from local path)
- **nixpkgs release-25.11**: Stable channel
- **nixpkgs-unstable**: Available for selective packages

## Codebase Structure
```
flake.nix              # Main entry point (inputs, outputs, hosts list)
flake.lock             # Pinned dependency versions
modules/
├── core.nix           # Main system imports
├── home.nix           # Home Manager integration
├── options.nix        # Custom dotfiles.* options
├── boot/core.nix      # Bootloader, kernel (zen), plymouth
├── users/core.nix     # User account creation
├── fish/              # Fish shell configuration
├── git/home.nix       # Git configuration
├── nvim/home.nix      # Neovim configuration
├── omarchy/           # Desktop environment
├── stylix/            # Theming
├── zellij/            # Terminal multiplexer
└── ... (many more)
hosts/
├── nixorge/           # Personal machine
├── nixvm/             # Virtual machine
└── nixxy386/          # Work machine
.scripts/
├── deploy             # Deploy to remote machine
└── dev-mode           # Hot-reload development
```

## Custom Options (config.dotfiles.*)
- `hostname`: Machine hostname
- `headless`: Whether system has no GUI (default: false)
- `virtManager`: Enable virt-manager (default: !headless)
- `consoleKeyMap`: Console keyboard (default: "dvorak")
- `keyboardLayout`/`keyboardVariant`: X keyboard settings
- `timeZone`: System timezone (default: "America/New_York")
- `personal.username`: User account (default: "steven")
- `personal.fullName`: Full name (default: "Steven Scott")
- `personal.gitEmail`: Git email (required per-host)
- `gaming`: Enable gaming packages
- `browser`: Which browser ("brave", "chromium", "google-chrome")
- `omarchyTheme`: Theme name (default: "ethereal")
- `stylixFromImage`: Generate colors from wallpaper

## Adding a New Host
1. Create `hosts/<hostname>/` with:
   - `default.nix` - Entry point
   - `config.nix` - Host-specific options
   - `hardware.nix` - Hardware detection
   - `disk-config.nix` - Disk layout
2. Add hostname to `hosts` list in `flake.nix`
3. Set required options (especially `gitEmail`)
