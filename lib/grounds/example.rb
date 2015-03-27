class Grounds::Example
  CODE_DIR   = 'examples/code'
  OUTPUT_DIR = 'examples/output'

  attr_reader :filename, :title, :language

  def initialize(filename)
    @filename  = filename
    @extension = File.extname(filename)
    @title     = File.basename(filename, @extension)
    @language  = filename.gsub("#{CODE_DIR}/", '')
                         .gsub("/#{@title}#{@extension}", '')
  end

  def code
    File.read(@filename)
        .chomp
        .gsub('\\', '\\\\\\')
        .gsub("\n", '\\n')
        .gsub("\r", '\\r')
        .gsub("\t", '\\t')
        .gsub("'", '"')
  end

  def output
    File.read("#{OUTPUT_DIR}/#{@title}").chomp
  end

  def self.all
    Dir.glob("#{CODE_DIR}/*/*").map(&method(:new))
  end

  def self.find(language)
    all.select { |ex| language == 'all' || ex.language == language }
  end
end
