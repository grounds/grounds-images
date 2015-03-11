require 'params'

class Image
  DIR       = 'dockerfiles'
  EXTENSION = 'docker'
  PREFIX    = 'exec'

  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def build
    system "docker build -f #{@filename} -t #{@name} #{DIR}"
  end

  def push
    system "docker push #{@name}"
  end

  def pull
    system "docker pull #{@name}"
  end
  
  def name
    @filename.gsub("#{DIR}", REPOSITORY)
             .gsub(".#{EXTENSION}", ":#{TAG}")
             .gsub("/", "/#{PREFIX}-")
  end
  
  def language
    @filename.gsub("#{DIR}/", '')
             .gsub(".#{EXTENSION}", '')
  end

  def self.all
    Dir.glob("#{DIR}/*.#{EXTENSION}").map(&method(:new))
  end

  def self.find(language)
    [new("#{DIR}/#{language}.#{EXTENSION}")]
  end

  def self.name(language)
    "#{REPOSITORY}/#{PREFIX}-#{language}"
  end
end
