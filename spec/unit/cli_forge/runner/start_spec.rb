describe CLIForge::Runner, "#start" do
  include_context "fixture config"

  subject {
    described_class.new(config)
  }

  let(:default_command) {
    double("DefaultCommand").tap do |command|
      command.stub(:call) { "Called and stuff" }
    end
  }

  describe "edge cases" do

    it "should not modify the input arguments" do
      config.register_command(:default, default_command)

      arguments = ["default", "and", "stuff"]

      subject.start(arguments)

      expect(arguments).to eq(["default", "and", "stuff"])
    end

  end

end
