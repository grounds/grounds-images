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
    diff = `git diff HEAD^ HEAD --name-only`
          puts "DEBUG " + diff.inspect
    diff.split(/\r?\n/).each {|line| 
      if line.start_with?('example')
        languages.push line["([^\/:]+)\/[^\/]+$"] + ".#{EXTENSION}"
      elsif line.start_with?(DIR)
        languages.push line.gsub("\/(.[[:alpha:]]+)", "")
      end}
      puts "DEBUG " + languages.to_s
    return find 'ruby'  if languages.empty?
    languages.map(&method(:new))
  end
end
