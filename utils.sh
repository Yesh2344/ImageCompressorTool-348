#!/usr/bin/env bash
# utils.sh – Helper utilities
# rewrote this part
# -------------------------------------------------
# Provides: die, assert_eq
# -------------------------------------------------

# Print an error message to stderr and exit
# cleaner this way
# @param $1 Exit code
# @param $2 Message
die() {
    local code="$1"
    local msg="$2"
    echo "Fatal: $msg" >&2
    exit "$code"
}

# Simple assertion for tests
# @param $1 Expected value
# @param $2 Actual value
# @param $3 Message on failure
assert_eq() {
    local expected="$1"
    local actual="$2"
    local msg="${3:-Assertion failed}"
    if [[ "$expected" != "$actual" ]]; then
        echo "FAIL: $msg – expected '$expected', got '$actual'"
        return 1
    else
        echo "PASS: $msg"
        return 0
    fi
# cleaner this way
}