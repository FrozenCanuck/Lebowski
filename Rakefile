require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'

require 'jeweler'
require './lib/lebowski/version.rb'

Jeweler::Tasks.new do |gem|
  gem.name = 'lebowski'
  gem.version = Lebowski::Version::STRING
  gem.homepage = 'http://github.com/FrozenCanuck/Lebowski'
  gem.license = 'MIT'
  gem.summary = 'A test automation framework for SproutCore'
  gem.description = <<-DESCRIPTION
  
  Lebowski is a test automation framework designed for full feature, integration, and 
  regression testing of SproutCore applications.
  
DESCRIPTION
  gem.email = 'michael.lee.cohen@gmail.com'
  gem.authors = ['Michael Cohen']
  gem.add_dependency 'selenium-client', '~> 1.2.18'
  gem.add_dependency 'rspec', '~> 2.1.0'
  gem.add_development_dependency 'rspec', '~> 2.1.0'
  gem.add_development_dependency 'bundler', '~> 1.0.0'
  gem.add_development_dependency 'jeweler', '~> 1.5.1'
  gem.add_development_dependency 'rcov', '>= 0'
  gem.executables = ['lebowski', 'lebowski-spec', 'lebowski-start-server']
  gem.files.exclude 'examples'
  gem.test_files = []
  gem.post_install_message = <<-POST_INSTALL_MESSAGE
#{'*'*50}

  Thank you for installing lebowski-#{Lebowski::Version::STRING}

  Please be sure to read the README.md and History.md
  for useful information on how to use this framework 
  and about this release.
  
  For more information go to the following web sites:
  
    http://github.com/FrozenCanuck/Lebowski
    http://frozencanuck.wordpress.com
    http://www.sproutcore.com

#{'*'*50}
POST_INSTALL_MESSAGE
end
Jeweler::RubygemsDotOrgTasks.new