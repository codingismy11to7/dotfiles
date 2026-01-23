# Code Style and Conventions

## Nix Language Patterns

### Builtins Usage
When a file uses `builtins` functions, open with `with builtins;` at the top:
```nix
with builtins;
{
  # Now use readFile instead of builtins.readFile
  content = readFile ./file.txt;
}
```

### Config Pattern
When a module uses `config.dotfiles`, define a `let` block with `cfg` and use `inherit`:
```nix
{ config, ... }:
let
  cfg = config.dotfiles;
  inherit (cfg.personal) username;
in
{
  # Use `username` directly
  users.users.${username} = { ... };
}
```

### Inherit Everything Upfront
Pull helpers into the `let` block via `inherit` — never inline deep attribute paths in expressions. This applies to platform checks, lib functions, etc:
```nix
inherit (pkgs.stdenv.hostPlatform) isx86;
inherit (lib) mkIf;
```
Exception: `cfg.*` references (e.g. `cfg.gaming`, `cfg.headless`) are fine to use directly without inheriting — the `cfg` prefix is short enough.

### Centralized Options
- **All custom options are defined in `modules/options.nix`** under the `options.dotfiles` namespace
- Module files should NOT define their own options - they only consume `config.dotfiles.*`
- Per-host configuration goes in `hosts/<hostname>/config.nix` under the `dotfiles = { ... }` block
- Use `mkEnableOption` for boolean features, `mkOption` with appropriate types for other settings

### Module Structure
- `core.nix` files contain NixOS system-level configuration
- `home.nix` files contain home-manager user-level configuration
- Host-specific files go in `hosts/<hostname>/`

### Naming
- Modules named by their primary concern (e.g., `git/home.nix`, `fish/core.nix`)
- Hosts named descriptively (e.g., `nixorge`, `nixvm`, `nixxy386`)

## File Organization
- One concern per module directory
- System modules (`core.nix`) vs user modules (`home.nix`) separation
- Functions in subdirectories (e.g., `fish/functions/`)
- Static assets alongside their modules (e.g., `omarchy/icons/`)

## Git Practices
- **Stage new files immediately** with `git add` - nix flakes only see tracked files
- **Never force push** - use `git push --force-with-lease` when needed
- Commit messages should be descriptive of the change

## Formatting
- Use `nix fmt` (configured to use `nixfmt` in the flake)
- Run formatter before committing changes

## Type Safety
- Use `mkOption` with explicit `type` for all custom options
- Provide sensible `default` values where possible
- Add `description` for non-obvious options
