#!/bin/bash

# Path to emoji list file
EMOJI_FILE="$HOME/.dotfiles/tofi/.config/tofi/emoji.txt"
EMOJI_FREQ="$HOME/.dotfiles/tofi/.config/tofi/emoji_frequency.txt"
TOFI_CONFIG="$HOME/.dotfiles/tofi/.config/tofi/config"

# Function to download a simplified emoji list
download_emoji_list() {
    curl -s "https://unicode.org/Public/emoji/latest/emoji-test.txt" | \
    grep -v '^#' | \
    grep "fully-qualified" | \
    sed -E 's/^.+# ([^ ]+) E[0-9.]+ (.+)/\1 \2/' | \
    grep -v "skin tone" > "$EMOJI_FILE"
}

# Create emoji file if it doesn't exist
if [ ! -f "$EMOJI_FILE" ]; then
    mkdir -p "$(dirname "$EMOJI_FILE")"
    download_emoji_list
fi

# Create frequency file if it doesn't exist
if [ ! -f "$EMOJI_FREQ" ]; then
    touch "$EMOJI_FREQ"
fi

# Combine frequency-sorted emojis and the full emoji list
# Format of frequency file: count|emoji line
if [ -s "$EMOJI_FREQ" ]; then
    # Extract just the emoji entries from the frequency file (without the count)
    frequent_emojis=$(awk -F'|' '{print $2}' "$EMOJI_FREQ")
    
    # Get all emojis that aren't in the frequency file
    remaining_emojis=$(grep -v -F "$frequent_emojis" "$EMOJI_FILE" || echo "")
    
    # Combine the frequent emojis (sorted by count) with remaining emojis
    combined_list=$(awk -F'|' '{print $2}' "$EMOJI_FREQ" | sort -r -t'|' -k1,1n)
    if [ -n "$remaining_emojis" ]; then
        combined_list=$(echo "$combined_list"; echo "$remaining_emojis")
    fi
else
    combined_list=$(cat "$EMOJI_FILE")
fi

# Use tofi with your existing config
selected=$(echo "$combined_list" | tofi --config "$TOFI_CONFIG")

# Exit if nothing was selected
if [ -z "$selected" ]; then
    exit 0
fi

# Extract just the emoji character from the selection
emoji=$(echo "$selected" | awk '{print $1}')

# Update frequency count for the selected emoji
if [ -n "$emoji" ]; then
    # Check if this emoji is already in the frequency file
    if grep -q "$selected" "$EMOJI_FREQ"; then
        # Increment the count for this emoji
        new_freq_file=$(awk -v selected="$selected" '
            $0 ~ selected {
                split($0, parts, "|")
                count = parts[1] + 1
                print count "|" selected
            } 
            $0 !~ selected {
                print $0
            }
        ' "$EMOJI_FREQ")
        echo "$new_freq_file" > "$EMOJI_FREQ"
    else
        # Add this emoji to the frequency file with count 1
        echo "1|$selected" >> "$EMOJI_FREQ"
    fi
    
    # Sort frequency file by count (highest first)
    sort -t'|' -k1,1nr -o "$EMOJI_FREQ" "$EMOJI_FREQ"
    
    # Copy emoji to clipboard
    echo -n "$emoji" | wl-copy
fi
