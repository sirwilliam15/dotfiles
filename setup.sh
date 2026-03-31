#!/bin/sh
# Bootstrap script for dotfiles
# Usage: curl -fsSL https://raw.githubusercontent.com/sirwilliam15/dotfiles/HEAD/setup.sh | sh
#
# Installs prerequisites and clones the dotfiles repo.

set -e

DOTFILES_REPO="https://github.com/sirwilliam15/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

info() { printf '  [ .. ] %s\n' "$1"; }
ok()   { printf '  [ OK ] %s\n' "$1"; }
fail() { printf '  [FAIL] %s\n' "$1"; exit 1; }

# --- macOS ---
if [ "$(uname -s)" = "Darwin" ]; then

    # Xcode Command Line Tools
    if xcode-select -p >/dev/null 2>&1; then
        ok "Xcode CLI tools already installed"
    else
        info "Installing Xcode Command Line Tools …"
        xcode-select --install
        # Wait for the installer to finish
        until xcode-select -p >/dev/null 2>&1; do
            sleep 5
        done
        ok "Xcode CLI tools installed"
    fi

    # Homebrew
    if command -v brew >/dev/null 2>&1; then
        ok "Homebrew already installed"
    else
        info "Installing Homebrew …"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add brew to PATH for the rest of this script
        if [ -f /opt/homebrew/bin/brew ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [ -f /usr/local/bin/brew ]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi
        ok "Homebrew installed"
    fi

    # Git (macOS ships git via Xcode CLT, but ensure it's available)
    if command -v git >/dev/null 2>&1; then
        ok "git already installed"
    else
        info "Installing git via Homebrew …"
        brew install git
        ok "git installed"
    fi

    # Bash (Homebrew version)
    BREW_BASH="/opt/homebrew/bin/bash"
    if [ -x "$BREW_BASH" ]; then
        ok "Homebrew bash already installed"
    else
        info "Installing bash and bash-completion@2 …"
        brew install bash bash-completion@2
        ok "bash and bash-completion@2 installed"
    fi

    # Set Homebrew bash as default shell
    if [ -x "$BREW_BASH" ]; then
        if ! grep -qF "$BREW_BASH" /etc/shells; then
            info "Adding $BREW_BASH to /etc/shells (requires sudo) …"
            echo "$BREW_BASH" | sudo tee -a /etc/shells >/dev/null
            ok "Added $BREW_BASH to /etc/shells"
        fi

        if [ "$SHELL" = "$BREW_BASH" ]; then
            ok "Default shell is already $BREW_BASH"
        else
            info "Changing default shell to $BREW_BASH (requires sudo) …"
            sudo chsh -s "$BREW_BASH" "$USER"
            ok "Default shell changed to $BREW_BASH"
        fi
    fi

# --- Linux ---
elif [ "$(uname -s)" = "Linux" ]; then

    if [ -f /etc/os-release ]; then
        . /etc/os-release
    fi

    # Git
    if command -v git >/dev/null 2>&1; then
        ok "git already installed"
    else
        info "Installing git …"
        if [ "$ID" = "ubuntu" ] || [ "$ID" = "debian" ] || echo "$ID_LIKE" | grep -q debian; then
            sudo apt-get update && sudo apt-get install -y git
        elif [ "$ID" = "fedora" ] || echo "$ID_LIKE" | grep -q fedora; then
            sudo dnf install -y git
        else
            fail "Unsupported Linux distro — install git manually and re-run"
        fi
        ok "git installed"
    fi
fi

# --- Clone dotfiles ---
if [ -d "$DOTFILES_DIR" ]; then
    ok "Dotfiles repo already exists at $DOTFILES_DIR"
else
    info "Cloning dotfiles into $DOTFILES_DIR …"
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
    ok "Dotfiles cloned to $DOTFILES_DIR"
fi

echo ""
echo "Setup complete. Next steps:"
echo "  cd $DOTFILES_DIR"
echo "  bash install.sh"
