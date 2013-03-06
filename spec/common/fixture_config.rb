shared_context "fixture config" do

  let(:config) {
    CLIForge::Configuration.new.tap do |config|
      config.bin_name = "foo"

      config.search_paths << File.join(FIXTURE_ROOT, "bins")
      config.search_paths << File.join(FIXTURE_ROOT, "bins2")
      config.search_paths << File.join(FIXTURE_ROOT, "bins3")
    end
  }

end
