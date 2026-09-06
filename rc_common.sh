
# Source .env file if it exists
if [[ -f "$HOME/.env" ]]; then
    set -a  # automatically export all variables
    source "$HOME/.env"
    set +a  # stop automatically exporting
fi

# Fall back to a known-good TERM over SSH when the server lacks the client's terminfo
# (e.g. SSH-ing from Ghostty into a stock Ubuntu Server, which has no xterm-ghostty entry)
#
# Interactive only — `infocmp` is a subprocess, and via BASH_ENV this would run
# for every script too. Nothing is lost: the interactive shell exports the
# corrected TERM, so scripts it launches inherit the fixed value already.
if [[ $- == *i* ]] && [ -n "$SSH_CONNECTION" ] && ! infocmp "$TERM" >/dev/null 2>&1; then
    export TERM=xterm-256color
fi

# Prompt setup — interactive shells only.
# ~/.bashrc exports BASH_ENV pointing at this file, which means every
# non-interactive bash also sources it. Without the $- guard, each script
# invocation paid a starship subprocess plus the eval of its output: measured at
# ~30ms per script vs ~5.6ms without. A prompt is meaningless in a script, so
# there is nothing to lose by skipping it.
if [[ $- == *i* ]] &&
   command -v starship >/dev/null 2>&1 &&
   ! declare -F starship_precmd >/dev/null; then
    eval "$(starship init bash)"
fi

# ls colors
export CLICOLOR=1
export LSCOLORS="GxFxCxDxBxegedabagaced"

# alias commands

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lasc='ls -lahSr'
alias ldesc='ls -lahS'

if [ -n "$DOTFILES" ]; then
    alias clone="$DOTFILES/scripts/configure-repo.sh"
    alias rebase="$DOTFILES/scripts/rebase.sh"
    alias sshrc="$DOTFILES/scripts/sshrc.sh"
fi

# Ceph Docker function
ceph-cli() {
    local version=${1:-v18.2.4}
    docker run -it --rm \
        -v /etc/ceph:/etc/ceph \
        -v /tmp/ceph:/tmp/ceph \
        -v /var/lib/ceph:/var/lib/ceph \
        -v /var/log/ceph:/var/log/ceph \
        quay.io/ceph/ceph:${version} \
        /bin/bash
}

minio-local() {
    docker run -it --rm \
        -v /tmp/minio:/data \
        -p 9000:9000 \
        -p 9001:9001 \
        -e "MINIO_ROOT_USER=$AWS_ACCESS_KEY_ID" \
        -e "MINIO_ROOT_PASSWORD=$AWS_SECRET_ACCESS_KEY" \
        quay.io/minio/minio server /data --console-address ":9001"
}
