describe "Aquiring Nested Frames Application Context" do
  
  def frame_app_update_controls(frame, value)
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
    @web_view3 = App['webView3']
  end
  
  it "will access the FramedApp" do
    @reset_button.click
    
    frame = @web_view3.frame
    
    frame.should_not have_current_application_context
    App.should have_current_application_context
    
    frame.acquire_application_context 'FramedApp'
    
    frame.should have_current_application_context
    App.should_not have_current_application_context
    
    frame_app_update_controls frame, 'foobar'
  
    App.reset_application_context
    
    App.should have_current_application_context
    frame.should_not have_current_application_context
  end
  
  it "will access the BasicApp within the FramedApp" do
    @reset_button.click
    
    framed_app = @web_view3.frame
    
    framed_app.should_not have_current_application_context
    App.should have_current_application_context
    
    framed_app.acquire_application_context 'FramedApp'
    
    frame_app_update_controls framed_app, 'foo'
    
    basic_app = framed_app['webView1'].frame
    
    framed_app.should have_current_application_context
    basic_app.should_not have_current_application_context
    
    basic_app.acquire_application_context 'BasicApp'
    
    framed_app.should_not have_current_application_context
    basic_app.should have_current_application_context
    
    basic_app['resetButton'].click
    basic_app['counterLabel'].should have_value /counter: 0/i
    basic_app['incButton'].click
    basic_app['counterLabel'].should have_value /counter: 1/i
    
    framed_app.acquire_application_context 'FramedApp'
    
    framed_app.should have_current_application_context
    basic_app.should_not have_current_application_context
    
    frame_app_update_controls framed_app, 'bar'
    
    basic_app.acquire_application_context 'BasicApp'
    
    framed_app.should_not have_current_application_context
    basic_app.should have_current_application_context
    
    basic_app['counterLabel'].should have_value /counter: 1/i
    basic_app['incButton'].click
    basic_app['counterLabel'].should have_value /counter: 2/i
    
    App.reset_application_context
    
    App.should have_current_application_context
    framed_app.should_not have_current_application_context
    basic_app.should_not have_current_application_context
  end
  
  it "will access both iframed BasicApp applications within the FramedApp application" do
  
    @reset_button.click
    
    framed_app = @web_view3.frame
    
    framed_app.should_not have_current_application_context
    App.should have_current_application_context
    
    framed_app.acquire_application_context 'FramedApp'
    
    frame_app_update_controls framed_app, 'aaa'
    
    basic_app1 = framed_app['webView1'].frame
    basic_app2 = framed_app['webView2'].frame
    
    basic_app1.acquire_application_context 'BasicApp'
    
    basic_app1['resetButton'].click
    basic_app1['counterLabel'].should have_value /counter: 0/i
    5.times { basic_app1['incButton'].click }
    basic_app1['counterLabel'].should have_value /counter: 5/i
  
    basic_app2.acquire_application_context 'BasicApp'
    
    basic_app2['resetButton'].click
    basic_app2['counterLabel'].should have_value /counter: 0/i
    5.times { basic_app2['decButton'].click }
    basic_app2['counterLabel'].should have_value /counter: -5/i
    
    basic_app1.acquire_application_context 'BasicApp'
    
    basic_app1['counterLabel'].should have_value /counter: 5/i
    5.times { basic_app1['incButton'].click }
    basic_app1['counterLabel'].should have_value /counter: 10/i
  
    basic_app2.acquire_application_context 'BasicApp'
    
    basic_app2['counterLabel'].should have_value /counter: -5/i
    5.times { basic_app2['decButton'].click }
    basic_app2['counterLabel'].should have_value /counter: -10/i
    
    framed_app.acquire_application_context 'FramedApp'
    
    frame_app_update_controls framed_app, 'bbb'
    
    App.reset_application_context
  
  end
  
  it "will access iframed BasicApp applications using exec_in_context" do
    
    @reset_button.click
    
    framed_app = @web_view3.frame
    
    framed_app.should_not have_current_application_context
    App.should have_current_application_context
    
    framed_app.acquire_application_context 'FramedApp'
    
    frame_app_update_controls framed_app, 'xxx'
    
    basic_app1 = framed_app['webView1'].frame
    basic_app2 = framed_app['webView2'].frame
    
    framed_app.should have_current_application_context
    basic_app1.should_not have_current_application_context
    basic_app2.should_not have_current_application_context
    
    basic_app1.exec_in_context 'BasicApp' do |app|
      app['resetButton'].click
      app['counterLabel'].should have_value /counter: 0/i
      app['incButton'].click
      app['counterLabel'].should have_value /counter: 1/i
    end
    
    framed_app.should have_current_application_context
    basic_app1.should_not have_current_application_context
    basic_app2.should_not have_current_application_context
    
    basic_app2.exec_in_context 'BasicApp' do |app|
      app['resetButton'].click
      app['counterLabel'].should have_value /counter: 0/i
      app['decButton'].click
      app['counterLabel'].should have_value /counter: -1/i
    end
    
    framed_app.should have_current_application_context
    basic_app1.should_not have_current_application_context
    basic_app2.should_not have_current_application_context
    
    App.reset_application_context
    
  end
  
end