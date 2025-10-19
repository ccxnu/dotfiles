# Dotfiles Setup

Quick setup for Void Linux with suckless tools and configs.

## Quick Start

```bash
bash init.sh
bash stow.sh
bash build.sh
```

## Scripts

### `init.sh`
Installs all system packages:
- Build tools (gcc, make, git)
- Terminal utilities (zsh, tmux, nvim)
- X11 and window manager dependencies
- Fonts (including Intel One Mono Nerd Font)

### `stow.sh`
Sets up configuration files using stow:
- User configs (nvim, zsh, bash, tmux, scripts, latex)
- System configs (xorg, keyboard layout)
- Creates symlinks from `~/.config` and `/etc`

### `build.sh`
Clones and compiles from source:
- dwm (window manager)
- st (terminal)
- dmenu (launcher)
- slock (screenlocker)
- dwmblocks (status bar)
- pinentry-dmenu (pass)

## Directory Structure

```
.dotfiles/
├── init.sh              # Install packages
├── stow.sh              # Setup configs
├── build.sh             # Build tools
├── README.md            # This file
├── nvim/                # Neovim config
├── bash/                # Bash config
├── latex/               # LaTeX config
├── tmux/                # Tmux config
├── scripts/             # Custom scripts
├── system/              # System configs (/etc, /usr/share)
└── suckless/            # Suckless source code
```

## Usage

**First time:**
```bash
git clone https://github.com/ccxnu/.dotfiles.git
cd ~/.dotfiles
bash init.sh
bash stow.sh
bash build.sh
```

**Update only configs:**
```bash
cd ~/.dotfiles
bash stow.sh
```

**Rebuild suckless tools:**
```bash
cd ~/.dotfiles
bash build.sh
```

## Notes

- All scripts require internet connection
- `sudo` password will be asked for system configs and building
- Source code stored in `~/.dotfiles/suckless/` for version control
- Edit configs directly in dotfiles, changes symlink to system
