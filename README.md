# dotfiles

NixOS flake-based system configuration.

## Usage

```bash
# Build configuration
nh os build .

# Apply and switch
nh os switch .
```

## Structure

- `hosts/` - Per-machine configs (hardware, disk layout, host options)
- `modules/` - Modular NixOS and home-manager configs
- `flake.nix` - Flake inputs and host definitions
