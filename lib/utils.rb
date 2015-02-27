IMAGE_PREFIX = 'exec'

module Utils
  extend self
  
  def format_image(repository, language)
    "#{repository}/#{IMAGE_PREFIX}-#{language}"
  end
  
  def format_cmd(code)
    [ 
      code.gsub("\\", "\\\\")
          .gsub("\n", "\\n")
          .gsub("\r", "\\r")
          .gsub("\t", "\\t")
    ]
  end
end