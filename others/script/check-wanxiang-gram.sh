#!/bin/sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd -P)
model=${RIME_GRAM_FILE:-$repo_dir/wanxiang-lts-zh-hans.gram}

configured=false
for config in "$repo_dir"/*.custom.yaml; do
  if [ -f "$config" ] && grep -Fq 'language: wanxiang-lts-zh-hans' "$config"; then
    configured=true
    break
  fi
done

if [ "$configured" = false ]; then
  exit 0
fi

if [ ! -s "$model" ]; then
  printf '%s\n' \
    'Rime: wanxiang-lts-zh-hans.gram is missing or empty.' \
    'Download: https://github.com/amzxyz/rime-wanxiang-data/releases/download/LTS/wanxiang-lts-zh-hans.gram' \
    "Save to: $repo_dir/wanxiang-lts-zh-hans.gram, then redeploy Rime." >&2
fi
