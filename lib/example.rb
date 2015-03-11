class Example
  CODE_DIR   = 'examples/code'
  OUTPUT_DIR = 'examples/output'

  attr_reader :filename

  def initialize(filename)
    @filename = filename
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
  
  def language
    @filename.gsub("#{CODE_DIR}/", '')
             .gsub("/#{title}#{extension}", '')
  end
  
  def title
    File.basename(@filename, extension)
  end
  
  def extension
    File.extname(@filename)
  end
  
  def output
    File.read("#{OUTPUT_DIR}/#{title}").chomp
  end
  
  def self.all
    Dir.glob("#{CODE_DIR}/*/*").map(&method(:new))
  end

  def self.find(language)
    all.select { |ex| ex.language == language }
  end
end
