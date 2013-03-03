class CLIForge::DefaultConfiguration < CLIForge::Configuration

  def initialize
    super

    with_help_command
    with_implicit_help_flags
  end

private

  # Help is one of those global commands that pretty much everyone wants
  def with_help_command
    register_command :help, CLIForge::EmbeddedCommands::Help.new(self)
  end

  # Passing a help flag to any command results in us calling the help command.
  def with_implicit_help_flags
    register_argument_filter(:help_flags) { |arguments|
      new_arguments = arguments - ["--help", "-h", "/?"]
      new_arguments.unshift("help") if new_arguments.length != arguments.length

      new_arguments
    }
  end

end
