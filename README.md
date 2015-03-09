# Grounds Images

This is the official repository of [Grounds](http://beta.42grounds.io) code
[runner](http://github.com/grounds/grounds-exec) Docker images.

## Languages
There is one Docker image for each language stack supported.

Grounds currently supports latest version of:

- C
- C++
- C#
- Elixir
- Go
- Haxe
- Java
- Node.js
- PHP
- Python 2 and 3
- Ruby
- Rust

Checkout this [documentation](/docs/NEW_LANGUAGE.md) to get more informations
about how to add support for a new language stack.

## Prerequisite

You need [Ruby 2.0+](http://www.ruby-lang.org), and [Bundler](http://bundler.io/)
to run this project.

Configure Docker URL:

    export DOCKER_URL="http://127.0.0.1:2375"

You can instead set:

* `DOCKER_HOST`
* `DOCKER_CERT_PATH`
* `DOCKER_TLS_VERIFY`

>If you are using `boot2docker`, it should work out of the box.

Install dependencies:

    bundle install

Build Docker images:

    rake build

You can also build these images for your own repository:

    REPOSITORY="tintin" rake build

If you do so, please prefix use `REPOSITORY` environment variables for every rake
tasks.

## Get a shell inside an image

    docker run -ti --entrypoint=/bin/bash grounds/exec-ruby

## Run some code inside a container

e.g. For `ruby`:

    docker run -t grounds/exec-ruby "puts 'Hello world'"

## Push / Pull

First set this environment variables to authenticate with your docker registry:

* `HUB_USERNAME`
* `HUB_PASSWORD`
* `HUB_EMAIL`

To push these images to a docker registry:

    REPOSITORY="tintin" rake push

To pull these images from a docker registry:

    REPOSITORY="tintin" rake pull

>Default `REPOSITORY` is set to Grounds official organization on the Docker
[Hub](http://registry.hub.docker.com/repos/grounds/).

## Tests

To run the test suite:

    rake test

To run the test suite for a specific language:

    LANGUAGE="ruby" rake test

## Contributing

Before sending a pull request, please checkout the contributing
[guidelines](/docs/CONTRIBUTING.md).

## Authors

See [authors](/docs/AUTHORS.md) file.

## Licensing

grounds-images is licensed under the MIT License. See [LICENSE](LICENSE) for
full license text.
