#!/bin/bash
set -euo pipefail

# Generate database credentials based on Dynamic Environment name
export DB_HOST="127.0.0.1"
export DB_PORT="3306"
export DB_USER="back_${GITHUB_REF_NAME//-/_}"
export DB_NAME="${DB_USER}"
export DB_PASS="$(echo "${DB_USER}" | shasum -a 256 | cut -c -12)"
