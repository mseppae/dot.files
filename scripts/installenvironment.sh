#!/bin/bash

set -euo pipefail

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Ensure Linuxbrew is on PATH if already installed (for re-runs)
if [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if [[ "$OS" == "Darwin" ]]; then
    if ! command_exists brew; then
        echo "macOS detected. Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add Homebrew to PATH (non-interactive shells)
        if [[ "$(uname -m)" == "arm64" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            eval "$(/usr/local/bin/brew shellenv)"
        fi
        echo "Homebrew installed and PATH updated."
    else
        echo "Homebrew is already installed - upgrading."
        brew upgrade
        echo "Homebrew recipes upgraded."
    fi
elif [[ "$DISTRO" == "bazzite" ]]; then
    if ! command_exists brew; then
        echo "Bazzite detected. Installing Linuxbrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        echo "Linuxbrew installed and PATH updated."
    else
        echo "Linuxbrew is already installed - upgrading."
        brew upgrade
        echo "Homebrew recipes upgraded."
    fi
else
    echo "Not on macOS or Bazzite ($OS detected). Skipping Homebrew installation."
fi

BREW_APPS=("zsh" "vivid" "starship" "zoxide" "rg" "bob")

if [[ "$DISTRO" != "bazzite" ]]; then
    BREW_APPS+=("wezterm")
fi

# Ruby build dependencies (needed by mise/ruby-build)
if [[ "$DISTRO" == "bazzite" ]]; then
    BREW_APPS+=("openssl" "readline" "libyaml" "libffi")
fi

if command_exists brew; then
    for app in "${BREW_APPS[@]}"; do
        if ! command_exists "$app"; then
            echo "Installing $app via Homebrew..."
            brew install "$app"
        else
            echo "$app is already installed."
        fi
    done
else
    echo "Homebrew not available. Skipping installation of: ${BREW_APPS[*]}"
    echo "Install them manually or use alternative package managers (e.g., apt, dnf, pacman)."
fi

# Set zsh as default shell
zsh_path="$(command -v zsh || true)"
if [[ -n "$zsh_path" ]] && [[ "$SHELL" != "$zsh_path" ]]; then
    echo "Setting zsh as default shell..."
    if ! grep -qF "$zsh_path" /etc/shells; then
        echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null
    fi
    if command_exists chsh; then
        chsh -s "$zsh_path"
    else
        sudo usermod --shell "$zsh_path" "$USER"
    fi
    echo "Default shell set to $zsh_path (takes effect on next login)."
fi

# Neovim via bob (nightly build)
if command_exists bob; then
    if ! bob ls 2>/dev/null | grep -q nightly; then
        echo "Installing Neovim nightly via bob..."
        bob install nightly
        bob use nightly
    else
        echo "Neovim nightly is already installed - upgrading."
        bob update nightly
    fi
fi

# Install mise (works on macOS and Linux via Homebrew or direct install)
if ! command_exists mise; then
    if command_exists brew; then
        echo "Installing mise via Homebrew..."
        brew install mise
    else
        echo "Installing mise via official script..."
        curl https://mise.jdx.dev/install.sh | sh
    fi
    mise install
    echo "Mise installed."
else
    echo "Mise is already installed - upgrading tools."
    mise upgrade
    echo "Mise tools upgraded."
fi

# Activate mise so tool binaries (node, npm, etc.) are on PATH
if command_exists mise; then
    eval "$(mise activate bash)"
fi

# Claude Code (native installer with auto-updates)
if ! command_exists claude; then
    echo "Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | sh
else
    echo "Claude Code is already installed."
fi
