#!/bin/bash

set -euo pipefail

REPO_NAME="$1"

if [ -z "$REPO_NAME" ]; then
  echo "Usage: $0 <ecr-repository-name>"
  exit 1
fi

IMAGE_COUNT=$(aws ecr describe-images \
  --repository-name "$REPO_NAME" \
  --query 'length(imageDetails)' \
  --output text)

VERSION=$(($IMAGE_COUNT + 1))
echo "v$VERSION"