#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Name of your CLI application
APP_NAME="mag"

# Determine install location
if [ -w "/usr/local/bin" ]; then
    INSTALL_DIR="/usr/local/bin"
else
    INSTALL_DIR="$HOME/bin"
    mkdir -p "$INSTALL_DIR"
    
    # Add to PATH if not already there
    if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
        echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.zshrc"
        echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bash_profile"
    fi
fi

echo "Building $APP_NAME..."

# Build the program
go build -o "$APP_NAME"

echo "Installing $APP_NAME to $INSTALL_DIR"

# Move the binary
mv "$APP_NAME" "$INSTALL_DIR/"

echo "$APP_NAME has been installed to $INSTALL_DIR"
echo "You may need to restart your terminal or run 'source ~/.zshrc' (for Zsh) or 'source ~/.bash_profile' (for Bash) for changes to take effect."