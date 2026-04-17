jayson() {
    local file=""
    local param=""

    # Parse arguments
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            -f|--file) file="$2"; shift ;;
            -p|--param) param="$2"; shift ;;
            *) echo "Unknown parameter: $1"; return 1 ;;
        esac
        shift
    done

    # Validation
    if [[ -z "$file" || -z "$param" ]]; then
        echo "Usage: jayson -f <file.json> -p <parameter>"
        return 1
    fi

    # Execution
    jq -r ".. | .$param? // empty" "$file"
}
