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

# Install mise (works on macOS and Linux via Homebrew or direct install)
if ! command_exists mise; then
    if command_exists brew; then
        echo "Installing mise via Homebrew..."
        brew install mise
    else
        echo "Installing mise via official script..."
        curl https://mise.jdx.dev/install.sh | sh
    fi
    echo "Mise installed."
else
    echo "Mise is already installed - upgrading tools."
    mise upgrade
    echo "Mise tools upgraded."
fi

BREW_APPS=("vivid" "starship" "zoxide" "rg")

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
