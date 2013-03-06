namespace :spec do

  desc "Runs tests with code mutation"
  task :mutate, [:focus_on] do |t, args|
    next unless mutant_supported?

    require "cli_forge"
    require "mutant"
    require "mutant/constants"
    require "mutant/mutation/filter/regexp"

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
      :filter   => filter_for_specs,
      :reporter => Mutant::Reporter::CLI.new(config)
    )

    ENV["MUTATION"] = "yes"
    if Mutant::Runner.run(config).fail?
      exit 1
    end
  end

  def mutant_supported?
    return false unless RUBY_VERSION.start_with?("1.9")
    # TODO: Rubinius crashes under mutant:
    # https://github.com/rubinius/rubinius/issues/2186
    return false if RUBY_ENGINE == "rbx"

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
      require path[/lib.(cli_forge..+)\.rb$/, 1]
    end

    unit_folders   = Dir["spec/unit/**/*/"].map { |f| f[/^spec.unit.(.+)./, 1] }
    unit_constants = unit_folders.map do |folder|
      folder.gsub(File::SEPARATOR, "::").gsub("_", "").downcase
    end

    Mutant::Matcher::ObjectSpace.new(/^CLIForge/)
  end

  def spec_filter_klass
    # Avoid loading w/ rake
    filter_klass = Class.new(Mutant::Mutation::Filter)
    filter_klass.class_eval do
      def initialize(regexp)
        @regexp = regexp
      end

      def match?(mutation)
        @regexp =~ mutation.subject.matcher.identification
      end
    end

    filter_klass
  end

  def filter_for_specs
    # Only run mutations for methods that we have specs for.  Basic code
    # coverage can cover simple cases.
    spec_symbols = Dir["#{PROJECT_ROOT}/spec/unit/**/*_spec.rb"].map { |path|
      path_to_symbol(path[/spec.unit.(.+)_spec\.rb$/, 1])
    }
    safe_symbols = spec_symbols.map { |s| Regexp.escape(s) }

    spec_filter_klass.new(/^(#{safe_symbols.join("|")})$/i)
  end

  # convert a spec path back to a (case insensitive) symbol
  def path_to_symbol(spec_path)
    parts  = spec_path.split(/[\/\\]/)
    method = symbolicate_method_name(parts.pop)
    if parts.last == "class_methods"
      method = ".#{method}"
      parts.pop
    else
      method = "##{method}"
    end

    parts.join("::").gsub("_", "") + method
  end

  # https://github.com/mbj/mutant/blob/master/lib/mutant/constants.rb
  def postfix_expansions
    # @postfix_expansions ||= Mutant::METHOD_POSTFIX_EXPANSIONS.invert
    @postfix_expansions ||= {
      '_predicate' => '?',
      '_writer'    => '=',
      '_bang'      => '!'
    }
  end

  def operator_expansions
    @operator_expansions ||= Mutant::OPERATOR_EXPANSIONS.invert
  end

  def symbolicate_method_name(method_name)
    operator = operator_expansions[method_name.to_sym]
    return operator.to_s if operator

    postfix_expansions.each do |postfix, symbol|
      if method_name.end_with? postfix
        method_name = method_name[0...-postfix.size] + symbol.to_s
      end
    end

    method_name
  end

end
