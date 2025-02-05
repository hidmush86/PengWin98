#!/bin/bash

# Create output directory if it doesn't exist
mkdir -p output

# Loop through all .wav and .mp3 files in the current directory
for file in *.wav *.mp3; do
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

        # Convert file to .oga format with specified sample rate and bitrate using ffmpeg
        echo "Converting '$file' to '$output_file' with 48kHz sample rate and 320kbps VBR..."
        ffmpeg -i "$file" -c:a libvorbis -q:a 9 -ar 48000 "$output_file"
    fi
done

echo "Conversion complete. Check the 'output' directory."
