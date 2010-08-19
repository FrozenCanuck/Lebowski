describe "Aquiring Frame Application Context" do
  
  before(:all) do
    @reset_button = App['resetButton']
    @web_view1 = App['webView1']
    @web_view2 = App['webView2']
  end
  
  it "will access the first web view's frame and access the frame's controls" do
    @reset_button.click
    
    frame = @web_view1.frame
    
    frame.should_not have_current_application_context
    App.should have_current_application_context
    
    frame.acquire_application_context 'BasicApp'
    
    frame.should have_current_application_context
    App.should_not have_current_application_context
    
    frame['counterLabel'].should have_value /counter: 0/i
    frame['incButton'].click
    frame['counterLabel'].should have_value /counter: 1/i
    
    frame['#counter-label'].should have_value /counter: 1/i
    frame['#increment-button'].click
    frame['#counter-label'].should have_value /counter: 2/i
    
    frame['mainPage.mainPane.label'].should have_value /counter: 2/i
    frame['mainPage.mainPane.increment'].click
    frame['mainPage.mainPane.label'].should have_value /counter: 3/i
    
    App.reset_application_context
    
    App.should have_current_application_context
    frame.should_not have_current_application_context
  end
  
  it "will access the second web view's frame and access the frame's controls" do
    @reset_button.click
    
    frame = @web_view2.frame
    
    frame.should_not have_current_application_context
    App.should have_current_application_context
    
    frame.exec_in_context 'BasicApp' do |frame|
      frame['#counter-label'].should have_value /counter: 0/i
      frame['#decrement-button'].click
      frame['#counter-label'].should have_value /counter: -1/i
    end
    
    frame.should_not have_current_application_context
    App.should have_current_application_context
  end
  
  it "will access control in the second web view using the driver" do
    @reset_button.click
    
    frame = @web_view2.frame
    
    frame.should_not have_current_application_context
    App.should have_current_application_context
    
    frame.exec_driver_in_context do |driver|
      driver.mouse_down "css=#reset-button"
      driver.mouse_up "css=#reset-button"
      
      text = driver.get_text "css=#counter-label"
      text.should =~ /counter: 0/i
      
      driver.mouse_down "css=#decrement-button"
      driver.mouse_up "css=#decrement-button"
      
      text = driver.get_text "css=#counter-label"
      text.should =~ /counter: -1/i
    end
    
    frame.should_not have_current_application_context
    App.should have_current_application_context
  end
  
  it "will access both web views' frames and access the frames' controls" do
    @reset_button.click
    
    frame1 = @web_view1.frame
    frame2 = @web_view2.frame
    
    frame1.should_not have_current_application_context
    frame2.should_not have_current_application_context
    App.should have_current_application_context
    
    frame1.acquire_application_context 'BasicApp'
    
    frame1.should have_current_application_context
    frame2.should_not have_current_application_context
    App.should_not have_current_application_context
    
    frame1['#reset-button'].click
    frame1['#counter-label'].should have_value /counter: 0/i
    frame1['#increment-button'].click
    frame1['#counter-label'].should have_value /counter: 1/i
    
    frame2.acquire_application_context 'BasicApp'
    
    frame1.should_not have_current_application_context
    frame2.should have_current_application_context
    App.should_not have_current_application_context
    
    frame2['#reset-button'].click
    frame2['#counter-label'].should have_value /counter: 0/i
    frame2['#decrement-button'].click
    frame2['#counter-label'].should have_value /counter: -1/i
    
    frame1.acquire_application_context 'BasicApp'
    
    frame1.should have_current_application_context
    frame2.should_not have_current_application_context
    App.should_not have_current_application_context
    
    frame1['#counter-label'].should have_value /counter: 1/i
    frame1['#increment-button'].click
    frame1['#counter-label'].should have_value /counter: 2/i
    
    frame2.acquire_application_context 'BasicApp'
    
    frame1.should_not have_current_application_context
    frame2.should have_current_application_context
    App.should_not have_current_application_context
    
    frame2['#counter-label'].should have_value /counter: -1/i
    frame2['#decrement-button'].click
    frame2['#counter-label'].should have_value /counter: -2/i
    
    App.reset_application_context
    
    frame1.should_not have_current_application_context
    frame2.should_not have_current_application_context
    App.should have_current_application_context
  end

end