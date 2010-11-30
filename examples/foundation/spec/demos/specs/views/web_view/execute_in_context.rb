describe "Web View Test" do
    
  before(:all) do
    show_control :web_view
    @first_web_view = App['#first-web-view', WebView]
    @second_web_view = App['#second-web-view', WebView]
    
    counter = App['webViewsPage.mainView.counter', View]
    @counter_label = counter['label', LabelView]
    @increment_button = counter['incButton', ButtonView]
    @reset_button = counter['resetButton', ButtonView]
  end
  
  it "will execute block of logic within the context of a web view" do
  
    @reset_button.click
    @counter_label.should have_value /counter: 0/i
    
    @first_web_view.frame.exec_in_context('BasicApp') do |app|
      reset_button = app['#reset-button']
      inc_button = app['#increment-button']
      label = app['#counter-label']
      
      reset_button.click
      label.should have_value /counter: 0/i
      
      (1..2).each { inc_button.click }
      label.should have_value /counter: 2/i
    end
    
    @increment_button.click
    @counter_label.should have_value /counter: 1/i
    
    @second_web_view.frame.exec_in_context('BasicApp') do |app|
      reset_button = app['#reset-button']
      dec_button = app['#decrement-button']
      label = app['#counter-label']
      
      reset_button.click
      label.should have_value /counter: 0/i
      
      (1..2).each { dec_button.click }
      label.should have_value /counter: -2/i
    end
    
    @increment_button.click
    @counter_label.should have_value /counter: 2/i
    
  end

end