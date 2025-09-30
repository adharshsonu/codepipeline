# Use Ruby 2.6.7
FROM ruby:2.6.7

# Fix Buster repository issues and install dependencies
RUN sed -i 's|deb.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    sed -i '/security.debian.org/d' /etc/apt/sources.list && \
    apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install specific Bundler version
RUN gem install bundler:2.2.21

# Create app directory
WORKDIR /var/app

# Copy Gemfiles first for caching
COPY Gemfile Gemfile.lock ./

# Bundle install
RUN bundle install --jobs 4 --retry 3

# Copy application code
COPY . .

# Precompile Rails assets for production
RUN bundle exec rake assets:precompile

# Precompile assets with dummy secret key
RUN SECRET_KEY_BASE=dummy RAILS_ENV=production bundle exec rails assets:precompile

# Copy entrypoint script
COPY docker/app/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

# Environment variables
ENV RAILS_ENV=production \
    RACK_ENV=production \
    PORT=3000

EXPOSE 3000

ENTRYPOINT ["entrypoint.sh"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]