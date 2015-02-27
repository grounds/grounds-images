class Container
  attr_reader :image, :cmd, :output

  def initialize(repository, example)
    @image = Utils.format_image(repository, example.language)
    @cmd   = Utils.format_cmd(example.code)
  end
  
  def run
    @output = ''
    @internal  = Docker::Container.create('Image' => @image, 'Cmd'   => @cmd)
                                       
    @internal.tap(&:start).attach { |_, chunk| @output << chunk }
  end
end