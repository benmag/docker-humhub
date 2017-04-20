FROM codemasonhq/php:base

# Set new document root
ENV DOCUMENT_ROOT="/app" \
  GITHUB_TOKEN="replaceme"

# Install additional PHP dependency required 
RUN apk add --update php7-exif git \
  && rm -rf /var/cache/apk/*

# Install global dependency required for HumHub
RUN composer global require "fxp/composer-asset-plugin:~1.1.1"

# Add project files
ONBUILD COPY . /app

# Install dependencies
ONBUILD RUN composer config --global github-oauth.github.com $GITHUB_TOKEN 
ONBUILD RUN composer install 