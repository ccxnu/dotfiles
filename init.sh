#!/bin/bash
set -e

## Installs packages and configs

# Update system
echo "Updating system..."
sudo xbps-install -Su

# Packages, tools and apps
echo "Installing tools and app..."
sudo xbps-install -Sy \
  base-devel \
  git \
  gcc \
  make \
  pkg-config \
  stow \
  tmux \
  neovim \
  fzf \
  fd \
  ripgrep \
  unzip \
  wget

# X11 and window manager (suckless)
echo "Installing X11..."
sudo xbps-install -Sy \
  xorg-minimal \
  libX11-devel \
  libXinerama-devel \
  libXft-devel \
  freetype-devel

# Fonts
echo "Installing fonts..."
sudo xbps-install -Sy \
  font-ibm-plex-ttf # For general use

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
echo "Downloading Nerd Font..."
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/IntelOneMono.zip
unzip -q IntelOneMono.zip -d IntelOneMono
rm IntelOneMono.zip
fc-cache -fv
cd -

# Stow dotfiles
echo "Setting up dotfiles..."
if [ -d "$HOME/dotfiles" ]; then
  cd "$HOME/dotfiles"
  stow */
  echo "User configs installed"

  # System configs (requires password)
  if [ -d "$HOME/dotfiles/xorg" ]; then
    sudo stow -d "$HOME/dotfiles" -t / xorg
    echo "System configs installed"
  fi
else
  echo "Warning: ~/dotfiles not found"
fi

# Build suckless tools (optional)
read -p "Build suckless tools? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  if [ -d "$HOME/suckless" ]; then
    for dir in "$HOME/suckless"/*; do
      if [ -f "$dir/Makefile" ]; then
        echo "Building $(basename $dir)..."
        cd "$dir"
        sudo make clean install
      fi
    done
    echo "Suckless tools built"
  else
    echo "Warning: ~/suckless directory not found"
  fi
fi

echo "=== Setup Complete ==="
echo "Next steps:"
echo "1. Clone suckless repos to ~/suckless if needed"
echo "2. Restart X session or reboot"
