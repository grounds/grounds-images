FROM ruby:2.2.0

ENV APP /grounds-images

RUN wget "https://get.docker.com/builds/Linux/x86_64/docker-latest" -O /usr/local/bin/docker && \
    chmod +x /usr/local/bin/docker

# Install bundler.
RUN gem install bundler

# Copy the Gemfile and Gemfile.lock into the image.
COPY Gemfile $APP/
COPY Gemfile.lock $APP/

# Install ruby gems.
RUN cd $APP && bundle install

COPY . $APP

WORKDIR $APP

CMD ["/bin/bash"]
