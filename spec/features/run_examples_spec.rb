require 'grounds'

examples = Grounds::Example.find(Grounds.language)

describe 'Run code examples' do

  examples.each do |ex|

    it "runs #{ex.language} #{ex.title} example" do
      output = run(ex.language, ex.code)

      expect(output).to eq(ex.output)
    end

  end

  def run(language, code)
    `docker run -t #{Grounds::Image.name(language)} '#{code}'`.chomp
  end
end