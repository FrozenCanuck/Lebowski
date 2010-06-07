require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require './lib/lebowski'

Hoe.plugin :newgem

$hoe = Hoe.spec 'lebowski' do
  self.version = Lebowski::VERSION::STRING
  self.summary = Lebowski::VERSION::SUMMARY
  self.description = <<-DESCRIPTION
  
  Lebowski is a test automation framework designed for full feature, integration, 
  and regression testing of SproutCore applications.
  
DESCRIPTION

  self.developer 'Michael Cohen', 'michael.lee.cohen@gmail.com'
  self.rubyforge_name = 'lebowski'
  self.extra_deps << ['selenium-client', ">= 1.2.18"]
  self.extra_deps << ['rspec', ">= 1.3.0"]
  self.post_install_message = <<-POST_INSTALL_MESSAGE
#{'*'*50}

  Thank you for installing lebowski-#{Lebowski::VERSION::STRING}

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