
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

    local packages=$(jq -r ".$list | [.. | arrays | .[]] .[]" "$PKG_LIST")
    
    if [[ "$action" == "install" ]]; then

      echo "--- ⬇︎ Installing packages ---"
      _dotfiles_install "$packages"
        
    fi
}

_dotfiles_install() {
    local packages=$1
    while IFS= read -r pkg; do
        echo ">>>> Installing $pkg"
        "$PKG_INSTALLER" install "$pkg"
    done <<< "$packages"

}