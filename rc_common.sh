
# Source .env file if it exists
if [[ -f "$HOME/.env" ]]; then
    set -a  # automatically export all variables
    source "$HOME/.env"
    set +a  # stop automatically exporting
fi

eval "$(starship init bash)"

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