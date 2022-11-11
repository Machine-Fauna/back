version: "3.7"
services:
  mf-back-${GITHUB_REF_NAME}:
    build:
      context: .
      dockerfile: .github/Dockerfile
    container_name: mf-back-${GITHUB_REF_NAME}
    restart: unless-stopped
    expose:
      - 3000
    healthcheck:
      test: "curl --fail localhost:3000/api/tags > /dev/null"
      interval: 5s
      timeout: 30s
      retries: 10
    networks:
      - mf
    labels:
      - traefik.http.routers.mf-back-${GITHUB_REF_NAME}.rule=Host(`back-${GITHUB_REF_NAME}.mf`)


networks:
  mf:
    external: true
