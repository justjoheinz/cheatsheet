#!/bin/bash
# Cheatsheet review helper script
# Usage: ./review-cheatsheet.sh <name> [--approve|commit-message]

set -e

NAME="$1"
APPROVE_FLAG="$2"

if [ -z "$NAME" ]; then
  echo "Usage: $0 <cheatsheet-name> [--approve|commit-message]"
  exit 1
fi

echo "Compiling $NAME.typ..."
typst compile "$NAME.typ"

echo "Creating swamp model..."
if ! swamp model get "$NAME" >/dev/null 2>&1; then
  swamp model create @justjoheinz/cheatsheet "$NAME" --global-arg repoDir=.
else
  echo "Model $NAME already exists, skipping creation"
fi

echo "Updating README..."
swamp model method run cheatsheet update-readme

# Check if we should commit
if [ "$APPROVE_FLAG" = "--approve" ]; then
  # Auto-generate commit message
  COMMIT_MSG="Update cheatsheet $NAME"
elif [ -n "$APPROVE_FLAG" ]; then
  # Use provided commit message
  COMMIT_MSG="$APPROVE_FLAG"
else
  # No approval, show review instructions
  COMMIT_MSG=""
fi

if [ -n "$COMMIT_MSG" ]; then
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "✅ Committing changes..."
  git add "$NAME.typ" "$NAME.pdf" README.md models/@justjoheinz/cheatsheet/
  git commit -m "$COMMIT_MSG"
  echo ""
  echo "✅ Committed: $COMMIT_MSG"
  echo ""
  git log -1 --stat
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
else
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "📄 Cheatsheet '$NAME' compiled successfully!"
  echo ""
  echo "Review:"
  echo "  • PDF: open $NAME.pdf"
  echo "  • Changes: git diff README.md"
  echo ""
  echo "Next steps:"
  echo ""
  echo "  ✅ APPROVE & COMMIT (auto-generated message):"
  echo "     ./review-cheatsheet.sh $NAME --approve"
  echo ""
  echo "  ✅ APPROVE & COMMIT (custom message):"
  echo "     ./review-cheatsheet.sh $NAME \"Your custom message\""
  echo ""
  echo "  🔄 REQUEST CHANGES:"
  echo "     Edit $NAME.typ, then re-run:"
  echo "     ./review-cheatsheet.sh $NAME"
  echo ""
  echo "  ❌ DISCARD:"
  echo "     git restore $NAME.typ $NAME.pdf README.md"
  echo "     swamp model delete $NAME"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
fi
