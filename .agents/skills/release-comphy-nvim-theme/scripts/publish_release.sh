#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <version> <notes-file>" >&2
  echo "Example: $0 v1.0.0 .agents/skills/release-comphy-nvim-theme/intermediate/release-notes-v1.0.0.md" >&2
  exit 1
fi

version="$1"
notes_file_input="$2"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../../.." && pwd)"
ORIGINAL_PWD="$(pwd)"
SHARED_SKILL_ROOT="${RELEASE_NOTES_WRITER_SKILL_ROOT:-$HOME/.codex/skills/release-notes-writer}"
CREATE_SCRIPT="$SHARED_SKILL_ROOT/scripts/create_release.sh"

if [[ ! -f "$CREATE_SCRIPT" ]]; then
  echo "Missing dependency: $CREATE_SCRIPT" >&2
  echo "Set RELEASE_NOTES_WRITER_SKILL_ROOT if release-notes-writer is installed elsewhere." >&2
  exit 1
fi

resolve_abs_path() {
  local input_path="$1"
  if command -v realpath >/dev/null 2>&1; then
    realpath "$input_path" 2>/dev/null && return 0
  fi
  if command -v readlink >/dev/null 2>&1; then
    readlink -f "$input_path" 2>/dev/null && return 0
  fi
  (
    cd "$(dirname "$input_path")" 2>/dev/null || exit 1
    printf '%s/%s\n' "$(pwd)" "$(basename "$input_path")"
  )
}

if [[ "$notes_file_input" = /* ]]; then
  notes_candidate="$notes_file_input"
elif [[ -f "$ORIGINAL_PWD/$notes_file_input" ]]; then
  notes_candidate="$ORIGINAL_PWD/$notes_file_input"
else
  notes_candidate="$REPO_ROOT/$notes_file_input"
fi

notes_file="$(resolve_abs_path "$notes_candidate" 2>/dev/null || printf '%s' "$notes_candidate")"

cd "$REPO_ROOT"

if [[ ! -f "$notes_file" ]]; then
  echo "Release notes file not found: $notes_file_input" >&2
  exit 1
fi

bash "$CREATE_SCRIPT" "$version" "$notes_file"
