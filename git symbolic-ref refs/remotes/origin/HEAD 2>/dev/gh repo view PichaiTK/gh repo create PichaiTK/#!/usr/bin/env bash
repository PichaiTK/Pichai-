#!/usr/bin/env bash
# add_license.sh
# Usage:
#   ./add_license.sh [--base <branch>] [--force]
# Example:
#   ./add_license.sh --base main
set -euo pipefail

BASE_SPECIFIED=""
FORCE=0

# parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --base)
      BASE_SPECIFIED="$2"
      shift 2
      ;;
    --force)
      FORCE=1
      shift
      ;;
    -*)
      echo "Unknown option: $1"
      exit 1
      ;;
    *)
      shift
      ;;
  esac
done

# ensure git repo
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: not inside a git repository"
  exit 1
fi

# check remote origin URL
ORIGIN_URL=$(git remote get-url origin 2>/dev/null || echo "")
if [[ -z "$ORIGIN_URL" ]]; then
  echo "Error: remote 'origin' not defined. Set origin to your GitHub repo first."
  exit 1
fi

# expected owner/repo
EXPECTED="PichaiTK/myapp-multiplatform"
if [[ "$ORIGIN_URL" != *"$EXPECTED"* ]]; then
  echo "Warning: origin URL does not appear to point to ${EXPECTED}"
  echo " origin: $ORIGIN_URL"
  read -p "Continue anyway? (y/N) " yn
  case "$yn" in [Yy]*) ;; *) echo "Aborted."; exit 1 ;; esac
fi

# detect default branch (unless provided)
DEFAULT_BRANCH="${BASE_SPECIFIED}"
if [[ -z "$DEFAULT_BRANCH" ]]; then
  DEFAULT_BRANCH=$(git remote show origin 2>/dev/null | sed -n 's/.*HEAD branch: //p' || true)
  if [[ -z "$DEFAULT_BRANCH" ]]; then
    # fallback common names
    if git show-ref --verify --quiet refs/heads/main; then DEFAULT_BRANCH="main"; fi
    if [[ -z "$DEFAULT_BRANCH" && $(git show-ref --verify --quiet refs/heads/master; echo $?) -eq 0 ]]; then DEFAULT_BRANCH="master"; fi
    if [[ -z "$DEFAULT_BRANCH" ]]; then
      echo "Unable to detect default branch. Please pass --base <branch> (e.g. --base main)"
      exit 1
    fi
  fi
fi

echo "Using base branch: $DEFAULT_BRANCH"

# update from remote
git fetch origin "$DEFAULT_BRANCH" --quiet || true

TIMESTAMP=$(date +%s)
BRANCH="add/license-mit-${TIMESTAMP}"
git checkout -b "$BRANCH"

if [[ -f LICENSE && "$FORCE" -ne 1 ]]; then
  echo "LICENSE already exists. Use --force to overwrite or handle manually."
  exit 1
fi

cat > LICENSE <<'EOF'
MIT License

Copyright (c) 2025 PichaiTK

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

git add LICENSE
git commit -m "chore: add MIT license (Copyright 2025 PichaiTK)"
git push -u origin "$BRANCH"

echo "Pushed branch $BRANCH -> origin/$BRANCH"

if command -v gh >/dev/null 2>&1; then
  echo "Creating PR via gh CLI..."
  gh pr create --title "chore: add MIT license" --body "Add MIT License (Copyright 2025 PichaiTK)." --base "$DEFAULT_BRANCH" --head "$BRANCH"
  echo "PR creation attempted via gh."
else
  echo "gh CLI not found. Create a PR at:"
  echo "https://github.com/${EXPECTED}/pull/new/${BRANCH}?base=${DEFAULT_BRANCH}"
fi

exit 0
