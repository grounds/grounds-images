$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'image'

images = LANGUAGE.empty? ? Image.all : Image.find(LANGUAGE)

task :build do
  images.each(&:build)
end

task :push do
  images.each(&:push)
end

task :pull do
  images.each(&:pull)
end

task :test do
  sh "bundle exec rspec --format documentation --color #{TEST_OPTS}"
end
