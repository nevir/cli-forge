desc "Boot up a console w/ cli-forge preloaded"
task :console do
  require "cli-forge"
  require "pry"

  Pry.start
end
