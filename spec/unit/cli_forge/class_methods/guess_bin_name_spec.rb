describe CLIForge, ".guess_bin_name" do

  it "should return the basename of $0" do
    old_name = $0

    begin
      $0 = "/foo/bar/baz-biff"
      expect(described_class.send(:guess_bin_name)).to eq("baz-biff")

    ensure
      $0 = old_name
    end
  end

  it "should freak out if we don't have a reasonable $0"

end
