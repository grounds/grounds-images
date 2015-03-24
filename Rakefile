$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'image'

images = LANGUAGE.empty? ? Image.all : Image.find(LANGUAGE)

%i(build push pull).each do |taskname|
  task taskname do
    images.each(&taskname)
  end
end

task :test do
  sh "bundle exec rspec --format documentation --color #{TEST_OPTS}"
end
