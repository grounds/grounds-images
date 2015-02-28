require 'docker'
require './lib/image'

task :build do
  Image.all.each(&:build)
end

task :test do
  sh 'bundle exec rspec --format documentation --color'
end
