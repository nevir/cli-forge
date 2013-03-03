class CLIForge::Configuration

  def initialize
    @default_command = "help"
    @bin_separator   = "-"

    @search_paths      = []
    @argument_filters  = {}
    @embedded_commands = {}
  end

  # The name of the binary for this program; used to determine where to find
  # sub-commands, help, etc.
  attr_accessor :bin_name

  # If no command is given, fall back to this.
  attr_accessor :default_command

  # Paths to search for sub command binaries.
  attr_accessor :search_paths

  # Separator to use when searching for subcommands.
  attr_accessor :bin_separator


  # Argument Filters
  # ----------------
  # Argument filters are named procs that are given the current command's
  # arguments and have the opportunity to modify them.
  #
  # The return value of the proc is used as the new argument set.
  def register_argument_filter(name, &block)
    @argument_filters[name.to_sym] = block
  end

  # Remove a previously registered argument filter.
  def remove_argument_filter(name)
    @argument_filters.delete(name.to_sym)
  end

  # The active argument filters.
  def argument_filters
    @argument_filters.values
  end


  # Embedded Sub Commands
  # ---------------------
  # In addition to exposing sub commands via external bins, you can register
  # specific commands directly:
  def register_command(name, command_object)
    @embedded_commands[name.to_sym] = command_object
  end

  # Remove a previosuly registered command.
  #
  # This _does not_ block an external bin by the same name from being run!
  def remove_command(name)
    @embedded_commands.delete(name.to_sym)
  end

  # The set of embedded commands.  Prefer using `register_command` and
  # `remove_command`.
  attr_reader :embedded_commands

end
