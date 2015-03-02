require 'docker'

IMAGES_DIR    = 'dockerfiles'
IMAGES_PREFIX = 'exec'
REPOSITORY    = ENV.fetch('REPOSITORY', 'grounds')

class Image
  attr_reader :language, :name, :dir

  def initialize(language)
    @language = language
    @dir      = "#{IMAGES_DIR}/#{language}"
    @name     = "#{REPOSITORY}/#{IMAGES_PREFIX}-#{language}"
  end

  def build
    @internal = Docker::Image.build_from_dir(@dir) do |out|
      puts JSON.parse(out)['stream']
    end

    @internal.tag(repo: @name, tag: 'latest', force: true)
  end
  
  def push
    @internal.push do |out|
      puts out
    end
  end

  def self.all
    dirs.map { |dir| new(dir) }
  end

  def self.find(language)
    all.select { |img| img.language == language }.first
  end

  def self.dirs
    Dir.entries(IMAGES_DIR).select { |entry| entry != '.' && entry != '..' }
  end
end
