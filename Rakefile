# frozen_string_literal: true

require 'rspec/core/rake_task'
require 'rubocop/rake_task'

task default: %i[test rubocop]

task :test do
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = '--format documentation'
    t.pattern = 'spec/**/*_spec.rb'
  end
  Rake::Task['spec'].execute
end

task :rubocop do
  RuboCop::RakeTask.new(:rubocop) do |t|
    t.options = ['--display-cop-names', '--auto-correct-all']
  end
end
