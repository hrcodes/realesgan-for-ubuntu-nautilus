#!/bin/bash

# Create a directory for the RealESRGAN repository
REPO_DIR="$HOME/RealESRGAN-repo"
mkdir -p "$REPO_DIR"

# Clone the RealESRGAN repository
git clone https://github.com/xinntao/Real-ESRGAN.git "$REPO_DIR/Real-ESRGAN"

# Create the Nautilus script
cat << EOF > "$HOME/.local/share/nautilus/scripts/RealESRGAN"
#!/bin/bash

# Get the selected file path
file_path=$(echo "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS" | head -n1)

# Check if a file was selected
if [ -z "$file_path" ]; then
  echo "No file selected"
  exit 1
fi

# Check if the file exists
if [ ! -f "$file_path" ]; then
  echo "File not found: $file_path"
  exit 1
fi

# Get the file name and extension
file_name=$(basename "$file_path")
file_ext="${file_name##*.}"

# Construct the output file name
output_file="new_$file_name"

# Construct the RealESRGAN command
command="$REPO_DIR/Real-ESRGAN/realesrgan-ncnn-vulkan/realesrgan-ncnn-vulkan -i \"$file_path\" -o \"./$output_file\"; exit"

# Open a terminal and run the RealESRGAN command
gnome-terminal -- bash -c "$command"

# Check if the output file was created
if [ ! -f ".$output_file" ]; then
  echo "Error: output file not found: $output_file"
  exit 1
fi

# Notify the user that the operation was successful
echo "RealESRGAN completed successfully. Output saved as $output_file"

# Open the output file in the default image viewer
xdg-open ".$output_file"
EOF

# Make the Nautilus script executable
chmod +x "$HOME/.local/share/nautilus/scripts/RealESRGAN"

# Create a symbolic link to the Nautilus script
ln -s "$HOME/.local/share/nautilus/scripts/RealESRGAN" "$HOME/.local/share/nautilus/scripts/realesrgan"

# Notify the user that the installation was successful
echo "RealESRGAN installer complete. You can now use the 'RealESRGAN' script in Nautilus to upscale images."
