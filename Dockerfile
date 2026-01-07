# 1️⃣ Build stage
FROM node:20-alpine AS builder

WORKDIR /app

# Copiamos package files
COPY frontend/package*.json ./frontend/
WORKDIR /app/frontend
RUN npm install

# Copiamos el resto del frontend
COPY frontend .

# Build Next.js
RUN npm run build


# 2️⃣ Production stage
FROM node:18-alpine AS runner

WORKDIR /app
ENV NODE_ENV=production

# Copiamos solo lo necesario
COPY --from=builder /app/frontend/.next ./.next
COPY --from=builder /app/frontend/public ./public
COPY --from=builder /app/frontend/package.json ./package.json
COPY --from=builder /app/frontend/node_modules ./node_modules

EXPOSE 3000

CMD ["npm", "start"]
