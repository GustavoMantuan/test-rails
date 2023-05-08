# syntax=docker/dockerfile:1

ARG RUBY_VERSION=3.2.2

FROM ruby:${RUBY_VERSION}-slim
WORKDIR /test-rails
# OS Level Dependencies
RUN --mount=type=cache,target=/var/cache/apt \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  --mount=type=tmpfs,target=/var/log \
  rm -f /etc/apt/apt.conf.d/docker-clean; \
  echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache; \
  apt-get update -qq \
  && apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    less \
    git \
    libpq-dev \
    postgresql-client \
    libvips \
    curl

COPY Gemfile /test-rails/Gemfile
COPY Gemfile.lock /test-rails/Gemfile.lock

RUN gem update --system && gem install rails bundler
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
