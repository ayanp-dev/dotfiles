#!/usr/bin/env bash

# Read the JSON payload piped in by Antigravity CLI
input=$(cat)

# Extract the data directly from the JSON fields
MODEL=$(echo "$input" | jq -r '.model.display_name // "Unknown Model"')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

# Render the exact text format from your picture
echo "$MODEL | ctx: ${PCT}% used"