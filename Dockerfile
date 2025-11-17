FROM ruby:3.3-alpine

WORKDIR /app

RUN apk add --no-cache \
  build-base \
  postgresql15-dev \
  tzdata \
  git \
  yaml-dev \
  pkgconfig

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . . 

ENV RAILS_ENV=production

RUN bundle exec rails assets:precompile || true

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]