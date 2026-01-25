#!/bin/bash
set -e

## Installs packages and configs

# Update system
echo "Updating system..."
sudo xbps-install -Su

# Packages, tools and apps
# base-devel            # Compiler, build tools, headers (essential for building)
# git                   # Version control
# make                  # Build automation tool (for suckless, Makefiles)
# pkg-config            # Find libraries/headers during compilation
# stow                  # Symlink manager (for dotfiles)
# neovim                # Text editor
# tmux                  # Terminal multiplexer (sessions, panes, windows)
# fzf                   # Fuzzy finder (command-line search)
# fd                    # Fast alternative to `find` command
# ripgrep               # Fast grep alternative (search files)
# unzip                 # Extract .zip files
# wget                  # Download files from internet
# keyd                  # Keyboard remapper daemon to swap locks-esc-ctrl
# xclip                 # Clipboard manager - copy/paste between X11 and terminal
# xsct                  # Change screen temperature
# xss-lock              # Lock screen when X11 screensaver activates
# xcompmgr              # Compositing manager - enables transparency, shadows, effects
# xbanish               # Hide mouse cursor when typing (reappears on mouse move)
# xorg-minimal          # Minimal X11 server (display system)
# libX11-devel          # X11 libraries + headers (needed to compile dwm, st)
# libXinerama-devel     # Multi-monitor support library (for dwm multimonitor patch)
# libXft-devel          # Font rendering library (for st, dwm fonts)
# freetype-devel        # Truetype font engine (used by Xft for rendering fonts)
# font-ibm-plex-ttf     # IBM Plex font (professional, monospace variant for terminals)
echo "Installing tools and app..."
sudo xbps-install -Sy \
  base-devel \
  git \
  make \
  pkg-config \
  stow \
  neovim \
  tmux \
  fzf \
  fd \
  ripgrep \
  unzip \
  wget \
  keyd \
  xclip \
  xsct \
  xss-lock \
  xbanish \
  xorg-minimal \
  libX11-devel \
  libXinerama-devel \
  libXft-devel \
  freetype-devel \
  font-ibm-plex-ttf

# Nerd Font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
echo "Downloading Nerd Font..."
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/IntelOneMono.zip
unzip -q IntelOneMono.zip -d IntelOneMono
rm IntelOneMono.zip
fc-cache -fv
cd -
