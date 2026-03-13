FROM node:22-alpine

WORKDIR /app

# Install dependencies first for better Docker cache reuse.
COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000

# Make dev server reachable outside container.
ENV HOST=0.0.0.0

CMD ["npm", "start"]
