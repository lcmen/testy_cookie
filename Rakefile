$LOAD_PATH.unshift(File.expand_path("test", __dir__))

require "bundler/setup"
require "bundler/gem_tasks"
require "rails/plugin/test"

task :test_dummy do
  Dir.chdir("test/dummy") do
    system "bin/rake test"
  end
end

task :test_all do
  Rake::Task["test"].invoke
  Rake::Task[:test_dummy].invoke
end

task default: :test_all
