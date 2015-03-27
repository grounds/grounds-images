$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'rspec/core/rake_task'
require 'grounds'

images = Grounds::Image.find(Grounds.language)

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

task :default => :build

# This Rakefile can be used in an environment where RSpec is unavailable.
begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:test) do |t|
    t.rspec_opts = "--format documentation --color #{ENV['TEST_OPTS']}"
    t.verbose    = false
  end
rescue LoadError
end
