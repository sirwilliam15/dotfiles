
dir=$(pwd)
mkdir -p "$dir/backup"

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Loop through specific config files
    for config in ".yabairc" ".skhdrc" ".bashrc"; do
        if [[ -f "$HOME/$config" ]]; then
            echo "Found $config"
            if [[ "$config" == ".bashrc" ]]; then
                echo "Adding source to $HOME/$config"
                echo "export DOTFILES=$dir" >> "$HOME/$config"
                echo 'source "$DOTFILES/macos/.bashrc"' >> "$HOME/$config"
                continue
            fi
            # Add your commands here to handle each config file
            echo "Would you like to overwrite $config? (y/n)"
            read -r overwrite
            if [[ "$overwrite" == "y" ]]; then
                echo "Backing up $HOME/$config to $dir/backup/$config"
                mv "$HOME/$config" "$dir/backup/$config"
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

    if [[ -f "/opt/homebrew/bin/oh-my-posh" ]]; then
        echo "Oh My Posh already installed."
    else
        echo "Oh My Posh not installed, installing..."
        brew install jandedobbeleer/oh-my-posh/oh-my-posh
    fi
    

fi

echo "Installation complete"
