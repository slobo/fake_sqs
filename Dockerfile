FROM inzinger/alpine-ruby:2.2.2
MAINTAINER Nathaniel Ritholtz <nritholtz@gmail.com>

# Install required packages
RUN apk add --update \
              build-base \
              ruby-dev \
              bash \         
              git \
  && rm -rf /var/cache/apk/*

EXPOSE 3000

WORKDIR /var/lib/sqs

COPY . /var/lib/sqs

RUN mkdir -p /var/lib/sqs

RUN gem build fake_sqs.gemspec && \
  gem install *.gem && \
  rm -rf *

CMD [ "/usr/bin/fake_sqs", "-p", "3000", "--no-daemonize" ]