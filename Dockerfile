# 1️⃣ Build stage
FROM node:20-alpine AS builder

WORKDIR /app/frontend

# Copiamos SOLO el frontend
COPY frontend/package*.json ./
RUN npm install

COPY frontend .
RUN npm run build


# 2️⃣ Runtime stage
FROM node:20-alpine AS runner

WORKDIR /app
ENV NODE_ENV=production

COPY --from=builder /app/frontend/.next ./.next
COPY --from=builder /app/frontend/public ./public
COPY --from=builder /app/frontend/package.json ./package.json
COPY --from=builder /app/frontend/node_modules ./node_modules
COPY --from=builder /app/frontend/next.config.* ./

EXPOSE 3000
CMD ["npm", "start"]
