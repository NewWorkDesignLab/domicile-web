# FROM ruby:2.6.5-alpine AS builder
# MAINTAINER Tobias Bohn <info@tobiasbohn.com>

# ENV APP_PATH=/domicile/
# WORKDIR $APP_PATH
# EXPOSE 3000

# RUN apk update \
#     && apk add --no-cache --update \
#         nodejs \
#         yarn \
#         postgresql-client \
#         ruby-dev \
#         build-base \
#         bash \
#     && gem install bundler:2.0.2

# COPY Gemfile* $APP_PATH
# RUN bundle install
# COPY . $APP_PATH

# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]

# CMD ["rails", "server", "-b", "0.0.0.0"]

FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client
RUN mkdir /domicile
WORKDIR /domicile
COPY Gemfile /domicile/Gemfile
COPY Gemfile.lock /domicile/Gemfile.lock
RUN bundle install
COPY . /domicile

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]