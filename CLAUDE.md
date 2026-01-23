# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## Overview

This is a NixOS flake-based dotfiles repository for declarative system
configuration. It uses flake-parts for modular organization and home-manager for
user environment management.

## Build Commands

```bash
# Enter development environment (auto-loaded with direnv)
nix develop

# Build configuration (check for errors)
nh os build .

# Apply configuration (test without switching)
nh os test .

# Apply and switch to new configuration
nh os switch .

# Hot-reload development (watches .nix files, rebuilds on change)
dev-mode           # build only
dev-mode --apply   # build and apply

# Format a Nix file
nix fmt <file.nix>
```

## Architecture

### Flake Structure

- **nixpkgs** (release-25.11): Stable channel
- **nixpkgs-unstable**: Available for selective packages
- **home-manager**: User configuration management
- **disko**: Declarative disk partitioning
- **flake-parts**: Modular flake framework

### Module Organization

```
modules/
├── core.nix      # Main system imports (disko, boot, users)
├── home.nix      # Home Manager integration
├── options.nix   # Custom options (dotfiles.username, fullName, gitEmail)
├── boot/core.nix # Bootloader, kernel (zen), plymouth
├── users/core.nix # User account creation
├── fish/core.nix  # Fish shell (currently commented out)
└── secrets/       # Secrets management (currently disabled)
```

### Host Configuration

Each host in `hosts/<hostname>/` contains:

- `default.nix` - Entry point importing other configs
- `config.nix` - Host-specific options (gitEmail, username overrides)
- `hardware.nix` - Hardware detection via facter
- `disk-config.nix` - Disk layout (LUKS + Btrfs subvolumes)

### Adding a New Host

1. Create `hosts/<hostname>/` with the four files above
2. Add the hostname to the `hosts` list in `flake.nix`
3. Set host-specific options in `config.nix`

### Custom Options

Define host-specific values via `config.dotfiles.*`:

- `username` (default: "steven")
- `fullName` (default: "Steven Scott")
- `gitEmail` (required per-host)

## Coding Conventions

- In files that use `builtins`, open with `with builtins;` so you can use
  `readFile` instead of `builtins.readFile`, etc.
- When a module uses `config.dotfiles`, define a `let` block with
  `cfg = config.dotfiles;` and use `inherit` to pull specific values:
  ```nix
  { config, ... }:
  let
    cfg = config.dotfiles;
    inherit (cfg.personal) username;
  in
  {
    # use `username` directly
  }
  ```
- Stage new files with `git add` as they're created - nix flakes only see
  tracked files.

## Git

- Never use `git push --force`. When a force push is required, use
  `git push --force-with-lease`.

## Key Technologies

- **nh**: NixOS helper for build/test/switch commands
- **disko**: Manages LUKS encryption + Btrfs subvolumes
- **systemd-boot**: EFI bootloader with plymouth
- **Linux Zen kernel**: Default kernel
