#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../../.." && pwd)"
SHARED_SKILL_ROOT="${RELEASE_NOTES_WRITER_SKILL_ROOT:-$HOME/.codex/skills/release-notes-writer}"
CHECK_SCRIPT="$SHARED_SKILL_ROOT/scripts/check_prerequisites.sh"
GATHER_SCRIPT="$SHARED_SKILL_ROOT/scripts/gather_changes.sh"

if [[ ! -f "$CHECK_SCRIPT" ]]; then
  echo "Missing dependency: $CHECK_SCRIPT" >&2
  echo "Set RELEASE_NOTES_WRITER_SKILL_ROOT if release-notes-writer is installed elsewhere." >&2
  exit 1
fi

if [[ ! -f "$GATHER_SCRIPT" ]]; then
  echo "Missing dependency: $GATHER_SCRIPT" >&2
  echo "Set RELEASE_NOTES_WRITER_SKILL_ROOT if release-notes-writer is installed elsewhere." >&2
  exit 1
fi

timestamp="$(date +%Y%m%d-%H%M%S)"
intermediate_dir="$SKILL_ROOT/intermediate"
if ! mkdir -p "$intermediate_dir" 2>/dev/null; then
  tmp_root="${TMPDIR:-/tmp}"
  tmp_root="${tmp_root%/}"
  intermediate_dir="$tmp_root/release-comphy-nvim-theme"
  mkdir -p "$intermediate_dir"
fi

context_file="$intermediate_dir/release-context-${timestamp}.md"

cd "$REPO_ROOT"

set +e
bash "$CHECK_SCRIPT"
check_exit=$?
set -e

if [[ "$check_exit" -ne 0 ]]; then
  if [[ "$check_exit" -eq 1 ]]; then
    echo "Blocking prerequisite issues detected. Resolve them before release." >&2
  else
    echo "Prerequisite check failed with exit code $check_exit. Resolve the issue before release." >&2
  fi
  exit 1
fi

{
  echo "# Release Context"
  echo
  echo "- Generated: $(date -u +"%Y-%m-%d %H:%M:%S UTC")"
  echo "- Repository: $(basename "$REPO_ROOT")"
  echo "- Branch: $(git rev-parse --abbrev-ref HEAD)"
  echo
  bash "$GATHER_SCRIPT" "$@"
} >"$context_file"

suggested_version="$(
  grep -E '^Suggested version:|^Suggested next \(patch\):|^Suggested next \(minor\):|^Suggested next \(major\):' "$context_file" \
    | head -1 \
    | awk '{print $NF}'
)"

echo "Context file: $context_file"
if [[ -n "$suggested_version" ]]; then
  echo "Suggested version: $suggested_version"
fi
echo "Next step: draft release notes, then run publish_release.sh"
