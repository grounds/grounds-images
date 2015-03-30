module Grounds::Finder
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def all
      Dir.glob(self::FILES_PATTERN).map(&method(:new))
    end

    def find(language)
      all.select { |obj| language == 'all' || language == obj.language }
    end
  end
end