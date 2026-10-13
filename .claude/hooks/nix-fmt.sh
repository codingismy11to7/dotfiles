#!/usr/bin/env bash
# PostToolUse hook: run `nix fmt` on .nix files Claude edits inside this repo.
set -euo pipefail

input=$(cat)

# Cheap pre-filter so non-.nix edits don't pay for spinning up jq.
case "$input" in
  *'.nix"'*) ;;
  *) exit 0 ;;
esac

file=$(printf '%s' "$input" | nix run nixpkgs#jq -- -r '.tool_response.filePath // .tool_input.file_path // empty')

case "$file" in
  "$CLAUDE_PROJECT_DIR"/*.nix) ;;
  *) exit 0 ;;
esac

cd "$CLAUDE_PROJECT_DIR"
nix fmt -- "$file"
