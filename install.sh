
dir=$(pwd)
mkdir -p "$dir/backup"

backup_file() {
    local file="$1"
    if [ -L "$file" ]; then
        echo "$file is a symlink. Removing."
        rm "$file"
    elif [ -f "$file" ] || [ -d "$file" ]; then
        local timestamp=$(date +%Y%m%d%H%M%S)
        local name=$(basename "$file")
        echo "Backing up $file to $dir/backup/${name}.${timestamp}"
        mv "$file" "$dir/backup/${name}.${timestamp}"
    fi
}

link_config() {
    local src="$1"
    local dest="$2"
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
            echo "$(basename "$dest") already linked, skipping"
            return
        fi
        echo "Found $(basename "$dest")"
        echo "Would you like to overwrite $(basename "$dest")? (y/n)"
        read -r overwrite
        if [[ "$overwrite" == "y" ]]; then
            backup_file "$dest"
            echo "Creating symlink for $(basename "$dest")"
            ln -sfn "$src" "$dest"
            echo "Overwritten $(basename "$dest")"
        else
            echo "Skipping $(basename "$dest")"
        fi
    else
        echo "$(basename "$dest") not found, creating symlink"
        ln -sfn "$src" "$dest"
    fi
}

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Symlink config files
    link_config "$dir/macos/.skhdrc" "$HOME/.skhdrc"

    # Starship prompt config
    mkdir -p "$HOME/.config"
    link_config "$dir/theme/starship.toml" "$HOME/.config/starship.toml"

    # Ghostty terminal config
    mkdir -p "$HOME/.config/ghostty"
    link_config "$dir/ghostty" "$HOME/.config/ghostty/config"

    # Append bashrc source (only if not already present)
    if ! grep -qF 'source "$DOTFILES/macos/.bashrc"' "$HOME/.bashrc" 2>/dev/null; then
        echo "Adding source to $HOME/.bashrc"
        echo "export DOTFILES=$dir" >> "$HOME/.bashrc"
        echo 'source "$DOTFILES/macos/.bashrc"' >> "$HOME/.bashrc"
    else
        echo ".bashrc already configured, skipping"
    fi

    # VS Code theme (VS Code, VSCodium)
    for ext_dir in "$HOME/.vscode/extensions" "$HOME/.vscode-oss/extensions"; do
        editor_name=$(basename "$(dirname "$ext_dir")")
        theme_ext="$ext_dir/everforest-nord-theme-1.0.0"
        mkdir -p "$theme_ext/themes"
        ln -sf "$dir/theme/vscode/everforest-nord-blend-1.0.0/package.json" "$theme_ext/package.json"
        ln -sf "$dir/theme/vscode/everforest-nord-blend-1.0.0/themes/everforest-nord-theme.json" "$theme_ext/themes/everforest-nord-theme.json"
        echo "Installed Everforest Nord theme for $editor_name"
    done

    # Yabai mode selection
    echo "Install yabai mode? [minimal/full/skip]"
    read -r yabai_mode

    case "$yabai_mode" in
        minimal)
            backup_file "$HOME/.yabairc"
            ln -sfn "$dir/macos/.yabairc" "$HOME/.yabairc"
            echo "Installed minimal yabai config"
            ;;
        full)
            backup_file "$HOME/.yabairc"
            ln -sfn "$dir/macos/yabai/yabairc" "$HOME/.yabairc"

            mkdir -p "$HOME/.config"

            backup_file "$HOME/.config/sketchybar"
            ln -sfn "$dir/macos/yabai/sketchybar" "$HOME/.config/sketchybar"
            echo "Linked sketchybar → ~/.config/sketchybar"

            mkdir -p "$HOME/.config/borders"
            backup_file "$HOME/.config/borders/bordersrc"
            ln -sfn "$dir/macos/yabai/bordersrc" "$HOME/.config/borders/bordersrc"
            echo "Linked bordersrc → ~/.config/borders/bordersrc"

            echo "Installed full yabai config"
            ;;
        *)
            echo "Skipping yabai"
            ;;
    esac
fi

echo "Installation complete"
