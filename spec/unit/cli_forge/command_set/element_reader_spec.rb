describe CLIForge::CommandSet, "#[]" do
  include_context "fixture config"

  subject {
    described_class.new(config)
  }

  it "should return nil if no command was found" do
    expect(subject[:missing_command]).to eq(nil)
  end

  describe "bin commands" do

    it "should return the first matching command on the search paths" do
      command = subject[:bar]

      expect(command).to be_a(CLIForge::BinCommand)
      expect(command.path).to eq(File.join(FIXTURE_ROOT, "bins", "foo-bar"))
    end

    it "should search subsequent search paths" do
      command = subject[:too]

      expect(command).to be_a(CLIForge::BinCommand)
      expect(command.path).to eq(File.join(FIXTURE_ROOT, "bins2", "foo-too"))
    end

    it "should accept strings" do
      command = subject["bar"]

      expect(command).to be_a(CLIForge::BinCommand)
      expect(command.path).to eq(File.join(FIXTURE_ROOT, "bins", "foo-bar"))
    end

  end

  describe "embedded commands" do

    it "should return embedded commands" do
      command = double("TestCommand")
      config.register_command("my-command", command)

      expect(subject["my-command"]).to be(command)
    end

    it "should prioritize embedded commands" do
      command = double("ABetterBar")
      config.register_command(:bar, command)

      expect(subject[:bar]).to be(command)
    end

  end

end
