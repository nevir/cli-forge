describe CLIForge::Configuration, "#remove_argument_filter" do

  it "should remove the argument filter" do
    expect(subject.argument_filters).to eq([])

    subject.register_argument_filter(:hi) { "hi" }
    subject.remove_argument_filter(:hi)

    expect(subject.argument_filters).to eq([])
  end

  it "should not freak out if the argument filter doesn't exist" do
    expect(subject.argument_filters).to eq([])

    subject.remove_argument_filter(:bar)

    expect(subject.argument_filters).to eq([])
  end

end
