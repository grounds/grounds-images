require 'image'

class Container
  attr_reader :image, :cmd, :output, :internal

  def initialize(example)
    @image = Image.find(example.language)
    @cmd   = [example.code]
  end

  def run
    @output = ''
    @internal = Docker::Container.create('Image' => @image.name,
                                         'Cmd' => @cmd)

    @internal.tap(&:start).attach { |_, chunk| @output << chunk }

    return unless @output.empty?

    @internal.streaming_logs(stdout: true, stderr: true) do |_, chunk|
      @output << chunk
    end
  end

  def remove
    @internal.delete(force: true)
  end
end
