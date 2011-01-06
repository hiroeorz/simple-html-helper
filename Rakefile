require 'rubygems'
require 'rake'
require "yaml"

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "simple-html-helper"
    gem.summary = %Q{todo is not eixst}
    gem.email = "hiroe.orz@gmail.com"
    gem.homepage = "http://github.com/hiroeorz/simple-html-helper"
    gem.authors = ["hiroeorz"]

    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = ['-cfd --backtrace']
end


task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "simple-html-helper #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

