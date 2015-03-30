module Grounds
  extend self

  require_relative 'grounds/example'
  require_relative 'grounds/image'

  def language
    ENV.fetch('LANGUAGE', 'all')
  end
end