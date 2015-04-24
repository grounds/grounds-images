require_relative 'finder'

module Grounds
  class Image
    include Grounds::Finder

    REPOSITORY    = ENV.fetch('REPOSITORY', 'grounds')
    TAG           = ENV.fetch('TAG', 'latest')
    DIR           = 'dockerfiles'
    EXTENSION     = 'docker'
    PREFIX        = 'exec'
    FILES_PATTERN = "#{DIR}/*.#{EXTENSION}"

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
      sh "docker build --pull=true -f #{@filename} -t #{@name} #{DIR}"
    end

    def push
      sh "docker push #{@name}"
    end

    def pull
      sh "docker pull #{@name}"
    end

    def self.name(language)
      "#{REPOSITORY}/#{PREFIX}-#{language}"
    end

    private

    def sh(cmd)
      abort unless system(cmd)
    end
  end
end
