require 'docker'
require './lib/image'

Docker.validate_version!

images = Image.all

task :build do
  images.each(&:build)
end

task :push => [:authenticate, :build] do
  images.each(&:push)
end

task :pull => [:authenticate, :build] do
  images.each(&:pull)
end

task :test do
  sh 'bundle exec rspec --format documentation --color'
end

task :authenticate do
  Docker.authenticate!(username: ENV.fetch('HUB_USERNAME'),
                       password: ENV.fetch('HUB_PASSWORD'),
                       email:    ENV.fetch('HUB_EMAIL'))
end
