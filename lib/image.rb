require 'params'

class Image
  DIR       = 'dockerfiles'
  EXTENSION = 'docker'
  PREFIX    = 'exec'

  attr_reader :file, :name, :language

  def initialize(file)
    @file     = file
    @name     = file.gsub("#{DIR}", REPOSITORY)
                    .gsub(".#{EXTENSION}", ":#{TAG}")
                    .gsub("/", "/#{PREFIX}-")
    @language = file.gsub("#{DIR}/", '')
                    .gsub(".#{EXTENSION}", '')
  end

  def build
    system "docker build -f #{@file} -t #{@name} #{DIR}"
  end

  def push
    system "docker push #{@name}"
  end

  def pull
    system "docker pull #{@name}"
  end

  def self.all
    Dir.glob("#{DIR}/*.#{EXTENSION}").map do |file|
      new(file)
    end
  end

  def self.find(language)
    [new("#{DIR}/#{language}.#{EXTENSION}")]
  end

  def self.name(language)
    "#{REPOSITORY}/#{PREFIX}-#{language}"
  end
end
