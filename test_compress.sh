#!/usr/bin/env bash
# test_compress.sh – Minimal test suite
# -------------------------------------------------
set -euo pipefail
IFS=$'\n\t'

# Load utilities
# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"
# Load configuration (uses test-specific env)
export IMG_DIR="test_images"
export JPEG_QUALITY=75
export PNG_LEVEL=3
export LOG_FILE="test_compress.log.json"
export PARALLEL=false

# Prepare test environment
mkdir -p "$IMG_DIR"
# Create dummy JPEG and PNG files (tiny valid images)
printf '\xFF\xD8\xFF\xE0\x00\x10JFIF\x00\x01\x01\x00\x00\x01\x00\x01\x00\x00\xFF\xDB\x00C\x00' > "$IMG_DIR/sample.jpg"
printf '\x89PNG\r\n\x1A\n\x00\x00\x00\rIHDR\x00\x00\x00\x01\x00\x00\x00\x01\x08\x06\x00\x00\x00' > "$IMG_DIR/sample.png"

# Run the compressor
# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/compress.sh"

process_directory "$IMG_DIR"

# Verify log file was created
if [[ ! -f "$LOG_FILE" ]]; then
    die 1 "Log file not created"
fi

# Simple sanity check: at least two INFO entries should exist
info_count=$(jq -r 'select(.level=="INFO") | .message' "$LOG_FILE" | wc -l)
assert_eq 3 "$info_count" "Expected 3 INFO log entries (start, two compressions, finish)"

# Clean up
rm -rf "$IMG_DIR" "$LOG_FILE"
echo "All tests passed."