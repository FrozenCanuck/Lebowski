# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

# require '../../../../lib/lebowski/spec'
# 
# include Lebowski::Foundation
# include Lebowski::Foundation::Views

App = MainApplication.new \
  :app_root_path => "/application_context", 
  :app_name => "TestApp",
  :browser => :firefox

App.define_path 'resetButton', '#reset-button', ButtonView
App.define_path 'openBasicAppWinButton', '#open-window.openBasicAppButton', ButtonView
App.define_path 'openFramedAppWinButton', '#open-window.openFramedAppButton', ButtonView
App.define_path 'winNameTextField', '#open-window.nameTextField', TextFieldView
App.define_path 'winTitleTextField', '#open-window.titleTextField', TextFieldView
App.define_path 'winAnchorTextField', '#open-window.anchorTextField', TextFieldView
App.define_path 'webView1', '#web-view1', WebView
App.define_path 'webView2', '#web-view2', WebView
App.define_path 'webView3', '#web-view3', WebView

App.define_app_name 'BasicApp'

App.define_paths_for 'BasicApp' do |app|
  app.define_path 'counterLabel', '#counter-label', LabelView
  app.define_path 'incButton', '#increment-button', ButtonView
  app.define_path 'decButton', '#decrement-button', ButtonView
  app.define_path 'resetButton', '#reset-button', ButtonView
end

App.define_app_name 'FramedApp'

App.define_paths_for 'FramedApp' do |app|
  app.define_path 'main', 'mainPage.mainPane', MainPane
  app.define_path 'group', 'main.group', View
  app.define_path 'resetButton', 'group.reset', ButtonView
  app.define_path 'updateButton', 'group.update', ButtonView
  app.define_path 'label', 'group.label', LabelView
  app.define_path 'textField', 'group.textField', TextFieldView
  app.define_path 'webView1', 'main.web1', WebView
  app.define_path 'webView2', 'main.web2', WebView
end

App.start do |app|
  app['mainPage.mainPane.isPaneAttached']
end

App.move_to 1, 1
App.resize_to 1024, 768

require 'opened_windows'
require 'basic_frames'
require 'windows_and_frames'
require 'nested_frames'
require 'windows_and_nested_frames'
require 'cross_app_context_boundary'