# claude-remote-control systemd service on bluebell

- **ROOT CAUSE** - Two issues preventing the service from running:
  1. `bash -lc` in systemd doesn't load `.local/bin` into PATH → exit code 127 (command not found)
  2. WorkingDirectory defaulted to `/` (root) → "Workspace not trusted" error, and home directory (`/home/claude`) has a known bug where workspace trust doesn't persist

- **TRIALS**
  - What: Use `bash -lc` login shell to get PATH
    Why failed: systemd environment doesn't source `.profile`/`.bashrc` properly, so `.local/bin` never appears in PATH
  - What: Use full path `/home/claude/.local/bin/claude` directly in ExecStart
    Why worked: Bypasses PATH entirely
  - What: Set WorkingDirectory to `/home/claude`
    Why failed: Home directory has a known Claude Code bug where workspace trust doesn't persist (upstream issues: anthropics/claude-code#14833, #21283)
  - What: Set WorkingDirectory to `/home/claude/repos`
    Why worked: Non-home subdirectories persist workspace trust correctly

- **TAKEAWAY**
  - Always use full paths for binaries in systemd services, never rely on login shell PATH tricks
  - Claude Code workspace trust has a known bug with home directories — use a subdirectory as WorkingDirectory
  - `--dangerously-skip-permissions` doesn't skip workspace trust checks
  - `claude --dangerously-skip-permissions remote-control` doesn't work — the flag causes `remote-control` to be parsed as an argument, not a subcommand. Use `settings.json` instead
