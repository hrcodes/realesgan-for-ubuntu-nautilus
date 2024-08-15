#!/bin/bash

# Create a directory for the RealESRGAN repository and clone portable script
REPO_DIR="$HOME/RealESRGAN-repo"
echo "Creating '$REPO_DIR'..."
mkdir -p "$REPO_DIR"
sleep 0.5

echo "Copying RealESRGAN files..."
cp -r "realesrgan-ncnn-vulkan-20220424-ubuntu"/* "$REPO_DIR"
sleep 0.5

# Make the repository directory and its contents executable
echo "Setting executable permissions..."
chmod +x "$REPO_DIR"
chmod +x "$REPO_DIR"/*
chmod +x "$REPO_DIR"/realesrgan-ncnn-vulkan
sleep 0.5

# Copy the RealESRGAN script to the Nautilus scripts directory
echo "Adding RealESRGAN to Nautilus scripts..."
cp "RealESRGAN" "$HOME/.local/share/nautilus/scripts/RealESRGAN"
sleep 0.5

# Make the script executable
chmod +x "$HOME/.local/share/nautilus/scripts/RealESRGAN"

# Notify the user that the installation was successful
echo " "
echo "RealESRGAN installer complete!!"
echo " "
echo "You can now right-click on an image in Nautilus and select Scripts -> 'RealESRGAN' to upscale images."