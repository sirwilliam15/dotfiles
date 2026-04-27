set -euo pipefail

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

# Detect platform
if [[ "$OSTYPE" == "darwin"* ]]; then
    platform="macos"
elif [[ "$OSTYPE" == "linux"* ]]; then
    platform="linux"
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi

# --- Shared setup ---

# Starship prompt config
mkdir -p "$HOME/.config"
link_config "$dir/theme/starship.toml" "$HOME/.config/starship.toml"

# Ghostty terminal config
mkdir -p "$HOME/.config/ghostty"
link_config "$dir/ghostty" "$HOME/.config/ghostty/config"

# Bashrc — append source line (only if not already present)
bashrc_source="source \"\$DOTFILES/$platform/.bashrc\""
if ! grep -qF "$bashrc_source" "$HOME/.bashrc" 2>/dev/null; then
    echo "Adding source to $HOME/.bashrc"
    echo "export DOTFILES=\"$dir\"" >> "$HOME/.bashrc"
    echo "$bashrc_source" >> "$HOME/.bashrc"
else
    echo ".bashrc already configured, skipping"
fi

# macOS login shells read .bash_profile, not .bashrc — ensure it sources .bashrc
if [[ "$platform" == "macos" ]]; then
    if ! grep -qF 'source "$HOME/.bashrc"' "$HOME/.bash_profile" 2>/dev/null; then
        echo "Adding .bashrc source to $HOME/.bash_profile"
        echo '[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"' >> "$HOME/.bash_profile"
    else
        echo ".bash_profile already sources .bashrc, skipping"
    fi
fi

# VS Code themes (VS Code, VSCodium)
theme_root="$dir/theme/vscode"
if [ -d "$theme_root" ] && command -v jq > /dev/null 2>&1; then
    for ext_dir in "$HOME/.vscode/extensions" "$HOME/.vscode-oss/extensions" "$HOME/.cursor/extensions"; do
        [ -d "$(dirname "$ext_dir")" ] || continue
        editor_name=$(basename "$(dirname "$ext_dir")")
        mkdir -p "$ext_dir"

        for theme_dir in "$theme_root"/*; do
            if [ ! -d "$theme_dir" ] || [ ! -f "$theme_dir/package.json" ] || [ ! -d "$theme_dir/themes" ]; then
                continue
            fi

            theme_name=$(jq -r '.name' "$theme_dir/package.json")
            theme_version=$(jq -r '.version' "$theme_dir/package.json")
            theme_publisher=$(jq -r '.publisher' "$theme_dir/package.json")
            theme_display_name=$(jq -r '.displayName' "$theme_dir/package.json")

            if [ -z "$theme_name" ] || [ "$theme_name" = "null" ] || [ -z "$theme_version" ] || [ "$theme_version" = "null" ]; then
                echo "Skipping invalid VS Code theme manifest in $theme_dir"
                continue
            fi

            theme_ext="$ext_dir/$theme_name-$theme_version"
            mkdir -p "$theme_ext/themes"
            ln -sfn "$theme_dir/package.json" "$theme_ext/package.json"

            for theme_file in "$theme_dir/themes"/*; do
                if [ -f "$theme_file" ]; then
                    ln -sfn "$theme_file" "$theme_ext/themes/$(basename "$theme_file")"
                fi
            done

            # Register in extensions.json so the editor discovers the theme.
            ext_json="$ext_dir/extensions.json"
            if [ -f "$ext_json" ] && [ -n "$theme_publisher" ] && [ "$theme_publisher" != "null" ]; then
                theme_id="$theme_publisher.$theme_name"
                if ! jq -e --arg theme_id "$theme_id" '.[] | select(.identifier.id == $theme_id)' "$ext_json" > /dev/null 2>&1; then
                    jq \
                        --arg theme_id "$theme_id" \
                        --arg theme_version "$theme_version" \
                        --arg theme_ext "$theme_ext" \
                        --arg relative_location "$theme_name-$theme_version" \
                        --argjson installed_timestamp "$(date +%s000)" \
                        '. += [{
                            "identifier": { "id": $theme_id },
                            "version": $theme_version,
                            "location": { "$mid": 1, "path": $theme_ext, "scheme": "file" },
                            "relativeLocation": $relative_location,
                            "metadata": {
                                "installedTimestamp": $installed_timestamp,
                                "pinned": false,
                                "source": "gallery",
                                "targetPlatform": "universal",
                                "updated": false,
                                "private": false,
                                "isPreReleaseVersion": false,
                                "hasPreReleaseVersion": false
                            }
                        }]' "$ext_json" > "$ext_json.tmp" && mv "$ext_json.tmp" "$ext_json"
                    echo "Registered $theme_display_name in $editor_name extensions.json"
                fi
            fi

            echo "Installed $theme_display_name for $editor_name"
        done
    done
elif [ -d "$theme_root" ]; then
    echo "Skipping VS Code theme installation because jq is not available"
fi

# --- macOS-specific setup ---

if [[ "$platform" == "macos" ]]; then
    link_config "$dir/macos/.skhdrc" "$HOME/.skhdrc"

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
