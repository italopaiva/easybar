FROM ruby:2.4.1-alpine

RUN mkdir /app

COPY . /app

COPY Gemfile /app

WORKDIR /app

RUN apk update && apk add --no-cache make build-base postgresql-dev postgresql gmp-dev

RUN bundle install

RUN mv ./setup.sh /usr/bin/setup

CMD setup

EXPOSE 3000
