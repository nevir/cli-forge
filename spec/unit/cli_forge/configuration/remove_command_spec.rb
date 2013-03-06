describe CLIForge::Configuration, "#remove_command" do

  it "should remove the command" do
    command = double("TestCommand")
    subject.register_command(:foo, command)
    subject.remove_command(:foo)

    expect(subject.embedded_commands[:foo]).to eq(nil)
  end

  it "should not freak out if the command doesn't exist" do
    expect(subject.embedded_commands[:bar]).to eq(nil)

    subject.remove_command(:bar)

    expect(subject.embedded_commands[:bar]).to eq(nil)
  end

  it "should coerce string names to symbols" do
    expect(subject.embedded_commands[:bar]).to eq(nil)

    command = double("TestCommand")
    subject.register_command(:bar, command)
    subject.remove_command("bar")

    expect(subject.embedded_commands[:bar]).to eq(nil)
    expect(subject.embedded_commands["bar"]).to eq(nil)
  end

end
