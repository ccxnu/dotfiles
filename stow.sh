#!/bin/bash
set -e

echo "Setting up dotfiles..."

if [ -d "$HOME/.dotfiles" ]; then
  echo "Dotfiles already exist at $HOME/.dotfiles"
else
  echo "Downloading dotfiles..."
  if git clone https://github.com/ccxnu/.dotfiles.git "$HOME/.dotfiles"; then
    echo "Dotfiles downloaded successfully"
  else
    echo "Error: Failed to clone dotfiles repository"
    exit 1
  fi
fi

cd "$HOME/.dotfiles"

# User packages
PACKAGES="bash home nvim tmux scripts"
for pkg in $PACKAGES; do
  if [ -d "$pkg" ]; then
    stow "$pkg"
    echo "Stowed $pkg"
  fi
done
echo "User configs installed"

# System configs (requires password)
if [ -d "$HOME/.dotfiles/system" ]; then
  sudo stow -d "$HOME/.dotfiles" -t / system
  echo "System configs installed"
fi

echo "Setup complete"
