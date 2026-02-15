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
SHARED_SKILL_ROOT="${RELEASE_NOTES_WRITER_SKILL_ROOT:-$HOME/.codex/skills/release-notes-writer}"
CREATE_SCRIPT="$SHARED_SKILL_ROOT/scripts/create_release.sh"

if [[ ! -f "$CREATE_SCRIPT" ]]; then
  echo "Missing dependency: $CREATE_SCRIPT" >&2
  echo "Set RELEASE_NOTES_WRITER_SKILL_ROOT if release-notes-writer is installed elsewhere." >&2
  exit 1
fi

cd "$REPO_ROOT"

notes_file="$notes_file_input"
if [[ ! -f "$notes_file" ]]; then
  notes_file="$REPO_ROOT/$notes_file_input"
fi

if [[ ! -f "$notes_file" ]]; then
  echo "Release notes file not found: $notes_file_input" >&2
  exit 1
fi

bash "$CREATE_SCRIPT" "$version" "$notes_file"
