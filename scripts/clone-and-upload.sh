#!/usr/bin/env bash
set -Eeuo pipefail
usage() { echo "Usage: $0 <git-repository-url> <s3://bucket/prefix/> [branch]" >&2; }
if [[ $# -lt 2 || $# -gt 3 ]]; then usage; exit 2; fi
REPO_URL="$1"; DESTINATION="$2"; BRANCH="${3:-}"
WORK_DIR="$(mktemp -d)"
trap 'rm -rf "$WORK_DIR"' EXIT
command -v git >/dev/null || { echo "git is required" >&2; exit 127; }
command -v aws >/dev/null || { echo "AWS CLI is required" >&2; exit 127; }
[[ "$DESTINATION" == s3://* ]] || { echo "Destination must start with s3://" >&2; exit 2; }
if [[ -n "$BRANCH" ]]; then
  git clone --depth 1 --branch "$BRANCH" "$REPO_URL" "$WORK_DIR/repo"
else
  git clone --depth 1 "$REPO_URL" "$WORK_DIR/repo"
fi
aws s3 sync "$WORK_DIR/repo/" "$DESTINATION" --exclude ".git/*" --only-show-errors
echo "Upload completed to $DESTINATION"
