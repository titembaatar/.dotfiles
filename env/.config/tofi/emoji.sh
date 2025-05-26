#!/usr/bin/env bash
set -e

tofi_dir="$HOME/.dotfiles/env/.config/tofi"
tofi_config="$tofi_dir/config"
emoji_file="$tofi_dir/emoji.txt"
emoji_freq="$tofi_dir/emoji_frequency.txt"

download_emoji_list() {
  curl -s "https://unicode.org/Public/emoji/latest/emoji-test.txt" | \
    grep -v '^#' | \
    grep "fully-qualified" | \
    sed -E 's/^.+# ([^ ]+) E[0-9.]+ (.+)/\1 \2/' | \
    grep -v "skin tone" > $emoji_file
}

if [ ! -f "$emoji_file" ]; then
  touch $emoji_file
  download_emoji_list
fi

if [ ! -f $emoji_freq ]; then
  touch $emoji_freq
fi

if [ -s $emoji_freq ]; then
  frequent_emojis=$(awk -F'|' '{print $2}' $emoji_freq)

  remaining_emojis=$(grep -v -F "$frequent_emojis" $emoji_file || echo)

  if [ -n "$remaining_emojis" ]; then
    combined_list=$(echo "$frequent_emojis"; echo "$remaining_emojis")
  fi
else
  combined_list=$(cat $emoji_file)
fi

selected=$(echo "$combined_list" | tofi --config $tofi_config)

if [ -z "$selected" ]; then
  exit 0
fi

emoji=$(echo "$selected" | awk '{print $1}')

if [ -n "$emoji" ]; then
  if grep -q "$selected" "$emoji_freq"; then
    new_freq_file=$(awk -v selected="$selected" '
      $0 ~ selected {
        split($0, parts, "|")
        count = parts[1] + 1
        print count "|" selected
      }
      $0 !~ selected {
        print $0
      } ' $emoji_freq)

    echo "$new_freq_file" > "$emoji_freq"
  else
    echo "1|$selected" >> "$emoji_freq"
  fi

  sort -t'|' -k1,1nr -o "$emoji_freq" "$emoji_freq"
  echo -n "$emoji" | wl-copy
fi
