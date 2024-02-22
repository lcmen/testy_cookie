$LOAD_PATH.unshift(File.expand_path("test", __dir__))

require "bundler/setup"
require "bundler/gem_tasks"
require "rails/plugin/test"

task :test_dummy do
  Dir.chdir("test/dummy") do
    system "bin/rake test"
  end
end

Rake::Task[:test].enhance [:test_dummy]

task default: :test
