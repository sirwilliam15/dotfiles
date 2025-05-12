
mkdir -p "$HOME/.dotfiles/backup"

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Loop through specific config files
    for config in ".yabairc" ".skhdrc" ".bashrc"; do
        if [[ -f "$HOME/$config" ]]; then
            echo "Found $config"
            if [[ "$config" == ".bashrc" ]]; then
                echo "Adding source to $HOME/$config"
                echo "source $HOME/.dotfiles/macos/.bashrc" >> "$HOME/$config"
                continue
            fi
            # Add your commands here to handle each config file
            echo "Would you like to overwrite $config? (y/n)"
            read -r overwrite
            if [[ "$overwrite" == "y" ]]; then
                echo "Backing up $HOME/$config to $HOME/.dotfiles/backup/$config"
                mv "$HOME/$config" "$HOME/.dotfiles/backup/$config"
                echo "Creating symlink for $config"
                ln -sf "$HOME/.dotfiles/macos/$config" "$HOME/$config"
                echo "Overwritten $config"
            else
                echo "Skipping $config"
            fi
        else
            echo "$config not found, creating symlink"
            ln -sf "$HOME/.dotfiles/macos/$config" "$HOME/$config"
        fi
    done
fi

echo "Installation complete"
