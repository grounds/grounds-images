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

  # Skip this test if language != golang?
  context "with code that doesn't compile" do
    let(:code) { '' }

    it "doesn't try to run the program" do
      output = run('golang', code)

      expect(output).not_to have('./prog ...')
    end
  end

  def run(language, code)
    `docker run -t #{image_name(language)} '#{code}'`.chomp
  end

  def image_name(language)
    "#{REPOSITORY}/#{IMAGE_PREFIX}-#{language}"
  end
end
