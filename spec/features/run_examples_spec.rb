require 'spec_helper'
require 'container'
require 'example'

describe 'Run code examples' do
  Example.all.each do |example|
    it "#{example.language} #{example.title} has proper output" do
      container = Container.new(example)
      container.run
      container.remove

      expect(container.output).to eq(example.output)
    end
  end
end
