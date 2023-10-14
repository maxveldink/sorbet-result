# frozen_string_literal: true

require "bundler/gem_tasks"
require "minitest/test_task"

Minitest::TestTask.create do |t|
  t.test_globs = ["test/**/*_test.rb"]
end

require "standard/rake"

desc "Test Compiler output"
task :compiler do
  sh "./test/test_type_checker.sh"
end

desc "Run tapioca compilers"
task :tapioca do
  sh "bin/tapioca gem"
end

desc "Run Sorbet typechecker"
task :sorbet do
  sh "bundle exec srb tc"
end

task default: %i[standard:fix_unsafely sorbet test compiler]
