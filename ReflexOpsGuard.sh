#!/bin/bash
# ReflexOpsGuard.sh — Validate dispatchable workflow before firing

REPO="MasterUser007/PristineRepo"
WF="reflex_trigger.yml"
echo "🔎 Checking for registered workflow: $WF"

LIST=$(gh workflow list --repo "$REPO")
if echo "$LIST" | grep -q "$WF"; then
  echo "✅ Found: $WF — dispatching..."
  gh workflow run "$WF" --repo "$REPO"
else
  echo "❌ $WF not registered — aborting"
  exit 1
fi
