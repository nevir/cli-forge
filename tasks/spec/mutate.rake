namespace :spec do

  desc "Runs tests with code mutation"
  task :mutate, [:focus_on] do |t, args|
    begin
      require "mutant"
    rescue LoadError
      # We rely on the Gemfile to guard against loading mutant on an unsupported
      # platform
      next
    end

    require "cli_forge"

    # You can focus on a particular symbol/method by passing it to the task:
    # rake spec:mutate[AutoloadConvention#const_missing], for example.
    if args.focus_on
      matcher = Mutant::Matcher.from_string("::CLIForge::#{args.focus_on}")
    else
      matcher = Mutant::Matcher::ObjectSpace.new(/\ACLIForge(::|#|\.).+\Z/)
    end

    # Mutant doesn't have a public scripting API yet; so we're cheating.
    config = {}
    def config.method_missing(sym)
      self[sym]
    end

    config.merge!(
      strategy: Mutant::Strategy::Rspec::DM2.new(config),
      killer:   Mutant::Killer::Rspec,
      matcher:  matcher,
      filter:   Mutant::Mutation::Filter::ALL,
      reporter: Mutant::Reporter::CLI.new(config),
    )

    ENV["MUTATION"] = "yes"
    if Mutant::Runner.run(config).fail?
      exit 1
    end
  end

end
