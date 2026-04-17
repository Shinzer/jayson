#!/bin/bash

# Initialize variables
file=""
param_string=""

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -f|--file) file="$2"; shift ;;
        -p|--param) param_string="$2"; shift ;;
        *) echo "Error: Unknown parameter: $1"; exit 1 ;;
    esac
    shift
done

# Validation: Check if required arguments are provided
if [[ -z "$file" || -z "$param_string" ]]; then
    echo "Usage: ./jayson.sh -f <file.json> -p <param1,param2,...>"
    exit 1
fi

# Validation: Check if file exists
if [[ ! -f "$file" ]]; then
    echo "Error: File '$file' not found."
    exit 1
fi

# Validation: Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: 'jq' is not installed. Please install it to use this script."
    exit 1
fi

# Execution
# 1. Split the comma-separated string into a jq array
# 2. Recursively find objects that contain the first requested key
# 3. Extract all requested keys into an array and format as TSV
jq -r --arg p "$param_string" '
    ($p | split(",")) as $keys |
    .. | objects | 
    select(has($keys[0])) | 
    [ .[$keys[]] ] | 
    @tsv
' "$file"
