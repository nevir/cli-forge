class CLIForge::CommandSet

  def initialize(config)
    @config = config
  end

  def [](command_name)
    if embedded_command = @config.embedded_commands[command_name.to_sym]
      return embedded_command
    end

    target_bin = @config.bin_name + @config.bin_separator + command_name.to_s
    commands   = find_bin_commands(target_bin)

    # if commands.size > 1
      # TODO: Warn
    # end

    commands.first
  end

private

  def clean_search_paths
    @config.search_paths.map { |path| File.expand_path(path) }.uniq
  end

  # Given a glob expression for the bin name, find any matching commands on the
  # search paths.
  def find_bin_commands(glob_expression)
    clean_search_paths.reduce([]) { |paths, search_path|
      paths + Dir["#{search_path}/#{glob_expression}"].map { |found_bin|
        CLIForge::BinCommand.new(found_bin)
      }
    }
  end

end
