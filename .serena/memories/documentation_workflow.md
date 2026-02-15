# Documentation Workflow

## Prerequisites
This workflow requires the **Obsidian MCP** to be available. Verify during session initialization.

## Obsidian Vault Location
`/home/steven/nextcloud/Obsidian Vault`

## Daily Notes
When making NixOS configuration changes:

1. **Check for today's daily note** at `Daily Notes/YYYY/MM/YYYY-MM-DD.md`
2. **If today's note doesn't exist**, ask to create it or update yesterday's note
3. **Document the change** in the daily note with a descriptive section header

## NixOS Documentation
Update `nixos.md` when changes affect:
- Package installations/removals
- Module configurations
- System settings
- Device IDs or other reference information

## Bidirectional Linking
Always create bidirectional links:
- In `nixos.md`: Link to the daily note where the change was made
  - Format: `[[Daily Notes/YYYY/MM/YYYY-MM-DD#Section Header|description]]`
- In daily note: Link back to the relevant section in `nixos.md`
  - Format: `[[nixos#Section|NixOS Section Name]]`

## Example
When adding a new package:
1. Add to daily note: "## NixOS — Package Name" with details, link to `[[nixos#Packages|NixOS Packages]]`
2. Add to nixos.md Packages section with link to daily note
