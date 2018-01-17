FROM ruby:2.3.5
MAINTAINER KY <infcurious@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update && \
  apt-get install -y nodejs rsync ssh libmysqlclient-dev mysql-client && \
  update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10 && \
  apt-get clean

RUN echo "gem: --no-ri --no-rdoc" > /root/.gemrc

WORKDIR /rrrspec-server

RUN gem install foreman

COPY config.ru .
COPY database.yml .
COPY Gemfile .
COPY Procfile .
COPY Rakefile .
COPY server_config.rb .
COPY start.sh .

RUN bundle install

RUN chmod a+x start.sh

RUN mkdir -m700 -p /root/.ssh
COPY id_rsa.rrrspec.pub /root/.ssh/authorized_keys

RUN service ssh start

RUN mkdir -p /tmp/rrrspec-rsync
RUN mkdir -p /tmp/pids

ENV REDIS_HOST redis
ENV RRRSPEC_DATABASE_PASSWORD 123123123

CMD ["/bin/bash", "./start.sh"]
