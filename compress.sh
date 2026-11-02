#!/usr/bin/env bash
# compress.sh – Core compression logic
# -------------------------------------------------
# Provides: compress_image, process_directory, run_parallel
# -------------------------------------------------
# Dependencies: jpegoptim, optipng, logger.sh, config.sh

# Load shared utilities
# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/logger.sh"

# @param $1 Path to the image file
compress_image() {
    local file="$1"
    local ext
    ext="${file##*.}"
    ext="${ext,,}"  # lower‑case

    case "$ext" in
        jpg|jpeg)
            jpegoptim --max="${JPEG_QUALITY}" --strip-all --quiet "$file"
            if [[ $? -eq 0 ]]; then
                log_event "INFO" "Compressed JPEG: $file"
            else
                log_event "ERROR" "Failed JPEG compression: $file"
            fi
            ;;
        png)
            optipng -o"${PNG_LEVEL}" -quiet "$file"
            if [[ $? -eq 0 ]]; then
                log_event "INFO" "Compressed PNG: $file"
            else
                log_event "ERROR" "Failed PNG compression: $file"
            fi
            ;;
        *)
            log_event "WARN" "Unsupported file type: $file"
            ;;
    esac
}

# @param $1 Directory to process
process_directory() {
    local dir="$1"
    if [[ ! -d "$dir" ]]; then
        log_event "ERROR" "Directory does not exist: $dir"
        return 1
    fi

    # Find supported images
    mapfile -t files < <(find "$dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \))

    if [[ ${#files[@]} -eq 0 ]]; then
        log_event "INFO" "No images found in $dir"
        return 0
    fi

    if [[ "$PARALLEL" == "true" ]]; then
        run_parallel compress_image "${files[@]}"
    else
        for img in "${files[@]}"; do
            compress_image "$img"
        done
    fi
}

# @param $1 Function name to execute in parallel
# @param $@ Arguments to pass to the function (list of files)
run_parallel() {
    local func="$1"
    shift
    if ! command -v parallel >/dev/null 2>&1; then
        log_event "WARN" "GNU parallel not found; falling back to sequential execution"
        for arg in "$@"; do
            "$func" "$arg"
        done
        return
    fi

    export -f "$func"
    export JPEG_QUALITY PNG_LEVEL LOG_FILE
    parallel -j "$(nproc)" "$func" ::: "$@"
}