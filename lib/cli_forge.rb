require "cli_forge/autoload_convention"

module CLIForge
  extend CLIForge::AutoloadConvention

  def self.start(bin_name=nil, &block)
    config = CLIForge::Configuration.new

    config.search_paths = ENV["PATH"].split(":").uniq

    block.call(config) if block

    config.bin_name ||= bin_name || guess_bin_name

    CLIForge::Runner.new(config).start(ARGV)
  end

  def self.guess_bin_name
    File.basename($0)
  end

end
