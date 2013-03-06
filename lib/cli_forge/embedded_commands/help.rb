class CLIForge::EmbeddedCommands::Help

  def initialize(config)
    @config = config
  end

  def call(arguments)
    puts "help and stuff"
  end

end
