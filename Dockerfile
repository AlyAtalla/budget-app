# syntax=docker/dockerfile:1

ARG RUBY_VERSION=3.2.2
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

WORKDIR /rails

# Production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test"

# Build stage
FROM base as build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libvips pkg-config libpq-dev

COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

COPY . .

# Precompile bootsnap and assets
RUN bundle exec bootsnap precompile app/ lib/
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

# Fix binfiles for Linux
RUN chmod +x bin/* && sed -i "s/\r$//g" bin/*

# Final stage
FROM base

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libsqlite3-0 libvips libpq5 && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Run as non-root
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER rails:rails

# Entrypoint and CMD
ENTRYPOINT ["/rails/bin/docker-entrypoint"]
CMD ["sh", "-c", "bundle exec rails server -b 0.0.0.0 -p ${PORT:-3000}"]
