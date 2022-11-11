#!/bin/bash
set -euo pipefail

# Generate database credentials based on Dynamic Environment name
export DB_HOST="127.0.0.1"
export DB_PORT="3306"
export DB_USER="back_${GITHUB_REF_NAME//-/_}"
export DB_NAME="${DB_USER}"
export DB_PASS="$(echo "${DB_USER}" | shasum -a 256 | cut -c -12)"

echo "mysql://${DB_USER}:${DB_PASS}@${DB_HOST}:${DB_PORT}/${DB_NAME}"

# Do the database setup
if [[ $(MYSQL_PWD=${DB_PASS} mysql -u"${DB_USER}" -h"${DB_HOST}" "${DB_NAME}" -e "SHOW TABLES;") ]];then
  echo "Setup MySQL:" "DB exists and connection check passed."
else
  echo "Setup MySQL:" "DB does not exist or connection check failed."
  echo "Setup MySQL:" "Clean old resources if exist."
  MYSQL_PWD=${DB_ROOT_PASS} mysql -u"${DB_ROOT_USER}" -h"${DB_HOST}" -e \
    "
    DROP DATABASE IF EXISTS ${DB_NAME};
    DROP USER IF EXISTS ${DB_USER};
    "
  echo "Setup MySQL DB:" "Creating new MySQL database and user."
  MYSQL_PWD=${DB_ROOT_PASS} mysql -u"${DB_ROOT_USER}" -h"${DB_HOST}" -e \
    "
    CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
    CREATE DATABASE ${DB_NAME};
    GRANT ALL ON ${DB_NAME}.* TO '${DB_USER}'@'%';
    FLUSH PRIVILEGES;
    "
  echo "Setup MySQL DB:" "Database created."
fi