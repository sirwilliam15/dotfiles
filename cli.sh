
if [[ "$OSTYPE" == "darwin"* ]]; then
    PKG_INSTALLER="brew"
    PKG_LIST="$DOTFILES/macos/brew.json"
else
    PKG_LIST="$DOTFILES/linux/pkg.txt"
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [[ "$ID_LIKE" == *debian* ]] || [[ "$ID" == "debian" ]] || [[ "$ID" == "ubuntu" ]]; then
            PKG_INSTALLER="apt"
        elif [[ "$ID_LIKE" == *fedora* ]] || [[ "$ID" == "fedora" ]]; then
            PKG_INSTALLER="dnf"
        else
            echo "Other Linux. Package Installer not set."
        fi
    else
        echo "/etc/os-release not found. Package Installer not set."
    fi
fi


dotfiles() {
    local action=$1
    local list=$2

    if ! command -v jq &>/dev/null; then
        echo "Error: jq is not installed. Install it first: $PKG_INSTALLER install jq"
        return 1
    fi

    local packages=$(jq -r ".$list | .. | arrays | .[]" "$PKG_LIST")
    
    if [[ "$action" == "install" ]]; then

      echo "--- ⬇︎ Installing packages ---"
      _dotfiles_install "$packages"
        
    fi
}

_dotfiles_install() {
    local packages=$1
    while IFS= read -r pkg; do
        echo ">>>> Installing $pkg"
        "$PKG_INSTALLER" install "$pkg" < /dev/null

        if [[ "$pkg" == "bash" ]]; then
            echo "-----
To change bash to default, run the following:

sudo nano /etc/shells
** Add /opt/homebrew/bin/bash
chsh -s /opt/homebrew/bin/bash
-----"
        elif [[ "$pkg" == "ghostty" ]]; then
            echo "-----
To run bash on ghostty properly run the following command:

echo 'command=/opt/homebrew/bin/bash;exec bash' >> \"$HOME/Library/Application Support/com.mitchellh.ghostty/config\"
-----"
        fi
    done <<< "$packages"

}