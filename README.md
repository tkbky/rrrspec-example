## RRRSpec Example

An example of how to setup [RRRSpec](https://github.com/cookpad/rrrspec).

### System Requirements

1. Docker

### How to Run

1. Start all services

    ```bash
    git clone https://github.com/tkbky/rrrspec-example.git

    cd rrrspec-example

    docker-compose up -d
    ```

2. Run the example specs

    ```bash
    docker-compose run client /bin/bash

    # Sample specs from https://github.com/yasaichi/rrrspec-tutorial
    cd example
    bundle exec rrrspec-client start --rsync-name example

    # A rails application specs
    cd flowci-test
    bundle exec rrrspec-client start --rsync-name flowci-test
    ```

3. Check the specs result

    ```bash
    open http://localhost:3000
    ```

### TODO

1. Guide for deployment to production.
2. 2 or more workers example.
