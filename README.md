# Grounds Images
[![Circle CI](https://circleci.com/gh/grounds/grounds-images/tree/master.svg?style=svg)](https://circleci.com/gh/grounds/grounds-images/tree/master)

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

You need [Docker 1.5+](https://www.docker.com/) and
[Docker Compose 1.1+](https://docs.docker.com/compose/) to run this project.

### Clone this project

    git clone https://github.com/grounds/grounds-images.git

### Get into this project directory

    cd grounds-images

### Preconfigured environment:

To get a preconfigured environment to work with:

    docker-compose build && docker-compose run dev

>N.B. Project directory is mounted inside the container, you can edit you files
from your machine directly without rebuilding the image.

If you already have [Ruby 2.0+](http://www.ruby-lang.org) on your machine you
can also install dependencies and work directly on your machine:

    gem install bundler
    bundle install

## Build Docker images

    rake build

You can also build these images for your own repository:

    REPOSITORY="tintin" rake build

You can also build only a specific image:

    LANGUAGE="ruby" rake build

If you do so, please prefix use `REPOSITORY` environment variables for every rake
tasks.

## Get a shell inside an image

    docker run -ti --entrypoint=/bin/bash grounds/exec-ruby

## Run some code inside a container

e.g. For `ruby`:

    docker run -t grounds/exec-ruby "puts 'Hello world'"

## Push / Pull

To push these images to a docker registry:

    REPOSITORY="tintin" rake push

You can also push only a specific image:

    LANGUAGE="ruby" rake push

To pull these images from a docker registry:

    REPOSITORY="tintin" rake pull

You can also pull only a specific image:

    LANGUAGE="ruby" rake pull

>Default `REPOSITORY` is set to Grounds official organization on the Docker
[Hub](http://registry.hub.docker.com/repos/grounds/). You don't and you
can't push to this repository. These images are automatically pushed if the
test suite pass.

## Tests

To run the test suite:

    rake test

To run tests only for a specific language:

    LANGUAGE="ruby" rake test

## Contributing

Before sending a pull request, please checkout the contributing
[guidelines](/docs/CONTRIBUTING.md).

## Authors

See [authors](/docs/AUTHORS.md) file.

## Licensing

grounds-images is licensed under the MIT License. See [LICENSE](LICENSE) for
full license text.
