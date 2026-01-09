# Use Ruby 2.6.7 (Debian Buster – EOL, so archive repo is needed)
FROM ruby:2.6.7

# Fix Debian archive repos, install dependencies + CA certificates
RUN sed -i 's|deb.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    sed -i '/security.debian.org/d' /etc/apt/sources.list && \
    apt-get update -qq && apt-get install -y \
    ca-certificates \
    build-essential \
    libpq-dev \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install specific Bundler version required by this app
RUN gem install bundler -v 2.2.21

# Create app directory
WORKDIR /var/app

# Copy Gemfiles first (better Docker cache usage)
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install --jobs 4 --retry 3

# Copy application code
COPY . .

# Precompile Rails assets (single correct command)
RUN SECRET_KEY_BASE=dummy RAILS_ENV=production bundle exec rails assets:precompile

# Copy entrypoint script
COPY docker/app/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

# Environment variables
ENV RAILS_ENV=production \
    RACK_ENV=production \
    PORT=3000

# Expose application port
EXPOSE 3000

# Start application
ENTRYPOINT ["entrypoint.sh"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
