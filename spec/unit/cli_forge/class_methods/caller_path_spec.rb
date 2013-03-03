describe CLIForge, ".caller_path" do

  def spec_caller_line
    caller.first
  end

  it "should extract the current platform's stack format" do
    caller_line = spec_caller_line
    path        = described_class.caller_path(caller_line)

    expect(path).to eq(File.dirname(__FILE__)), "Extracted #{path.inspect} from #{caller_line.inspect}"
  end

  it "should extract paths from well formed MRI stack lines" do
    path = described_class.caller_path("/usr/bin/foo:6:in `<main>'")

    expect(path).to eq("/usr/bin")
  end

  it "should expand relative paths" do
    path = described_class.caller_path("bin/bar:6:in `<main>'")

    expect(path).to eq(File.expand_path("bin"))
  end

  it "should not freak out if given nil" do
    path = described_class.caller_path(nil)

    expect(path).to eq(nil)
  end

end
