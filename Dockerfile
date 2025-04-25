# syntax=docker/dockerfile:1

ARG RUBY_VERSION=3.3.0
FROM ruby:$RUBY_VERSION-slim

# Cài thư viện hệ thống và chuẩn bị môi trường
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
    postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Tạo thư mục ứng dụng
WORKDIR /rails

# Thiết lập biến môi trường cho bundler
ENV BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    BUNDLE_PATH=/bundle \
    RAILS_ENV=development

# Copy Gemfile trước để cache được bước bundle install
COPY Gemfile Gemfile.lock ./

# Cài đặt gem
RUN bundle install

# Copy toàn bộ mã nguồn ứng dụng
COPY . .

# Copy entrypoint script vào image
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose cổng Rails
EXPOSE 3000

# Lệnh mặc định khi chạy container (có thể ghi đè trong docker-compose.yml)
CMD ["bash"]
