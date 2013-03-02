#!/usr/bin/env rake
require "bundler/gem_tasks"

PROJECT_PATH = File.expand_path("..", __FILE__)
Dir["#{PROJECT_PATH}/tasks/**/*.rake"].each do |path|
  load path
end

$LOAD_PATH.unshift File.join(PROJECT_PATH, "lib")


desc "Run the full test suite"
task :default => [:spec, :"spec:mutate"]
