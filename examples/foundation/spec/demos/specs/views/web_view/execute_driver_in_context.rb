describe "Web View Test" do
    
  before(:all) do
    show_control :web_view
    
    @app = App.get_instance
    
    @first_web_view = @app['#first-web-view', WebView]
    @second_web_view = @app['#second-web-view', WebView]
    
    counter = @app['webViewsPage.mainView.counter', View]
    @counter_label = counter['label', LabelView]
    @increment_button = counter['incButton', ButtonView]
    @reset = counter['resetButton', ButtonView]
  end
  
  before(:each) do
    @reset.click
  end
  
  it "will execute block of driver commands within the context of a web view" do
    
    @counter_label.should have_value /counter: 0/i
    
    @first_web_view.frame.exec_driver_in_context do |driver|
      driver.mouse_down "css=#reset-button"
      driver.mouse_up "css=#reset-button"
      
      text = driver.get_text "css=#counter-label"
      text.should =~ /counter: 0/i
      
      driver.mouse_down "css=#decrement-button"
      driver.mouse_up "css=#decrement-button"
      
      text = driver.get_text "css=#counter-label"
      text.should =~ /counter: -1/i
    end
    
    @counter_label.should have_value /counter: 0/i
    @increment_button.click
    @counter_label.should have_value /counter: 1/i
    
  end

end