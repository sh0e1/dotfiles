#!/bin/bash

# Get notification information from Claude Code
input=$(cat)

# Extract message and cwd from JSON
message=$(echo "$input" | jq -r '.message // empty' 2>/dev/null)
cwd=$(echo "$input" | jq -r '.cwd // empty' 2>/dev/null)

# If jq fails, use entire input as message
if [ -z "$message" ]; then
    message="$input"
fi

# If cwd exists, add directory name to message
if [ -n "$cwd" ]; then
    dir_name=$(basename "$cwd")
    message="$dir_name: $message"
fi

if [[ "$input" == *"permission"* ]]; then
    # When tool usage permission is required
    terminal-notifier -title "Claude Code" -message "$message" -sound default -activate "org.alacritty"
elif [[ "$input" == *"waiting"* ]]; then
    # When waiting for input
    terminal-notifier -title "Claude Code" -message "$message" -sound Glass -activate "org.alacritty"
else
    # Other notifications
    terminal-notifier -title "Claude Code" -message "$message" -sound default -activate "org.alacritty"
fi
