# Dotfiles

Shell configuration and install scripts for macOS and Linux.

## Scanning shell/rc scripts for issues

When asked to check or scan a `.sh` or rc file, look for:

### Idempotency
- PATH or env var appends that duplicate on re-source
- File appends (>>) without guards for existing content
- Symlink creation that nests inside existing directory symlinks (use `ln -sfn`)

### Missing guards
- Commands used without checking if installed (`command -v`)
- Variables referenced that may be unset (`$DOTFILES`, `$PKG_INSTALLER`)
- Files sourced without existence checks

### Platform portability
- GNU vs BSD flag differences (e.g. `--max-depth` vs `-d` for `du`, `grep` vs `ggrep`)
- Hardcoded paths that differ across systems (`/opt/homebrew` vs `/usr/local`)

### Quoting and escaping
- Unquoted variables that may contain spaces
- Broken escape sequences in echo/printf output (especially paths with spaces)
- Heredocs or multiline strings with unintended variable expansion

### Security
- Sourcing files from user-writable locations without validation
- Exporting secrets or credentials in plain text
- Using `eval` with untrusted input
