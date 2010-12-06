# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

begin
  kind_of? ::Lebowski::Foundation
rescue Exception => e
  require_relative '../../../../lib/lebowski/rspec'  
  include Lebowski::Foundation
  include Lebowski::Foundation::Views
end

App = MainApplication.new \
  :app_root_path => "/sc_controls", 
  :app_name => "TestApp"

App.start do |app|
  app['mainPage.mainPane.isPaneAttached']
end

App.move_to 1, 1
App.resize_to 1024, 768

App.define_path 'controlsList', '#controls-list', ListView
App.define_path 'controlContainer', '#control-container', View

require 'views/label_views'
require 'views/button_views'
require 'views/container_views'
require 'views/text_field_views'
require 'views/checkbox_views'
require 'views/radio_views'
require 'views/select_field_views'
require 'views/segmented_views'
require 'views/disclosure_views'
require 'views/list_views'
require 'views/web_views'
require 'views/select_button_views'
require 'panes/alert_panes'
require 'panes/panel_panes'
require 'panes/picker_panes'
require 'panes/sheet_panes'
require 'panes/menu_panes'
require 'panes/palette_panes'