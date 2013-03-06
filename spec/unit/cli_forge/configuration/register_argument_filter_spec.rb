describe CLIForge::Configuration, "#register_argument_filter" do

  it "should register the filter" do
    subject.register_argument_filter(:hi) { "hi" }

    expect(subject.argument_filters.size).to eq(1)
    expect(subject.argument_filters[0].call).to eq("hi")
  end

  it "should allow you to register over existing commands" do
    subject.register_argument_filter(:hi) { "hi" }
    subject.register_argument_filter(:hi) { "bye" }

    expect(subject.argument_filters.size).to eq(1)
    expect(subject.argument_filters[0].call).to eq("bye")
  end

  it "should coerce string names to symbols" do
    subject.register_argument_filter("hi") { "hi" }
    subject.register_argument_filter(:hi) { "bye" }

    expect(subject.argument_filters.size).to eq(1)
    expect(subject.argument_filters[0].call).to eq("bye")
  end

end
