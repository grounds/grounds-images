require 'support/constants'
require 'support/example'

examples = LANGUAGE.empty? ? Example.all : Example.find(LANGUAGE)

describe 'Run code examples' do

  examples.each do |ex|

    it "runs #{ex.language} #{ex.title} example" do
      output = run(ex.language, ex.code)

      expect(output).to eq(ex.output)
    end

  end

  def run(language, code)
    `docker run -t grounds/exec-#{language} '#{code}'`.chomp
  end

  def image_name(language)

  end
end
