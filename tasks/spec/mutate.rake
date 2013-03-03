namespace :spec do

  def mutant_supported?
    return false unless RUBY_VERSION.start_with?("1.9")

    begin
      return false unless RUBY_ENGINE == "ruby" || RUBY_ENGINE == "rbx"
    rescue NameError
      return false
    end

    true
  end

  # Also preloads the related constants
  def matcher_for_filter(filter)
    # Method on CLIForge?
    if filter.start_with?(".") || filter.start_with?("#")
      matcher = Mutant::Matcher.from_string("::CLIForge#{filter}")

    # Or regular constant?
    else
      matcher = Mutant::Matcher.from_string("::CLIForge::#{filter}")
      # Force that symbol to load
      const = CLIForge
      filter[/^[^#\.]+/].split("::").each do |const_name|
        const = const.const_get(const_name.to_sym)
      end
    end

    matcher
  end

  def all_matcher
    # Force everything to load
    Dir["#{PROJECT_ROOT}/lib/cli_forge/**/*.rb"].each do |path|
      require "cli_forge/#{File.basename(path, ".rb")}"
    end

    Mutant::Matcher::ObjectSpace.new(/\ACLIForge.*/)
  end

  desc "Runs tests with code mutation"
  task :mutate, [:focus_on] do |t, args|
    next unless mutant_supported?

    require "cli_forge"
    require "mutant"

    # You can focus on a particular symbol/method by passing it to the task:
    # rake spec:mutate[AutoloadConvention#const_missing], for example.
    if args.focus_on
      matcher = matcher_for_filter(args.focus_on)
    # Otherwise we're doing a full mutation suite
    else
      matcher = all_matcher
    end

    # Mutant doesn't have a public scripting API yet; so we're cheating.
    config = {}
    def config.method_missing(sym)
      self[sym]
    end

    config.merge!(
      :strategy => Mutant::Strategy::Rspec::DM2.new(config),
      :killer   => Mutant::Killer::Rspec,
      :matcher  => matcher,
      :filter   => Mutant::Mutation::Filter::ALL,
      :reporter => Mutant::Reporter::CLI.new(config)
    )

    ENV["MUTATION"] = "yes"
    if Mutant::Runner.run(config).fail?
      exit 1
    end
  end

end
