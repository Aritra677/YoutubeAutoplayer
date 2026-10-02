#!/bin/bash

# Path to your video list
VIDEO_LIST="/home/ario/video.txt"

# 1. Check if the file exists before starting
if [[ ! -f "$VIDEO_LIST" ]]; then
    echo "Error: $VIDEO_LIST not found."
    exit 1
fi

echo "Starting mpv playlist from $VIDEO_LIST..."

# 2. Read the file line by line
# The 'IFS=' prevents leading/trailing whitespace from being stripped
# The '-r' prevents backslash escapes from being interpreted
while IFS= read -r url || [[ -n "$url" ]]; do
    
    # Skip empty lines or lines starting with # (comments)
    [[ -z "$url" || "$url" =~ ^# ]] && continue

    echo "Now playing: $url"

    # 3. Call mpv
    # mpv automatically uses the configuration found in ~/.config/mpv/mpv.conf
    mpv "$url"

    # The script pauses here until mpv is closed or the video ends.
    echo "Finished playing. Moving to next video..."

done < "$VIDEO_LIST"

echo "All videos played!"
