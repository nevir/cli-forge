namespace :spec do

  desc "Run the tests in CI mode"
  task :ci do
    prev = ENV["CONTINUOUS_INTEGRATION"]
    ENV["CONTINUOUS_INTEGRATION"] = "yes"

    # Simplecov doesn't support 1.8
    unless RUBY_VERSION.start_with? "1.8"
      Rake::Task["spec:coverage"].execute
    else
      Rake::Task["spec"].execute
    end

    Rake::Task["spec:mutate"].execute

    ENV["CONTINUOUS_INTEGRATION"] = prev
  end

end
