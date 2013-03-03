require "cli_forge/autoload_convention"

module CLIForge
  extend CLIForge::AutoloadConvention

  # class << self

  def self.start(bin_name=nil, &block)
    config = CLIForge::Configuration.new
    block.call(config) if block
    config.bin_name ||= bin_name || guess_bin_name

    CLIForge::Runner.new(config).start
  end

  def doh
    one.two ||= three || four
  end

private

  def self.guess_bin_name
    File.basename($0)
  end

  # end
end
