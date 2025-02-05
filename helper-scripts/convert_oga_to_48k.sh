#!/bin/bash

# Create output directory if it doesn't exist
mkdir -p output

# Loop through all .oga files in the current directory
for file in *.oga; do
    # Check if there are matching files before processing
    if [[ -e "$file" ]]; then
        # Get the base filename without extension
        base_name=$(basename "$file" | sed 's/\.[^.]*$//')
        output_file="output/${base_name}.oga"

        # Check if the .oga file already exists
        if [[ -e "$output_file" ]]; then
            echo "Skipping '$file' - '$output_file' already exists."
            continue
        fi

        # Convert file to 48kHz sample rate using ffmpeg
        echo "Converting '$file' to 48kHz sample rate..."
        ffmpeg -i "$file" -ar 48000 -c:a libvorbis -q:a 9 "$output_file"
    fi
done

echo "Conversion complete. Check the 'output' directory."
