# FROM ruby:2.6.5-alpine AS builder
# MAINTAINER Tobias Bohn <info@tobiasbohn.com>

# RUN apk update \
#     && apk add --no-cache --update \
#         nodejs \
#         yarn \
#         postgresql-dev \
#         ruby-dev \
#         build-base \
#         bash \
#         tzdata \
#     && gem install bundler:2.0.2

# ENV APP_PATH=/domicile/
# WORKDIR $APP_PATH

# COPY Gemfile* $APP_PATH



# #################################################################################
# #################################################################################
# FROM builder AS dev_bundle

# ENV APP_PATH=/domicile/
# WORKDIR $APP_PATH

# RUN bundle config --global frozen 1 \
#     && bundle install -j4 --retry 3 \
#     && rm -rf /usr/local/bundle/cache/*.gem \
#     && find /usr/local/bundle/gems/ -name "*.c" -delete \
#     && find /usr/local/bundle/gems/ -name "*.o" -delete

# COPY package.json yarn.lock $APP_PATH
# RUN yarn install

# COPY . $APP_PATH

# RUN rails webpacker:install \
#     && bundle exec rake assets:precompile
# RUN rm -rf node_modules tmp/cache app/assets vendor/assets lib/assets spec



# #################################################################################
# #################################################################################
# FROM ruby:2.6.5-alpine AS development
# LABEL maintainer="Tobias Bohn <info@tobiasbohn.com>"

# RUN apk add --update --no-cache \
#     postgresql-client \
#     chromium \
#     chromium-chromedriver \
#     bash \
#     tzdata

# ENV APP_PATH=/domicile/
# ENV RAILS_LOG_TO_STDOUT true
# ENV RAILS_SERVE_STATIC_FILES true
# ENV EXECJS_RUNTIME Disabled

# WORKDIR $APP_PATH
# EXPOSE 3000

# COPY --from=dev_bundle /usr/local/bundle/ /usr/local/bundle/
# COPY --from=dev_bundle $APP_PATH $APP_PATH

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