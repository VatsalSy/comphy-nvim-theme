#!/usr/bin/env bash
# CoMPhy Gruvbox Theme - Shell Script Demo
# Demonstrates various shell scripting syntax elements

# Shell options and error handling
set -euo pipefail
IFS=$'\n\t'

# Color definitions using ANSI escape codes
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[0;33m'
readonly BLUE='\033[0;34m'
readonly RESET='\033[0m'

# Global variables
readonly SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly VERSION="1.0.0"

# Configuration variables
THEME_NAME="${THEME_NAME:-comphy-theme}"
DEBUG_MODE="${DEBUG:-false}"

# Function: Display usage information
usage() {
    cat << EOF
Usage: ${SCRIPT_NAME} [OPTIONS] COMMAND [ARGS]

A demonstration script for the CoMPhy Gruvbox theme.

COMMANDS:
    install     Install the theme
    test        Run theme tests

OPTIONS:
    -h, --help              Show this help message
    -v, --version           Show version information
    -d, --debug             Enable debug mode
EOF
}

# Function: Logging utilities
log_info() {
    echo -e "${BLUE}[INFO]${RESET} $*" >&2
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${RESET} $*" >&2
}

log_error() {
    echo -e "${RED}[ERROR]${RESET} $*" >&2
}

# Function: Check dependencies
check_dependencies() {
    local deps=("git" "curl" "jq")
    local missing=()

    for cmd in "${deps[@]}"; do
        if ! command -v "${cmd}" >/dev/null 2>&1; then
            missing+=("${cmd}")
        fi
    done

    if [[ ${#missing[@]} -gt 0 ]]; then
        log_error "Missing required dependencies: ${missing[*]}"
        exit 1
    fi
}

# Function: Install theme
install_theme() {
    log_info "Installing ${THEME_NAME} theme..."

    local theme_dir="${HOME}/.themes/${THEME_NAME}"
    mkdir -p "${theme_dir}"

    log_success "Theme installed successfully!"
}

# Function: Test theme
test_theme() {
    log_info "Running theme tests..."

    # Array manipulation
    local -a test_files=(
        "test_syntax.sh"
        "test_colors.sh"
    )

    # Associative array
    declare -A test_results

    for test_file in "${test_files[@]}"; do
        if [[ -f "${SCRIPT_DIR}/${test_file}" ]]; then
            if bash "${SCRIPT_DIR}/${test_file}"; then
                test_results["${test_file}"]="PASS"
            else
                test_results["${test_file}"]="FAIL"
            fi
        fi
    done

    # Display results
    echo "Test Results:"
    for test in "${!test_results[@]}"; do
        if [[ "${test_results[$test]}" == "PASS" ]]; then
            echo -e "  ${GREEN}✓${RESET} ${test}"
        else
            echo -e "  ${RED}✗${RESET} ${test}"
        fi
    done
}

# Main function
main() {
    case "${1:-}" in
        -h|--help)
            usage
            ;;
        -v|--version)
            echo "${SCRIPT_NAME} version ${VERSION}"
            ;;
        install)
            check_dependencies
            install_theme
            ;;
        test)
            test_theme
            ;;
        *)
            usage
            ;;
    esac
}

# Script execution guard
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
