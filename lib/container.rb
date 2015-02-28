require 'image'

class Container
  attr_reader :image, :cmd, :output

  def initialize(example)
    @image = Image.find(example.language)
    @cmd   = [example.code]
  end

  def run
    @output = ''
    @internal  = Docker::Container.create('Image' => @image.name, 'Cmd' => @cmd)

    @internal.tap(&:start).attach { |_, chunk| @output << chunk }
  end

  def remove
    @internal.delete(force: true)
  end
end
