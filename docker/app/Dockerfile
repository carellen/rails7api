FROM ruby:2.7.5-alpine

RUN apk update && apk add build-base postgresql-dev postgresql-client tzdata --no-cache

ENV RAILS_ROOT /var/www/rails7api
RUN mkdir  -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

ENV RAILS_ENV='production'
ENV RACK_ENV='production'

COPY Gemfile Gemfile.lock ./
RUN bundle install --full-index

COPY . .

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
