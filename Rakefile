$:.unshift 'lib'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

RACK_TEST_VERSION = "0.0.1"

desc 'Default: run unit tests.'
task :default => :test

desc 'Build and install the gem (useful for development purposes).'
task :install do
  require 'rack/test'
  system "gem build rack-test.gemspec"
  system "sudo gem uninstall rack-test"
  system "sudo gem install --local --no-rdoc --no-ri rack-test-#{RACK_TEST_VERSION}.gem"
  system "rm rack-test-*.gem"
end

desc 'Show the file list for the gemspec file'
task :files do
  puts "Files:\n #{Dir['**/*'].reject {|f| File.directory?(f)}.sort.inspect}"
  puts "Test files:\n #{Dir['test/**/*_test.rb'].reject {|f| File.directory?(f)}.sort.inspect}"
end