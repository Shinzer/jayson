#!/bin/bash

# Initialize variables
file=""
param_string=""
output_file=""

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -f|--file) file="$2"; shift ;;
        -p|--param) param_string="$2"; shift ;;
        -o|--output) output_file="$2"; shift ;;
        *) echo "Error: Unknown parameter: $1"; exit 1 ;;
    esac
    shift
done

# Validation
if [[ -z "$file" || -z "$param_string" ]]; then
    echo "Usage: jayson -f <file.json> -p <param1,param2> [-o output.txt]"
    exit 1
fi

if [[ ! -f "$file" ]]; then
    echo "Error: File '$file' not found."
    exit 1
fi

# 1. Generate TSV (Tab Separated) for spreadsheet pasting
data=$(jq -r --arg p "$param_string" '
    ($p | split(",")) as $keys |
    $keys, 
    (.. | objects | select(has($keys[0])) | [.[$keys[]]]) | 
    @tsv
' "$file")

# 2. Output to file if -o is provided
if [[ -n "$output_file" ]]; then
    echo "$data" > "$output_file"
    echo "[+] Data saved to $output_file"
fi

# 3. Print to stdout
echo "$data"

# 4. Clipboard Logic for Linux (Kali)
# We use -selection clipboard so it goes to the Ctrl+V buffer, not just middle-click
if command -v xclip &> /dev/null; then
    echo "$data" | xclip -selection clipboard
    echo -e "\n[✔] Copied to clipboard via xclip."
elif command -v xsel &> /dev/null; then
    echo "$data" | xsel --clipboard --input
    echo -e "\n[✔] Copied to clipboard via xsel."
else
    echo -e "\n[!] ERROR: No clipboard tool found. Run: sudo apt install xclip -y"
fi
