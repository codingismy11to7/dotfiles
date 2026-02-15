# Session Initialization

At the start of each session, initialize the MCP servers:

1. **GitHub MCP** - Call `mcp__github__get_me` to verify authentication
2. **Serena MCP** - Call `mcp__plugin_serena_serena__activate_project` with project `dotfiles`
3. **Obsidian MCP** - Call `mcp__obsidian__get_vault_stats` to verify vault access (required for documentation workflow)

Check all are responsive before proceeding.

# Pre-Flight Check

Before making any changes, read the flake.nix to understand inputs and structure, then find all existing declarations related to the feature across both system-level and home-manager modules. List every file that needs to change and what each change will be. Wait for user approval before editing.
