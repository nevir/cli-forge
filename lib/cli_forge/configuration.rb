class CLIForge::Configuration

  def initialize
    @search_paths = []
  end

  # The name of the binary for this program; used to determine where to find
  # sub-commands, help, etc.
  attr_accessor :bin_name

  # Paths to search for sub command binaries
  attr_accessor :search_paths

end
