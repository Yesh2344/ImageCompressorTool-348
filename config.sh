#!/usr/bin/env bash
# config.sh – Configuration loader
# -------------------------------------------------
# Provides: load_config
# -------------------------------------------------
# Sources: .env, $HOME/.image_compressor.conf, image_compressor.conf

# Load .env if present
if [[ -f .env ]]; then
    # shellcheck disable=SC1091
    set -a
    source .env
    set +a
fi

# Load user config if present
if [[ -f "${HOME}/.image_compressor.conf" ]]; then
    # shellcheck disable=SC1091
    source "${HOME}/.image_compressor.conf"
fi

# Load project config (must exist)
if [[ -f image_compressor.conf ]]; then
    # shellcheck disable=SC1091
    source image_compressor.conf
else
    echo "Fatal: project configuration file 'image_compressor.conf' not found."
    exit 1
fi

# Export variables for subshells
export IMG_DIR JPEG_QUALITY PNG_LEVEL PARALLEL LOG_FILE