#!/usr/bin/env bash

set -euo pipefail                            # Treat unset variables as an error

SHA256SUM_DIR=$(jq -r '.sha256sum_dir')
SHA256SUM=$(
  find ${SHA256SUM_DIR} -type f -exec sha256sum {} \; \
  | sort -k2 \
)

jq -n --arg sha256sum "${SHA256SUM}" '{"sha256sum":$sha256sum}'
