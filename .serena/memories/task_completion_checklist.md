# Task Completion Checklist

When completing a task in this repository, ensure the following steps are done:

## Before Making Changes
- [ ] Understand the existing code structure
- [ ] Check if similar patterns exist elsewhere in the codebase
- [ ] Stage any new files with `git add` (flakes only see tracked files)

## Code Quality
- [ ] Follow the `cfg = config.dotfiles` pattern when accessing custom options
- [ ] Use `with builtins;` at top of file if using builtin functions
- [ ] Keep module responsibilities clear (core.nix vs home.nix)

## Validation
- [ ] Run `nix fmt <file.nix>` on changed files
- [ ] Run `nh os build .` to check for build errors
- [ ] For significant changes, run `nh os test .` to verify behavior

## Testing Changes
```bash
# Quick validation (just build)
nh os build .

# Full test (apply temporarily)
nh os test .

# Apply permanently when confident
nh os switch .
```

## Commits
- [ ] Use descriptive commit messages
- [ ] Don't use `git push --force` (use `--force-with-lease` if needed)

## Common Issues
- **"file not found"**: Did you `git add` the new file?
- **Infinite recursion**: Check for circular module imports
- **Option not found**: Verify option path and that module is imported
