---
name: release-comphy-nvim-theme
description: Manual release workflow for comphy-theme.nvim that drafts release notes via release-notes-writer, updates CHANGELOG.md and README.md when needed, and publishes a GitHub release by creating and pushing a tag. Use when asked to cut, tag, or publish a comphy-theme.nvim release without CI automation.
---

# Release Comphy Nvim Theme

Run a full manual release for this repository with a confirmation gate before any git write operations.
This skill intentionally performs release work outside CI and reuses the shared `release-notes-writer` scripts.

## Required Dependency

Shared scripts path:
`$HOME/.codex/skills/release-notes-writer/scripts`

If the skill is installed elsewhere, set:
`RELEASE_NOTES_WRITER_SKILL_ROOT=/custom/path/to/release-notes-writer`

## Workflow

### 1) Prepare release context (read-only)

Run:

```bash
bash .agents/skills/release-comphy-nvim-theme/scripts/prepare_release_context.sh [--base-tag <tag>] [--tag-scheme major|minor|patch] [--prefer-patch-level]
```

This runs:
- `check_prerequisites.sh`
- `gather_changes.sh`

It writes output to:
- `.agents/skills/release-comphy-nvim-theme/intermediate/release-context-*.md`
- fallback: `${TMPDIR:-/tmp}/release-comphy-nvim-theme/release-context-*.md`

### 2) Draft release notes

Write notes using this structure:

```markdown
## What's New

[2-3 sentence user-facing summary]

### ✨ Features
- ...

### 🔧 Improvements
- ...

### 🐛 Bug Fixes
- ...

### ⚠️ Breaking Changes
- ...

---
**Full Changelog**: <previous-tag>...<new-tag>
```

Store notes at:
`.agents/skills/release-comphy-nvim-theme/intermediate/release-notes-<version>.md`

### 3) Update docs if needed

- `CHANGELOG.md`: add `## [<version>] - YYYY-MM-DD` and move relevant items from `## [Unreleased]`.
- `README.md`: edit only for user-facing changes, setup changes, or requirement changes introduced in this release.
- Keep edits factual and minimal.

### 4) Confirmation gate (required)

Before any git operations, present:
- Proposed version
- Final release notes draft
- Files to change (`CHANGELOG.md`, `README.md`, or other docs)

Require explicit user approval before staging, committing, tagging, pushing, or publishing.

### 5) Publish release manually

If docs were updated and the user explicitly asks to include them in release:

```bash
git add CHANGELOG.md README.md
git commit -m "Prepare <version> release"
```

Then publish:

```bash
bash .agents/skills/release-comphy-nvim-theme/scripts/publish_release.sh <version> <notes-file>
```

This creates an annotated tag, pushes it to `origin`, and creates a GitHub release.

### 6) Output required after publish

Report:
- Released version tag
- GitHub release URL
- Whether docs were updated
- Any follow-up action if publish partially failed
