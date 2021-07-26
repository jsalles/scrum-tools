FROM elixir:1.11-alpine

WORKDIR /app
COPY . .
EXPOSE 3000

RUN apk add --update git nodejs nodejs-npm

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN cd lib/velocity_web/assets && npm ci && npm run build
ENTRYPOINT ["mix", "phx.server"]