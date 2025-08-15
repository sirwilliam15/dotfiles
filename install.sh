
dir=$(pwd)
mkdir -p "$dir/backup"

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Loop through specific config files
    for config in ".yabairc" ".skhdrc" ".bashrc"; do
        if [[ "$config" == ".bashrc" ]]; then
            echo "Adding source to $HOME/$config"
            echo "export DOTFILES=$dir" >> "$HOME/$config"
            echo 'source "$DOTFILES/macos/.bashrc"' >> "$HOME/$config"
            continue
        fi
        if [[ -f "$HOME/$config" ]]; then
            echo "Found $config"
            # Add your commands here to handle each config file
            echo "Would you like to overwrite $config? (y/n)"
            read -r overwrite
            if [[ "$overwrite" == "y" ]]; then
                if [ -L "$HOME/$config" ]; then
                    echo "$config is a symlink. Removing."
                    rm "$HOME/$config"
                else
                    echo "Backing up $HOME/$config to $dir/backup/$config"
                    mv "$HOME/$config" "$dir/backup/$config"
                fi
                echo "Creating symlink for $config"
                ln -sf "$dir/macos/$config" "$HOME/$config"
                echo "Overwritten $config"
            else
                echo "Skipping $config"
            fi
        else
            echo "$config not found, creating symlink"
            ln -sf "$dir/macos/$config" "$HOME/$config"
        fi
    done

fi

echo "Installation complete"
