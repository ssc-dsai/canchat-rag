ARG SUPABASE_URL
ARG SUPABASE_ANON_KEY

FROM node:22-slim as builder

ENV NEXT_PUBLIC_SUPABASE_URL=${SUPABASE_URL}
ENV NEXT_PUBLIC_SUPABASE_ANON_KEY=${SUPABASE_ANON_KEY}

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build

# FROM node:19-alpine as runner
# WORKDIR /app
# COPY --from=builder /app/package.json .
# COPY --from=builder /app/package-lock.json .
# COPY --from=builder /app/next.config.js ./
# COPY --from=builder /app/public ./public
# COPY --from=builder /app/.next/standalone ./
# COPY --from=builder /app/.next/static ./.next/static
EXPOSE 3000
ENTRYPOINT ["npm", "start"]
