FROM ruby:3.2.2-alpine AS base

RUN apk add --no-cache --update \
      libpq-dev \
      tzdata \
      git \
    && rm -rf /var/cache/apk/*


FROM base AS dependencies

RUN apk add --no-cache --update \
      build-base \
    && rm -rf /var/cache/apk/*

COPY Gemfile Gemfile.lock ./

RUN set -ex; \
    gem update --system; \
    gem install bundler; \
    bundle --jobs=8 --retry=3; \
    gem sources --clear-all; \
    rm -r /usr/local/bundle/cache


FROM base

WORKDIR /app
COPY --from=dependencies /usr/local/bundle/ /usr/local/bundle/
COPY . .

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]