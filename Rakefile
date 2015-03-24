$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'image'

images = LANGUAGE.empty? ? Image.all : Image.find(LANGUAGE)

desc 'Build Docker image(s)'
task :build do
  images.each(&:build)
end

desc 'Push Docker image(s) to the registry'
task :push do
  images.each(&:push)
end

desc 'Pull Docker image(s) from the registry'
task :pull do
  images.each(&:pull)
end

task :test do
  sh "bundle exec rspec --format documentation --color #{TEST_OPTS}"
end
