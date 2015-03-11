class Example
  CODE_DIR   = 'examples/code'
  OUTPUT_DIR = 'examples/output'

  attr_reader :language, :title, :code, :output

  def initialize(language, name)
    @language = language
    @name     = name
    @title    = File.basename(name, File.extname(name))
    @output   = File.read("#{OUTPUT_DIR}/#{@title}").chomp
    @code     = formated_code
  end

  def formated_code
    File.read("#{CODE_DIR}/#{@language}/#{@name}")
          .chomp
          .gsub('\\', '\\\\\\')
          .gsub("\n", '\\n')
          .gsub("\r", '\\r')
          .gsub("\t", '\\t')
          .gsub("'", '"')
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

  def self.find(language)
    all.select { |ex| ex.language == language }
  end
end
