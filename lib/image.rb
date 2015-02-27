require 'docker'
require 'utils'

IMAGE_DIR    = 'dockerfiles'

class Image
  attr_reader :language, :name, :dir, :internal

  def initialize(repository, language)
    @language = language
    @name     = Utils.format_image(repository, language)
    @dir      = "#{IMAGE_DIR}/#{language}"
  end

  def build
    @internal = Docker::Image.build_from_dir(@dir) do |out|
      puts JSON.parse(out)['stream']
    end

    @internal.tag(repo: @name, tag: 'latest', force: true)
  end

  def self.all(repository)
    dirs.map { |dir| { :"#{dir}" => new(repository, dir) } }
  end
  
  def self.find(repository, language)
    all(repository).select {|img| img.language == language}.first
  end

  def self.dirs
    Dir.entries(IMAGE_DIR).select { entry != '.' && entry != '..' }
  end
end