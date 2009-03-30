$:.unshift 'lib'
require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'spec/rake/spectask'

RACK_TEST_VERSION = "0.0.1"

task :default => :spec

desc 'Build and install the gem (useful for development purposes).'
task :install do
  require 'rack/test'
  system "gem build rack-test.gemspec"
  system "sudo gem uninstall rack-test"
  system "sudo gem install --local --no-rdoc --no-ri rack-test-#{RACK_TEST_VERSION}.gem"
  system "rm rack-test-*.gem"
end

Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = %w(-fs --color)
end

desc 'Show the file list for the gemspec file'
task :files do
  puts "Files:\n #{Dir['**/*'].reject {|f| File.directory?(f)}.sort.inspect}"
  puts "Test files:\n #{Dir['spec/**/*_spec.rb'].reject {|f| File.directory?(f)}.sort.inspect}"
end