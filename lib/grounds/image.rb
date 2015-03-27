require 'pry'
class Grounds::Image
  REPOSITORY = ENV.fetch('REPOSITORY', 'grounds')
  TAG        = ENV.fetch('TAG', 'latest')
  DIR        = 'dockerfiles'
  EXTENSION  = 'docker'
  PREFIX     = 'exec'

  attr_reader :filename, :name, :language

  def initialize(filename)
    @filename = filename
    @name     = filename.gsub("#{DIR}", REPOSITORY)
                        .gsub(".#{EXTENSION}", ":#{TAG}")
                        .gsub("/", "/#{PREFIX}-")
    @language = filename.gsub("#{DIR}/", '')
                        .gsub(".#{EXTENSION}", '')
  end

  def build
    sh "docker build -f #{@filename} -t #{@name} #{DIR}"
  end

  def push
    sh "docker push #{@name}"
  end

  def pull
    sh "docker pull #{@name}"
  end

  def self.all
    Dir.glob("#{DIR}/*.#{EXTENSION}").map(&method(:new))
  end

  def self.find(language)
    all.select { |image| language == 'all' || language == image.language }
  end

  def self.name(language)
    "#{REPOSITORY}/#{PREFIX}-#{language}"
  end

  private

  def sh(cmd)
    abort unless system(cmd)
  end
end
