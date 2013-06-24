require "bundler/gem_tasks"
require "rspec/core"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.fail_on_error = false
  spec.rspec_opts = "--color --format documentation"
  spec.pattern = FileList["spec/**/*_spec.rb"]
end

task default: :spec
