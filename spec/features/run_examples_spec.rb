require 'image'
require 'container'
require 'example'

REPOSITORY = ENV.fetch('REPOSITORY', 'grounds')

describe 'Run code examples' do
  Example.all.each do |example|
    it "runs #{example.language} #{example.title} example" do
      container = Container.new(REPOSITORY, example)
      container.run

      expect(container.output).to eq(example.output)
    end
  end
end