#!/bin/bash
set -e

# Generate database credentials based on Dynamic Environment name
export DB_HOST="mf-db"
export DB_PORT="3306"
export DB_USER="back_${GITHUB_REF_NAME//-/_}"
export DB_NAME="${DB_USER}"
export DB_PASS="$(echo "${DB_USER}" | shasum -a 256 | cut -c -12)"

echo "mysql://${DB_USER}:${DB_PASS}@${DB_HOST}:${DB_PORT}/${DB_NAME}"