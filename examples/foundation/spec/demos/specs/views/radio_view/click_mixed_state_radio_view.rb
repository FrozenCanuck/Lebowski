describe "Radio View - Click Mixed State Tests" do
    
  before(:all) do
    show_control :radio_view
    @app = App.get_instance
    page = @app['radioViewsPage']
    @reset = page['resetButton']
    @radio_view = page['mixedStateRadioView', RadioView]
  end
  
  before(:each) do
    @reset.click
  end
      
  it "will click the first button" do
  
    @radio_view.should be_in_mixed_state
    @radio_view.should have_value that_contains 1
    @radio_view.should_not have_value that_contains 2
    @radio_view.should_not have_value that_contains 3
    
    @radio_view.buttons.click 'cat'
    
    @radio_view.should_not be_in_mixed_state
    @radio_view.should have_value 1
    
  end
  
  it "will click the second button" do
  
    @radio_view.should be_in_mixed_state
    @radio_view.should have_value that_contains 1
    @radio_view.should_not have_value that_contains 2
    @radio_view.should_not have_value that_contains 3
    
    @radio_view.buttons.click 'dog'
    
    @radio_view.should_not be_in_mixed_state
    @radio_view.should have_value 2
    
  end
  
end