FROM ruby:2.4
MAINTAINER KY <infcurious@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update && \
  apt-get install -y nodejs rsync ssh mysql-client && \
  update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10 && \
  apt-get clean

RUN echo "gem: --no-ri --no-rdoc" > /root/.gemrc

WORKDIR /rrrspec-worker

COPY worker_config.rb .
COPY start.sh .
COPY Gemfile .

RUN chmod a+x start.sh

RUN bundle install

RUN mkdir -m700 -p /root/.ssh
COPY id_rsa.rrrspec /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa
COPY ssh_config /root/.ssh/config

RUN mkdir -p /tmp/rrrspec-rsync

ENV REDIS_HOST redis
ENV MASTER_HOST master

CMD ["/bin/bash", "./start.sh"]
