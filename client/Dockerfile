FROM ruby:2.3.5

RUN apt-get update -qq && \
  apt-get install -y build-essential rsync ssh libpq-dev nodejs git-core

RUN mkdir -m700 -p /root/.ssh
COPY id_rsa.rrrspec /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa
COPY ssh_config /root/.ssh/config

WORKDIR client

COPY client_config.rb .
COPY start.sh .
COPY example example

RUN git clone https://github.com/tkbky/flowci-test.git
RUN echo "gem 'rrrspec-client', github: 'cookpad/rrrspec'" >> flowci-test/Gemfile
RUN echo "gem 'extreme_timeout', github: 'draftcode/extreme_timeout'" >> flowci-test/Gemfile
RUN cd flowci-test && bundle install && cd ..

COPY client_config.rb flowci-test/.rrrspec

RUN chmod a+x start.sh

# CMD ["/bin/bash", "./start.sh"]
