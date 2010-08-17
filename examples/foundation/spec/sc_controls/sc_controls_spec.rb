# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

# require '../../../../lib/lebowski/spec'
# 
# include Lebowski::Foundation
# include Lebowski::Foundation::Views

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

App = MainApplication.new \
  :app_root_path => "/sc_controls", 
  :app_name => "TestApp"

App.start do |app|
  app['mainPage.mainPane.isPaneAttached']
end

App.move_to 1, 1
App.resize_to 1024, 768

App.define 'controlsList', '#controls-list', ListView
App.define 'controlContainer', '#control-container', View

describe "SproutCore Controls Test" do
  
  it_should_behave_like "label views"
  it_should_behave_like "button views"
  it_should_behave_like "container views"
  it_should_behave_like "text field views"
  it_should_behave_like "checkbox views"
  it_should_behave_like "radio views"
  it_should_behave_like "select field views"
  it_should_behave_like "segmented views"
  it_should_behave_like "disclosure views"
  it_should_behave_like "list views"
  it_should_behave_like "web views"
  it_should_behave_like "select button views"
  it_should_behave_like "alert panes"
  it_should_behave_like "panel panes"
  it_should_behave_like "picker panes"
  it_should_behave_like "sheet panes"
  it_should_behave_like "menu panes"
  it_should_behave_like "palette panes"
  
end