#!/bin/bash
# Open an SSH session using your local rc files without installing them remotely.
#
#   sshrc user@host
#   sshrc -p 2222 user@host
#
# Ships rc_common.sh + linux/.bashrc over the wire on each connect, unpacks them
# into a remote mktemp dir, and starts bash with --rcfile pointing at them. The
# temp dir is removed when the shell exits, so nothing persists on the remote.
#
# Caveats:
#   - --rcfile means the remote's own ~/.bashrc is NOT read. /etc/bash.bashrc
#     and /etc/profile.d still are, so system PATH setup survives.
#   - Aliases in rc_common.sh that point at $DOTFILES/scripts/* will not resolve;
#     only the two rc files are shipped, not the whole repo.

set -euo pipefail

if [ $# -eq 0 ]; then
    echo "usage: sshrc [ssh-options] [user@]host" >&2
    exit 1
fi

: "${DOTFILES:="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"}"

for f in rc_common.sh linux/.bashrc; do
    if [ ! -r "$DOTFILES/$f" ]; then
        echo "sshrc: missing $DOTFILES/$f" >&2
        exit 1
    fi
done

# COPYFILE_DISABLE stops macOS tar from embedding ._ AppleDouble files for the
# extended attributes on these files.
payload=$(COPYFILE_DISABLE=1 tar czf - -C "$DOTFILES" rc_common.sh linux/.bashrc \
    | base64 | tr -d '\n')

ssh -t "$@" "
    set -e
    d=\$(mktemp -d) || exit 1
    trap 'rm -rf \"\$d\"' EXIT
    printf '%s' '$payload' | base64 -d | tar xzf - -C \"\$d\"
    DOTFILES=\"\$d\" bash --rcfile \"\$d/linux/.bashrc\" -i
"
