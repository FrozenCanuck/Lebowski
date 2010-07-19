shared_examples_for "web views" do
  
  describe "Web Views" do
    
    before(:all) do
      App['controlsList'].item_views.find_first({ :name => 'SC.WebView' }).select
      @first_web_view = App['#first-web-view', WebView]
      @second_web_view = App['#second-web-view', WebView]
      
      counter = App['webViewsPage.mainView.counter', View]
      @counter_label = counter['label', LabelView]
      @increment_button = counter['incButton', ButtonView]
      @reset_button = counter['resetButton', ButtonView]
    end
    
    it "will switch application context between web views" do
      
      @reset_button.click
      @counter_label.should have_value /counter: 0/i
      
      (1..3).each { @increment_button.click }
      @counter_label.should have_value /counter: 3/i
      
      frame1 = @first_web_view.frame
      frame1.acquire_application_context 'BasicApp'
      
      button = frame1['#increment-button']
      button.click
      
      label = frame1['#counter-label']
      label.should have_value /counter: 1/i
      
      App.reset_application_context
      
      frame2 = @second_web_view.frame
      frame2.acquire_application_context 'BasicApp'
      
      button = frame2['#decrement-button']
      button.click
      
      label = frame2['#counter-label']
      label.should have_value /counter: -1/i
      
      App.reset_application_context
      
      @counter_label.should have_value /counter: 3/i
    
      (1..3).each { @increment_button.click }
      @counter_label.should have_value /counter: 6/i
      
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
    
    it "will execute block of driver commands within the context of a web view" do
      
      @reset_button.click
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
  
end