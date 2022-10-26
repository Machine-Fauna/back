FROM node:18.11

# Setup workdir
WORKDIR /app
ENV NODE_PATH="./src"
ENV PATH /app/node_modules/.bin:$PATH

# Install app dependencies
COPY package.json ./
RUN npm install --dev --legacy-peer-deps

# Setup runtime
EXPOSE 3000
ENTRYPOINT ["npm", "run", "start"]