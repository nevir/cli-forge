class CLIForge::EmbeddedCommands::Help

  def initialize(config)
    @config = config
  end

  def call(arguments)
    command_set = CLIForge::CommandSet.new(@config)

    puts command_set.all_sub_command_bins(@config.bin_name).inspect
  end

end
