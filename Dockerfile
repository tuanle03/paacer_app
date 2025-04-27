# syntax=docker/dockerfile:1

ARG RUBY_VERSION=3.3.0
FROM ruby:$RUBY_VERSION-slim

# Install system dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    curl \
    git \
    libjemalloc2 \
    libpq-dev \
    libvips \
    redis-tools \
    pkg-config \
    libgmp-dev \
    libssl-dev \
    zlib1g-dev \
    libyaml-dev \
    postgresql-client \
    nodejs \
    yarn \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /rails

# Set bundler environment variables
ENV BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    BUNDLE_PATH=/bundle \
    RAILS_ENV=development

# Copy Gemfile first to leverage Docker cache
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application source code
COPY . .

# Copy and set permissions for entrypoint script
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose Rails server port
EXPOSE 3000

# Precompile assets during image build
RUN bundle exec rails assets:precompile

# Default command
CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
