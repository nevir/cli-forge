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

  it "should not require any arguments" do
    mock_runner.should_receive(:start)
    described_class.should_receive(:guess_bin_name)

    described_class.start
  end

  it "should consume the passed name if given" do
    mock_runner.should_receive(:start)
    described_class.should_not_receive(:guess_bin_name)

    described_class.start("awesomesauce")

    expect(@config.bin_name).to eq("awesomesauce")
  end

  it "should pass the configuration to the given block" do
    mock_runner.should_receive(:start)
    described_class.should_not_receive(:guess_bin_name)

    described_class.start do |config|
      config.bin_name = "foo-bar"
    end

    expect(@config.bin_name).to eq("foo-bar")
  end

end
