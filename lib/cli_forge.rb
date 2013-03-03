require "cli_forge/autoload_convention"

module CLIForge
  extend CLIForge::AutoloadConvention

  def self.start(bin_name=nil, &block)
    config = CLIForge::DefaultConfiguration.new

    config.search_paths  = Array(caller_path(caller.first))
    config.search_paths += ENV["PATH"].split(":")
    config.search_paths.uniq!

    block.call(config) if block

    config.bin_name ||= bin_name || guess_bin_name

    CLIForge::Runner.new(config).start(ARGV)
  end

  def self.guess_bin_name
    File.basename($0)
  end

  def self.caller_path(stack_line)
    return unless stack_line
    stack_path = stack_line.split.first

    File.expand_path(File.dirname(stack_path))
  end

end
