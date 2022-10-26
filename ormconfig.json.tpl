{
  "type": "mysql",
  "host": "${DB_HOST}",
  "port": ${DB_PORT},
  "username": "${DB_USER}",
  "password": "${DB_PASS}",
  "database": "${DB_NAME}",
  "entities": ["src/**/**.entity{.ts,.js}"],
  "synchronize": true
}