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
  
  it "will switch application context between web views" do
    
    @counter_label.should have_value /counter: 0/i
    
    (1..3).each { @increment_button.click }
    @counter_label.should have_value /counter: 3/i
    
    frame1 = @first_web_view.frame
    frame1.acquire_application_context 'BasicApp'
    
    reset_button = frame1['#reset-button']
    reset_button.click
    
    button = frame1['#increment-button']
    button.click
    
    label = frame1['#counter-label']
    label.should have_value /counter: 1/i
    
    @app.reset_application_context
    
    frame2 = @second_web_view.frame
    frame2.acquire_application_context 'BasicApp'
    
    reset_button = frame2['#reset-button']
    reset_button.click
    
    button = frame2['#decrement-button']
    button.click
    
    label = frame2['#counter-label']
    label.should have_value /counter: -1/i
    
    @app.reset_application_context
    
    @counter_label.should have_value /counter: 3/i
  
    (1..3).each { @increment_button.click }
    @counter_label.should have_value /counter: 6/i
    
  end

end