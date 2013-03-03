class CLIForge::CommandSet

  def initialize(config)
    @config = config
  end

  def [](command_name)
    if embedded_command = @config.embedded_commands[command_name.to_sym]
      return embedded_command
    end

    # TODO: Path lookup
  end

  # Given a prefix, find all of its potential sub commands.
  def all_sub_command_bins(command_prefix)
    found = []
    @config.search_paths.each do |search_path|
      full_path = File.expand_path(search_path)
      found += Dir["#{full_path}/#{command_prefix}#{@config.bin_separator}*"]
    end

    found.uniq
  end

end
