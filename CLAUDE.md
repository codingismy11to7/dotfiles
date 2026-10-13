# Session Initialization

At the start of each session, initialize the MCP servers:

1. **GitHub MCP** - Call `mcp__github__get_me` to verify authentication
2. **Obsidian MCP** - Call `mcp__obsidian__get_vault_stats` to verify vault access (required for documentation workflow)

Check all are responsive before proceeding.

# Pre-Flight Check

Before making any changes, read the flake.nix to understand inputs and structure, then find all existing declarations related to the feature across both system-level and home-manager modules. List every file that needs to change and what each change will be. Wait for user approval before editing.

# Project Docs

Reference docs live in `.claude/docs/`. They are not loaded automatically, so read whichever ones apply to the task:

- `project-overview.md`: repo layout, hosts, the `dotfiles.*` options, and how to add a host or module. Read it when you need orientation or are adding a host or module.
- `code-style.md`: Nix conventions (`with builtins;`, `cfg`/`inherit` patterns, centralized options, `core.nix` vs `home.nix`). Read it before writing or editing any `.nix` file.
- `commands.md`: build, test, format, lint, deploy and debug commands, plus the flake-update rules. Read it before running builds, updating inputs, or deploying.
- `task-checklist.md`: validation, formatting, documentation and commit steps. Read it before you call a task done.
- `documentation-workflow.md`: Obsidian daily-note and `nixos.md` conventions, including the bidirectional links. Read it whenever you document a change.

If one of these docs disagrees with the code, the code wins. Update the doc in the same change.
