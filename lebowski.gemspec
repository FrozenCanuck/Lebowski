require "./lib/lebowski/version.rb"

Gem::Specification.new do |s|
  s.name = 'lebowski'
  s.version = Lebowski::Version::STRING
  s.authors = ['Michael Cohen', 'Apple Inc. and contributors']
  s.email = 'michael.lee.cohen@gmail.com'
  s.homepage = 'http://github.com/FrozenCanuck/Lebowski'
  s.summary = "Lebowski is a test integration automation framework for SproutCore"
  s.license = 'MIT'
  s.required_ruby_version = '>= 1.9.0'
  
  s.add_dependency 'rspec', '~> 2.5.0'
  s.add_dependency 'selenium-client', '~> 1.2.18'

  s.add_development_dependency 'rspec', '~> 2.5.0'
  s.add_development_dependency 'bundler', '~> 1.0.0'
  
  s.require_paths << 'lib'

  s.extra_rdoc_files  = ['History.md', 'README.md']

  s.files  = Dir.glob("lib/**/*")
  s.files += Dir.glob("resources/**/*")

  s.executables  = ['lebowski', 'lebowski-spec', 'lebowski-start-server']
  
  s.description  = <<-DESCRIPTION
  
  Lebowski is a test automation framework designed for full feature, integration, and 
  regression testing of SproutCore applications.
  
DESCRIPTION

  s.post_install_message = <<-POST_INSTALL_MESSAGE
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
