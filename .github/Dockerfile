FROM node:18.11

# Setup app user
RUN groupadd web && \
    useradd -g web -m web

# Setup workdir
WORKDIR /app
ENV NODE_PATH="./src"
ENV PATH /app/node_modules/.bin:$PATH

# Install app dependencies
COPY package.json ./
RUN npm install --legacy-peer-deps

# Add source code
COPY ./index.js ./tsconfig.json ./ormconfig.json ./nestconfig.json      ./
COPY ./prisma           prisma
COPY ./public           public
COPY ./src              src

# Build application
RUN npm run prestart:prod

# Setup runtime
RUN chown -R web:web /app
EXPOSE 3000
USER web
ENTRYPOINT ["npm", "run", "start:prod"]