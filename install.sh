#!/bin/bash

# Define the repository URL
REPO_URL="https://github.com/user7210unix/White-DWM"

# Clone the repository
git clone "$REPO_URL" ~/White-DWM

# Change to the repository directory
cd ~/White-DWM || { echo "Failed to enter White-DWM directory"; exit 1; }

# Install dmenu, slstatus, and dwm
for dir in dmenu slstatus dwm; do
  if [ -d "$dir" ]; then
    echo "Installing $dir..."
    cd "$dir" || { echo "Failed to enter $dir directory"; exit 1; }
    sudo make clean install || { echo "Failed to install $dir"; exit 1; }
    cd ..
  else
    echo "$dir directory not found, skipping."
  fi
done

# Copy .Xresources and .xinitrc to the home directory
if [ -f .Xresources ]; then
  echo "Copying .Xresources to home directory..."
  cp .Xresources ~/
else
  echo ".Xresources not found, skipping."
fi

if [ -f .xinitrc ]; then
  echo "Copying .xinitrc to home directory..."
  cp .xinitrc ~/
else
  echo ".xinitrc not found, skipping."
fi

# Copy backgrounds folder to the home directory
if [ -d backgrounds ]; then
  echo "Copying backgrounds folder to home directory..."
  cp -r backgrounds ~/
else
  echo "backgrounds folder not found, skipping."
fi

# Copy config folder to the .config home directory
if [ -d config ]; then
  echo "Copying config folder to ~/.config..."
  mkdir -p ~/.config
  cp -r config/* ~/.config/
else
  echo "config folder not found, skipping."
fi

# Download and install JetBrains Nerd Font
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip"
FONT_DIR=~/.fonts

# Create fonts directory if it doesn't exist
mkdir -p "$FONT_DIR"

echo "Downloading JetBrains Nerd Font..."
wget -q "$FONT_URL" -O "$FONT_DIR/JetBrainsMono.zip" || { echo "Failed to download JetBrainsMono.zip"; exit 1; }

# Unzip the font into the fonts directory
unzip -o "$FONT_DIR/JetBrainsMono.zip" -d "$FONT_DIR" || { echo "Failed to unzip JetBrainsMono.zip"; exit 1; }
rm "$FONT_DIR/JetBrainsMono.zip" # Clean up zip file

# Update font cache
echo "Updating font cache..."
fc-cache -vf || { echo "Failed to update font cache"; exit 1; }

# Completion message
echo "Installation complete."
