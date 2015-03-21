# Add a new language stack

Each language stack has its own Docker image used to execute code inside
a Docker container.

These images can be found inside the `dockerfiles` directory:

```
dockerfiles
│
├─── ruby.docker
│
└─── golang.docker
|
└─── ruby
|      |
|      └─── sync.rb
|
└─── shared
        |
        └─── run.sh
```

Each image has:

- A `Dockerfile` following the naming convention:

        $LANGUAGE_CODE.docker

    e.g.

        php.docker

- A shell script `run.sh` (in `shared` directory).

Images are following this naming convention:

    $REPOSITORY/exec-$LANGUAGE

Images are built has an executable Docker image. This allow us to do:

    $ docker run grounds/exec-ruby "puts 42"
    42

## run.sh

This script writes into a file the content of the first argument into a file
specified by environment variable `FILE`, compile with `COMPILE`command if specified
and then execute the command specified by environment variable `EXEC`.

e.g.

    FILE='prog.rb' \
    EXEC='ruby prog.rb' ./run.sh '<some ruby code>'

    FILE='prog.cpp' \
    COMPILE='gcc -o prog prog.c' \
    EXEC='./prog' ./run.sh '<some c code>'

## Create an image

Creating an image for a new language is really trivial.
Take a look at this example for the C language:

Add a `Dockerfile` inside images directory:

    touch dockerfiles/c.docker

### Inside the Dockerfile:

Checkout first [here](https://github.com/docker-library).
If there is an official image for the language stack you are trying to add,
just inherit from the latest tag of the official image and skip to step 4:

    FROM python:latest

If there is no official image for this language stack:

1. Base the image on the official ubuntu image:

        FROM ubuntu:14.04

2. Add yourself as a maintainer of this image:

        MAINTAINER Adrien Folie <folie.adrien@gmail.com>

3. Update ubuntu package manager:

        RUN apt-get update -qq

    >Use apt-get update quiet mode level 2 (with `--qq`)

4. Install dependencies required to compile C code (e.g `gcc`)

        RUN apt-get -qy install \
            build-essential \
            gcc

5. Specify file format:

        ENV FILE prog.c

6. Specify compiler/interpreter command:

    * If you need to compile the program:

                ENV COMPILE gcc -o prog $FILE

    * Run the interpreter or the program:

                ENV EXEC ./prog

7. Set development directory in env:

        ENV DEV /home/dev

8. Copy the shared files inside the development directory:

        COPY shared/* $DEV/

9. Add a user and give him access to the development directory:

        RUN useradd dev
        RUN chown -R dev: $DEV

10. Switch to this user:

        USER dev

11. Set working directory:

        WORKDIR $DEV

12. Configure this image as an executable:

        ENTRYPOINT ["./run.sh"]

When you run a Docker container with this image:

- The default `pwd` of this container will be `/home/dev`.
- The user of this container will be `dev`
- This container will run `run.sh` and takes as parameter a string whith arbitrary code inside.

**N.B. If you have some custom files that should be in the image:**

1. Create a directory for this image:

        mkdir dockerfiles/ruby

2. Add your files inside this directory.

3. Copy this directory inside the image:

    e.g. For ruby, add in `dockerfiles/ruby.docker`:

        COPY ruby /custom

### Build this image:

    $ LANGUAGE="c" rake build

### Tests

To add this language to the test suite:

1. Create a directory with the language code inside `examples/code`

    e.g. For PHP:

        mkdir examples/code/php

2. In this directory add two files with the appropriate file extension:

    * A code example who writes `"Hello world\n"` on `stdout`.
    * A code example who writes `"Hello stderr\n"` on `stderr`.

You can find great examples on
[Rosetta code](http://rosettacode.org/wiki/Hello_world).

3. Run the examples test suite

        rake test

4. If you want to test only a specific language

        LANGUAGE="ruby" rake test

**Thanks for your contribution!**
