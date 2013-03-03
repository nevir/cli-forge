class CLIForge::Runner

  def initialize(config)
    @config = config
  end

  def start(arguments)
    arguments    = filter_arguments(arguments.dup)
    command_name = pop_command(arguments) || @config.default_command
    command_set  = CLIForge::CommandSet.new(@config)

    unless command = command_set[command_name]
      # TODO: Output!
      command = command_set[@config.default_command]
    end

    # TODO: Output!
    return 1 unless command

    command.call(arguments)
  end

private

  def filter_arguments(arguments)
    @config.argument_filters.each do |argument_filter|
      arguments = argument_filter.call(arguments)
    end

    # TODO: Validate args

    arguments
  end

  def pop_command(arguments)
    index = arguments.find_index { |a| !a.start_with? "-" }
    return unless index

    arguments.delete_at(index)
  end

end
