FROM ruby:3.2.2-alpine

WORKDIR /app

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

# Install dependencies:
RUN set -ex; \
    apk add --no-cache \
        libpq \
        libcurl \
        tzdata \
        libxml2 \
        libxslt \
        postgresql-client \
        gcompat \
        git \
    ; \
    apk add --no-cache --virtual .build-deps \
        g++ \
        gcc \
        make \
        musl-dev \
        curl-dev \
        libxml2-dev \
        libxslt-dev \
        postgresql-dev \
    ;

RUN set -ex; \
    gem update --system; \
    gem install bundler; \
    bundle config build.nokogiri --use-system-libraries; \
    bundle --jobs=8 --retry=3; \
    gem sources --clear-all; \
    rm -r /usr/local/bundle/cache; \
    apk del .build-deps

RUN set -ex; \
    cp /usr/share/zoneinfo/America/New_York /etc/localtime; \
    echo "Pacific Time (US & Canada)" > /etc/timezone

COPY . .

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
