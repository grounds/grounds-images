module Grounds
  extend self

  require 'grounds/example'
  require 'grounds/image'

  def language
    ENV.fetch('LANGUAGE', 'all')
  end
end