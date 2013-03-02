source "https://rubygems.org"

gemspec

# No gem would be complete without rake tasks - http://rake.rubyforge.org/
# MIT License - http://rake.rubyforge.org/files/MIT-LICENSE.html
gem "rake", "~> 10.0"

group :test do
  # Our preferred unit testing library - https://www.relishapp.com/rspec
  # MIT License - https://github.com/rspec/rspec/blob/master/License.txt
  gem "rspec", "~> 2.13"

  # The preferred code mutation library.
  # MIT License - https://github.com/mbj/mutant/blob/master/LICENSE
  gem "mutant", ">= 0.2.20",  "< 1.0.0"

  # Cover all the things - https://github.com/colszowka/simplecov
  # MIT License - https://github.com/colszowka/simplecov/blob/master/LICENSE
  gem "simplecov", "~> 0.7"

  # Code coverage in badge form - https://coveralls.io/
  # MIT License - https://github.com/lemurheavy/coveralls-ruby/blob/master/LICENSE
  gem "coveralls", "~> 0.6", :require => false
end

group :debugging do
  # A REPL like IRB, but much better - http://pryrepl.org/
  # MIT License - https://github.com/pry/pry/blob/master/LICENSE
  gem "pry", "~> 0.9"

  # Don't leave home without a debugger!
  # Two Clause BSD License - https://github.com/cldwalker/debugger/blob/master/LICENSE
  gem "debugger", "~> 1.3", :platforms => :mri
end

group :development do
  # A generic file system event handler; spin it up and see the tests fly
  # MIT License - https://github.com/guard/guard/blob/master/LICENSE
  gem "guard", "~> 1.6"

  # Guard configuration to manage Gemfile updates
  # MIT License - https://github.com/guard/guard-bundler/blob/master/LICENSE
  gem "guard-bundler", "~> 1.0"

  # Guard configuration to manage our spork drb environments
  # MIT License - https://github.com/guard/guard-spork/blob/master/LICENSE
  gem "guard-spork", "~> 1.5"

  # Guard configuration & hooks for rspec
  # MIT License - https://github.com/guard/guard-rspec/blob/master/LICENSE
  gem "guard-rspec", "~> 2.4"

  # Growl notification protocol gem - give us fancy warnings when things go awry
  # MIT License - https://github.com/snaka/ruby_gntp/blob/master/lib/ruby_gntp.rb
  gem "ruby_gntp", "~> 0.3"

  # FS event hooks for OS X
  # MIT License - https://github.com/thibaudgg/rb-fsevent/blob/master/LICENSE
  gem "rb-fsevent", "~> 0.9", :require => RUBY_PLATFORM.include?("darwin") && "rb-fsevent"
end
