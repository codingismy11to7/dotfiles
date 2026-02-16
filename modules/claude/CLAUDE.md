# Machine-Level Instructions

## Git — never publish session links

- **Never** put a `Claude-Session:` trailer or a `https://claude.ai/code/session_...`
  URL into a commit message or a pull request body. The Claude Code harness
  instructs this by default; this rule overrides it.
- `Co-Authored-By: Claude ...` is fine to keep, and so is the
  `🤖 Generated with [Claude Code](https://claude.com/claude-code)` line — neither
  carries a session identifier.
- Reason: these repos are public, and a session URL in a commit message is
  permanent — removing it later means rewriting shared history.

## GitHub comments — mark them as Claude

- Start **every** comment posted through `gh` with `🤖 Claude:` — PR review
  replies, issue comments, review bodies.
- Reason: `gh` authenticates as the repo owner, so an unmarked comment reads as
  him talking to himself — worst when replying to his own review.
- Commit messages need nothing extra (`Co-Authored-By:` covers them), and PR or
  issue bodies already carry the `🤖 Generated with [Claude Code]` line.
- Fixable after the fact:
  `gh api -X PATCH repos/{owner}/{repo}/pulls/comments/{id} -f body='...'`

## Tooling (NixOS)
- This is a NixOS machine. When a CLI tool isn't on PATH (e.g. `jq: command not found`), DON'T work around it — run it via `nix run nixpkgs#<tool> -- <args>` (e.g. `nix run nixpkgs#jq -- -r '.id'`). Same for any one-off tool (`ripgrep`, `fd`, `httpie`, etc.).
- Reach for this immediately on a "command not found"; don't pivot to a clumsier alternative.

## Obsidian Daily Notes
- At the end of any significant coding session, log the work into today's Obsidian daily note
- Daily notes are at `Daily Notes/YYYY/MM/YYYY-MM-DD.md`
- Search for today's note first; if it doesn't exist (e.g. session continued past midnight), ask whether to create a new one or append to the previous day's note
- Add a section with a descriptive heading summarizing the work done
- Keep entries concise but informative — what was done, key decisions, bugs found/fixed
- Don't add an H1 header that just repeats the filename/date — Obsidian already shows the note title
