# Suggested Commands

## Development Environment
```bash
# Enter development shell (auto-loaded via direnv)
nix develop

# Check current direnv status
direnv status
```

## Flake Input Updates
```bash
# NEVER run `nix flake update` (updates ALL inputs) unless explicitly instructed
# Always update specific inputs only:
nix flake update <input-name>

# Example: update only omarchy
nix flake update omarchy
```

## Build and Apply Configuration
```bash
# Build configuration (check for errors, doesn't apply)
nh os build .

# Test configuration (applies temporarily, reverts on reboot)
nh os test .

# Apply and switch to new configuration (persistent)
nh os switch .

# Update flake inputs
nix flake update

# Update specific input
nix flake update <input-name>
```

## Hot-Reload Development
```bash
# Watch .nix files and rebuild on changes
dev-mode

# Watch, rebuild, and apply on changes
dev-mode --apply
```

## Formatting
```bash
# Format a specific Nix file
nix fmt <file.nix>

# Format all Nix files (via formatter in flake)
nix fmt
```

## Remote Deployment
```bash
# Deploy to a remote machine (interactive script)
deploy
```

## Git Workflow
```bash
# Stage new files (required for flakes to see them)
git add <file>

# NEVER use --force, use this instead
git push --force-with-lease
```

## Debugging
```bash
# Evaluate a specific option
nix eval .#nixosConfigurations.<host>.config.<option>

# Show flake outputs
nix flake show

# Check flake validity
nix flake check
```
