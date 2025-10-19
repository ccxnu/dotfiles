#!/bin/bash
set -e

## Suckless
SUCKLESS_DIR="$HOME/.dotfiles/suckless"

if [ ! -d "$SUCKLESS_DIR" ]; then
  echo "Error: $SUCKLESS_DIR not found"
  exit 1
fi

echo "Building suckless tools..."

# List of tools to build
TOOLS="dwm st dmenu dwmblocks slock pinentry-dmenu"

for tool in $TOOLS; do
  TOOL_DIR="$SUCKLESS_DIR/$tool"

  if [ -d "$TOOL_DIR" ]; then
    echo "Building $tool..."
    cd "$TOOL_DIR"

    if sudo make clean install; then
      echo "✓ $tool installed"
    else
      echo "✗ Failed to build $tool"
    fi
  else
    echo "⊘ $tool directory not found, skipping"
  fi
done

echo "Suckless build complete"
