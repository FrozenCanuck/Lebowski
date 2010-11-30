if DEBUG
  require_relative '../../../../lib/lebowski/rspec'

  include Lebowski::Foundation
  include Lebowski::Foundation::Views
end

App = MainApplication.new \
  :app_root_path => "/sc_controls", 
  :app_name => "TestApp",
  :browser => :safari

App.start do |app|
  app['mainPage.mainPane.isPaneAttached']
end

App.move_to 1, 1
App.resize_to 1024, 768

App.define_path 'controlsList', '#controls-list', ListView
App.define_path 'controlContainer', '#control-container', View