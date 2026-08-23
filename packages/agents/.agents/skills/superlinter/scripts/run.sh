#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 @<path_file_or_directory>" >&2
  exit 64
fi

input_path=${1#@}

if [[ ! -e $input_path ]]; then
  echo "superlinter: path not found: $input_path" >&2
  exit 66
fi

if ! command -v docker >/dev/null 2>&1; then
  echo "superlinter: docker is required" >&2
  exit 69
fi

image=${SUPERLINTER_IMAGE:-ghcr.io/super-linter/super-linter:latest}
platform=${SUPERLINTER_PLATFORM:-linux/amd64}

if [[ -d $input_path ]]; then
  source_path=$(cd -- "$input_path" && pwd -P)
  target_path=/tmp/lint
elif [[ -f $input_path ]]; then
  file_dir=$(cd -- "$(dirname -- "$input_path")" && pwd -P)
  file_name=$(basename -- "$input_path")
  source_path="$file_dir/$file_name"
  target_path="/tmp/lint/$file_name"
else
  echo "superlinter: path must be a regular file or directory: $input_path" >&2
  exit 65
fi

echo "superlinter: detecting linters in $source_path"

exec docker run \
  --rm \
  --platform "$platform" \
  -e RUN_LOCAL=true \
  -e USE_FIND_ALGORITHM=true \
  --mount "type=bind,source=$source_path,target=$target_path,readonly" \
  "$image"
