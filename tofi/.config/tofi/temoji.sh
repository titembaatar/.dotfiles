#!/bin/bash

EMOJI_FILE="$HOME/.dotfiles/tofi/.config/tofi/emoji.txt"
EMOJI_FREQ="$HOME/.dotfiles/tofi/.config/tofi/emoji_frequency.txt"
TOFI_CONFIG="$HOME/.dotfiles/tofi/.config/tofi/config"

download_emoji_list() {
    curl -s "https://unicode.org/Public/emoji/latest/emoji-test.txt" | \
    grep -v '^#' | \
    grep "fully-qualified" | \
    sed -E 's/^.+# ([^ ]+) E[0-9.]+ (.+)/\1 \2/' | \
    grep -v "skin tone" > "$EMOJI_FILE"
}

if [ ! -f "$EMOJI_FILE" ]; then
    mkdir -p "$(dirname "$EMOJI_FILE")"
    download_emoji_list
fi

if [ ! -f "$EMOJI_FREQ" ]; then
    touch "$EMOJI_FREQ"
fi

if [ -s "$EMOJI_FREQ" ]; then
    frequent_emojis=$(awk -F'|' '{print $2}' "$EMOJI_FREQ")

    remaining_emojis=$(grep -v -F "$frequent_emojis" "$EMOJI_FILE" || echo "")

    if [ -n "$remaining_emojis" ]; then
        combined_list=$(echo "$frequent_emojis"; echo "$remaining_emojis")
    fi
else
    combined_list=$(cat "$EMOJI_FILE")
fi

selected=$(echo "$combined_list" | tofi --config "$TOFI_CONFIG")

if [ -z "$selected" ]; then
    exit 0
fi

emoji=$(echo "$selected" | awk '{print $1}')

if [ -n "$emoji" ]; then
    if grep -q "$selected" "$EMOJI_FREQ"; then
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
        echo "1|$selected" >> "$EMOJI_FREQ"
    fi

    sort -t'|' -k1,1nr -o "$EMOJI_FREQ" "$EMOJI_FREQ"

    echo -n "$emoji" | wl-copy
fi
