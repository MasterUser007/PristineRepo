#!/bin/bash
# Usage: ./publish_to_github.sh <your_github_username>

set -e

REPO_NAME="ExoSuite"
USER=$1

if [ -z "$USER" ]; then
  echo "Usage: $0 <your_github_username>"
  exit 1
fi

echo "Initializing Git repo..."
git init
git remote add origin https://github.com/$USER/$REPO_NAME.git
git checkout -b main
git add .
git commit -m "Initial commit: ExoSuite full parity and SDLC compliant"
git push -u origin main

echo "Tagging release..."
git tag -a v1.0.0 -m 'Initial full release'
git push origin v1.0.0

echo "GitHub setup complete. Enable Pages in Settings > Pages using main/docs/"