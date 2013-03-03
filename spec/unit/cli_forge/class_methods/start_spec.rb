describe CLIForge, ".start" do

  let(:mock_runner) {
    double("CLIForge::Runner").tap do |runner|
      runner.stub(:start)
    end
  }

  before(:each) do
    CLIForge::Runner.stub(:new) { |config|
      @config = config
      mock_runner
    }
  end

  # Stub out our environment
  around(:each) do |spec|
    old_path, old_argv = ENV["PATH"], ARGV

    begin
      spec.run
    ensure
      ENV["PATH"] = old_path
      Object.send(:remove_const, :ARGV)
      ::ARGV = old_argv
    end
  end


  it "should not require any arguments" do
    mock_runner.should_receive(:start)
    described_class.should_receive(:guess_bin_name)

    described_class.start
  end

  it "should pass the configuration to the given block" do
    mock_runner.should_receive(:start)
    described_class.should_not_receive(:guess_bin_name)

    described_class.start do |config|
      config.bin_name = "foo-bar"
    end

    expect(@config.bin_name).to eq("foo-bar")
  end

  describe "special-cased configuration properties" do

    it "should consume the passed name if given" do
      mock_runner.should_receive(:start)
      described_class.should_not_receive(:guess_bin_name)

      described_class.start("awesomesauce")

      expect(@config.bin_name).to eq("awesomesauce")
    end

    it "should pull search paths in order from PATH" do
      ENV["PATH"] = "/usr/bin:/usr/local/bin:/foo/bar:/usr/bin"

      described_class.start
      expect(@config.search_paths).to eq([
        "/usr/bin",
        "/usr/local/bin",
        "/foo/bar"
      ])
    end

    it "should extract ARGV" do
      Object.send(:remove_const, :ARGV)
      ::ARGV = ["my-bin", "sub-command", "--stuff"]

      mock_runner.should_receive(:start).with(["my-bin", "sub-command", "--stuff"])

      described_class.start
    end

  end

end
