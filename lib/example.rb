CODE_DIR   = 'examples/code'
OUTPUT_DIR = 'examples/output'

class Example
  attr_reader :language, :title, :code, :output
  
  def initialize(language, name)
    @language = language
    @title    = File.basename(name, File.extname(name))
    @code     = File.read("#{CODE_DIR}/#{language}/#{name}")
    @output   = File.read("#{OUTPUT_DIR}/#{@title}")
  end
  
  def self.all
    # Get language code directories.
    dirs = Dir.entries(CODE_DIR).select do |entry|
      !File.file?(entry) && entry != '.' && entry != '..'
    end
    examples = []
    # Get files to test.
    dirs.each do |dir|
      Dir.entries("#{CODE_DIR}/#{dir}").each do |entry|
        examples << new(dir, entry) if entry != '.' && entry != '..'
      end
    end
    examples
  end
end