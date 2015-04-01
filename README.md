# Grounds Images
[![Circle CI](https://circleci.com/gh/grounds/grounds-images/tree/master.svg?style=svg)](https://circleci.com/gh/grounds/grounds-images/tree/master)
[![Code Climate](https://codeclimate.com/github/grounds/grounds-images/badges/gpa.svg)](https://codeclimate.com/github/grounds/grounds-images)

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

### Dev

To get a preconfigured develoment environment:

    docker-compose build && docker-compose run dev

>N.b. Project directory is mounted inside the container, you can edit you files
from your machine directly without rebuilding the image.

If you already have [Ruby 2.0+](http://www.ruby-lang.org) on your machine you
can also install dependencies and work directly on your machine:

    gem install bundler
    bundle install

## Build Docker images

    bundle exec rake build

You can also build these images for your own repository:

    REPOSITORY="tintin" bundle exec rake build

You can also build only a specific image:

    LANGUAGE="ruby" bundle exec rake build

If you do so, please prefix use `REPOSITORY` environment variables for every rake
tasks.

## Get a shell inside an image

    docker run -ti --entrypoint=/bin/bash grounds/exec-ruby

## Run some code inside a container

e.g. For `ruby`:

    docker run -t grounds/exec-ruby "puts 'Hello world'"

## Push / Pull

To push these images to a docker registry:

    REPOSITORY="tintin" bundle exec rake push

You can also push only a specific image:

    LANGUAGE="ruby" bundle exec rake push

To pull these images from a docker registry:

    REPOSITORY="tintin" rake pull

You can also pull only a specific image:

    LANGUAGE="ruby" bundle exec rake pull

>Default `REPOSITORY` is set to Grounds official organization on the Docker
[Hub](http://registry.hub.docker.com/repos/grounds/). You don't and you
can't push to this repository. These images are automatically pushed if the
test suite pass.

## Tests

To run the test suite:

    bundle exec rake test

To run tests only for a specific language:

    LANGUAGE="ruby" bundle exec rake test

## Contributing

Before sending a pull request, please checkout the contributing
[guidelines](/docs/CONTRIBUTING.md).

## Authors

See [authors](/docs/AUTHORS.md) file.

## Licensing

grounds-images is licensed under the MIT License. See [LICENSE](LICENSE) for
full license text.
