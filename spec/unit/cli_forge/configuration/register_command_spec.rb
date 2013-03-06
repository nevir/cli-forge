describe CLIForge::Configuration, "#register_command" do

  it "should register the command" do
    command = double("TestCommand")
    subject.register_command(:foo, command)

    expect(subject.embedded_commands[:foo]).to be(command)
  end

  it "should coerce string names to symbols" do
    command = double("TestCommand")
    subject.register_command("foo", command)

    expect(subject.embedded_commands[:foo]).to be(command)
  end

  it "should allow you to register over existing commands" do
    command1 = double("TestCommand1")
    command2 = double("TestCommand2")
    subject.register_command(:foo, command1)
    subject.register_command(:foo, command2)

    expect(subject.embedded_commands[:foo]).to be(command2)
  end

end
