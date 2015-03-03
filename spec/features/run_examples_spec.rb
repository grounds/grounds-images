require 'spec_helper'
require 'container'
require 'example'

describe 'Run code examples' do
  after(:each) do
    @container.remove
  end

  Example.all.each do |example|
    it "#{example.language} #{example.title} has proper output" do
      @container = Container.new(example)
      @container.run

      expect(@container.output).to eq(example.output)
    end
  end
end
