class CLIForge::BinCommand

  def initialize(path)
    @path = path
  end

  attr_reader :path

  def to_s
    "#<#{self.class} #{path}>"
  end

  def call(arguments)
    exec path, *arguments
  end

end
