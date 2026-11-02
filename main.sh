#!/usr/bin/env bash
# main.sh – Entry point for ImageCompressorTool
# -------------------------------------------------
# Usage: ./main.sh
# -------------------------------------------------
set -euo pipefail
IFS=$'\n\t'

# Load configuration
# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/config.sh"

# Load core functions
# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/compress.sh"

# Initialize log file
: > "${LOG_FILE:-compress.log.json}"
log_event "INFO" "ImageCompressorTool started" "$(jq -n --arg dir "$IMG_DIR" '{root_dir:$dir}')"

# Process the target directory
process_directory "$IMG_DIR"

log_event "INFO" "ImageCompressorTool finished"
echo "Compression completed. Log written to $LOG_FILE"