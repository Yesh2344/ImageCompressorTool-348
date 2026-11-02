#!/usr/bin/env bash
# logger.sh – Structured JSON logging utilities
# -------------------------------------------------
# Provides: log_event
# -------------------------------------------------
# Dependencies: jq

# @param $1   Log level (INFO, WARN, ERROR)
# @param $2   Human‑readable message
# @param $3   (optional) Additional JSON payload (must be a valid JSON object)
log_event() {
    local level="$1"
    local message="$2"
    local payload="${3:-{}}"
    local timestamp
    timestamp="$(date --utc +"%Y-%m-%dT%H:%M:%SZ")"

    # Build the base JSON object
    local log_entry
    log_entry=$(jq -n \
        --arg ts "$timestamp" \
        --arg lvl "$level" \
        --arg msg "$message" \
        '$payload | .timestamp=$ts | .level=$lvl | .message=$msg')

    # Append to the log file defined in configuration
    echo "$log_entry" >> "${LOG_FILE:-compress.log.json}"
}