# Touching any of these files should cause the entire test suite to reload.
GLOBAL_SPEC_FILES = [
  ".rspec",
  %r{^spec/.*_helper\.rb$},
  %r{^spec/common/.*\.rb$},
  "lib/cli_forge.rb",
  "lib/cli_forge/autoload_convention.rb",
]

def specs_for_path(path)
  ["spec/unit/#{path}_spec.rb", Dir["spec/unit/#{path}/**/*_spec.rb"]].flatten
end

guard "bundler" do
  watch("Gemfile")
  watch(/^.+\.gemspec/)
end

guard "spork", rspec_port: 2733 do
  watch("Gemfile")
  watch("Gemfile.lock")

  GLOBAL_SPEC_FILES.each do |pattern|
    watch(pattern) { :rspec }
  end
end

guard "rspec", cli: "--drb --drb-port 2733" do
  GLOBAL_SPEC_FILES.each do |pattern|
    watch(pattern) { "spec" }
  end

  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |m| specs_for_path(m[1]) }
end
