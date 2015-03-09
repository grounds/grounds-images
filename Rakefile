REPOSITORY      = ENV.fetch('REPOSITORY', 'grounds')
TAG             = ENV.fetch('TAG', 'latest')

IMAGE_DIR       = 'dockerfiles'
IMAGE_EXTENSION = 'docker'
IMAGE_PREFIX    = 'exec'

task :build do
  dockerfiles.each(&method(:build))
end

task :test do
end

task :push do
  dockerfiles.each(&method(:push))
end

task :pull do
  dockerfiles.each(&method(:pull))
end

def build(dockerfile)
  `docker build -f #{dockerfile} -t #{image_name(dockerfile)} #{IMAGE_DIR}`
end

def push(dockerfiles)
  `docker push #{image_name(dockerfile)}`
end

def pull(dockerfiles)
  `docker pull #{image_name(dockerfile)}`
end

def image_name(dockerfile)
  dockerfile.gsub("#{IMAGE_DIR}", REPOSITORY)
            .gsub(".#{IMAGE_EXTENSION}", ":#{TAG}")
            .gsub("/", "/#{IMAGE_PREFIX}-")
end

def dockerfiles
  Dir.glob("#{IMAGE_DIR}/*.#{IMAGE_EXTENSION}")
end