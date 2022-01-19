FROM ruby:3.0.2-alpine AS builder

WORKDIR /app/

RUN apk add --update --no-cache  \
  build-base \
  curl-dev \
  nodejs \
  postgresql-dev \
  tzdata \
  git \
  yarn

COPY package*.json yarn.lock Gemfile* ./
RUN yarn install --check-files --frozen-lockfile &&\
      bundle config --global frozen 1 && bundle install

### BUILD STEP DONE ###

FROM ruby:3.0.2-alpine

ARG RAILS_ROOT=/app/
WORKDIR $RAILS_ROOT

RUN set -eux; \
	addgroup -S app; \
	adduser -S -D -G app -H -h $RAILS_ROOT -s /bin/sh app; \
	chown -R app:app $RAILS_ROOT

RUN apk add --update --no-cache \
  bash\
  nodejs \
  postgresql-client \
  tzdata \
  yarn \
  && rm -rf /var/cache/apk/*

COPY --from=builder $RAILS_ROOT $RAILS_ROOT
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/

COPY . .

RUN chown -R app:app $RAILS_ROOT

EXPOSE 3000

ENTRYPOINT ["bin/docker-entrypoint.sh"]