require 'params'

class Image
  DIR       = 'dockerfiles'
  EXTENSION = 'docker'
  PREFIX    = 'exec'

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
    system "docker build -f #{@filename} -t #{@name} #{DIR}"
  end

  def push
    system "docker push #{@name}"
  end

  def pull
    system "docker pull #{@name}"
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

  def self.only_changed
    languages = []
    diff = `git diff --name-only`
          puts "DEBUG " + diff
    diff.split(/\r?\n/).each {|line| 
      if line.start_with?('example', DIR)
        languages.push line.gsub("([^\/:]+)\/[^\/]+$", "") + ".#{EXTENSION}"
      elsif line.start_with?(DIR)
        languages.push line.gsub("\/(.[[:alpha:]]+)", "") + ".#{EXTENSION}"
      end}
      puts "DEBUG " + languages
    return find 'ruby'  if languages.empty?
    languages.map(&method(:new))
  end
end
