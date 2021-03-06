ARG RUBY_VERSION=2.7.0
FROM ruby:$RUBY_VERSION
ARG DEBIAN_FRONTEND=noninteractive

ARG NODE_VERSION=11
RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs \
  yarn \
  locales \
  git \
  netcat \
  vim \
  sudo

ARG USER_ID
ENV USER_ID $USER_ID
ARG GROUP_ID
ENV GROUP_ID $GROUP_ID
ARG USER=ruby
ENV USER $USER

RUN groupadd -g $GROUP_ID $USER && \
  useradd -u $USER_ID -g $USER -m $USER && \
  usermod -p "*" $USER && \
  usermod -aG sudo $USER && \
  echo "$USER ALL=NOPASSWD: ALL" >> /etc/sudoers.d/50-$USER

ENV LANG C.UTF-8

ENV BUNDLE_PATH /gems
ENV BUNDLE_HOME /gems

ARG BUNDLE_JOBS=20
ENV BUNDLE_JOBS $BUNDLE_JOBS
ARG BUNDLE_RETRY=5
ENV BUNDLE_RETRY $BUNDLE_RETRY

ENV GEM_HOME /gems
ENV GEM_PATH /gems

ENV PATH /gems/bin:$PATH

RUN mkdir -p "$GEM_HOME" && chown $USER:$USER "$GEM_HOME"
RUN mkdir -p /app && chown $USER:$USER /app

WORKDIR /app

RUN mkdir -p node_modules && chown $USER:$USER node_modules
RUN mkdir -p public/packs && chown $USER:$USER public/packs
RUN mkdir -p tmp/cache && chown $USER:$USER tmp/cache

USER $USER

ARG PORT
ENV PORT $PORT
EXPOSE $PORT

RUN gem install bundler
# RUN chown -R $User /home/app/webapp


ENTRYPOINT [ "/bin/bash" ]
