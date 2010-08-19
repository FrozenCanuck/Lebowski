describe "Acquiring Opened Window and Nested Frames Application Context" do

  def framed_app_update_controls(frame, value)
    frame['resetButton'].click
    frame['label'].should have_value that_is_empty
    frame['textField'].should have_value that_is_empty
    frame['textField'].type value
    frame['updateButton'].click
    frame['label'].should have_value value
    frame['textField'].should have_value value
  end

  before(:all) do
    @reset_button = App['resetButton']
    @open_basic_app_win_button = App['openBasicAppWinButton']
    @open_framed_app_win_button = App['openFramedAppWinButton']
    @win_name_text_field = App['winNameTextField']
    @win_title_text_field = App['winTitleTextField']
    @win_anchor_text_field = App['winAnchorTextField']
    @web_view1 = App['webView1']
    @web_view2 = App['webView2']
    @web_view3 = App['webView3']
  end
  
  it "will access iframed apps in popup window" do
    
    @reset_button.click
    
    App.should have_current_application_context
    
    windows = App.opened_windows
    
    @win_name_text_field.type "foo"
    @open_framed_app_win_button.click
    
    window = windows.find_by_name "foo"
    
    window.acquire_application_context 'FramedApp'
    
    framed_app_update_controls window, 'foo'
    
    basic_app1 = window['webView1'].frame
    basic_app2 = window['webView2'].frame
    
    window.should have_current_application_context
    basic_app1.should_not have_current_application_context
    basic_app2.should_not have_current_application_context
    
    basic_app1.exec_in_context 'BasicApp' do |app|
      app['resetButton'].click
      app['counterLabel'].should have_value /counter: 0/i
      app['incButton'].click
      app['counterLabel'].should have_value /counter: 1/i
    end
    
    window.should have_current_application_context
    basic_app1.should_not have_current_application_context
    basic_app2.should_not have_current_application_context
    
    framed_app_update_controls window, 'bar'
    
    basic_app2.exec_in_context 'BasicApp' do |app|
      app['resetButton'].click
      app['counterLabel'].should have_value /counter: 0/i
      app['decButton'].click
      app['counterLabel'].should have_value /counter: -1/i
    end
    
    window.should have_current_application_context
    basic_app1.should_not have_current_application_context
    basic_app2.should_not have_current_application_context
    
    framed_app_update_controls window, 'mah'
    
    window.close
    window.should_not be_opened
    
    App.reset_application_context
    App.should have_current_application_context
  end
  
  it "will access iframed apps in popup window and main application" do
    
    App.reset_application_context
    @reset_button.click
    
    App.should have_current_application_context
    
    windows = App.opened_windows
    
    @win_name_text_field.type "foo"
    @open_framed_app_win_button.click
    
    window = windows.find_by_name "foo"
    
    window.acquire_application_context 'FramedApp'
    
    framed_app_update_controls window, 'foo'
    
    basic_app1 = window['webView1'].frame
    basic_app2 = window['webView2'].frame
    
    App.reset_application_context
    App.should have_current_application_context
    
    framed_app = @web_view3.frame
    
    framed_app.acquire_application_context 'FramedApp'
    
    basic_app3 = framed_app['webView1'].frame
    basic_app4 = framed_app['webView2'].frame
    
    App.reset_application_context
    App.should have_current_application_context
    
    basic_app1.exec_in_context 'BasicApp' do |app| 
      app['resetButton'].click
    end
    
    basic_app2.exec_in_context 'BasicApp' do |app| 
      app['resetButton'].click
    end
    
    basic_app3.exec_in_context 'BasicApp' do |app| 
      app['resetButton'].click
    end
    
    basic_app4.exec_in_context 'BasicApp' do |app| 
      app['resetButton'].click
    end
    
    App.should have_current_application_context
    
    basic_app1.exec_in_context 'BasicApp' do |app|
      app['counterLabel'].should have_value /counter: 0/i
      3.times { app['incButton'].click }
      app['counterLabel'].should have_value /counter: 3/i
    end
    
    App.should have_current_application_context
    
    basic_app3.exec_in_context 'BasicApp' do |app|
      app['counterLabel'].should have_value /counter: 0/i
      5.times { app['incButton'].click }
      app['counterLabel'].should have_value /counter: 5/i
    end
    
    App.should have_current_application_context
    
    basic_app2.exec_in_context 'BasicApp' do |app|
      app['counterLabel'].should have_value /counter: 0/i
      2.times { app['decButton'].click }
      app['counterLabel'].should have_value /counter: -2/i
    end
    
    App.should have_current_application_context
    
    basic_app4.exec_in_context 'BasicApp' do |app|
      app['counterLabel'].should have_value /counter: 0/i
      4.times{ app['decButton'].click }
      app['counterLabel'].should have_value /counter: -4/i
    end
    
    App.should have_current_application_context
    
    window.close
    window.should_not be_opened
    
    App.should have_current_application_context
    
  end
  
end