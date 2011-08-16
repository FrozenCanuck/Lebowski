describe "Radio View - Click Button By Index Tests" do
    
  before(:all) do
    show_control :radio_view
    @app = App.get_instance
    page = @app['radioViewsPage']
    @reset = page['resetButton']
    @radio_view = page['horizontalRadioView', RadioView]
  end
  
  before(:each) do
    @reset.click
  end
      
  it "will click radio view's buttons by index" do

    @radio_view.buttons.should have_count 3
    
    @radio_view.buttons.should have_none_selected
    @radio_view.buttons.should_not have_any_selected
    @radio_view.buttons.should_not have_one_selected
    @radio_view.should have_value that_is_empty
    
    @radio_view.buttons.click 0
    
    @radio_view.buttons.should have_one_selected
    @radio_view.buttons.should have_selected 0
    @radio_view.buttons.should have_selected 'square'
    @radio_view.should have_value 'square'
    
    @radio_view.buttons.click 1
    
    @radio_view.buttons.should have_one_selected
    @radio_view.buttons.should have_selected 1
    @radio_view.buttons.should have_selected 'circle'
    @radio_view.should have_value 'circle'
    
    @radio_view.buttons.click 2
    
    @radio_view.buttons.should have_one_selected
    @radio_view.buttons.should have_selected 2
    @radio_view.buttons.should have_selected 'triangle'
    @radio_view.should have_value 'triangle'
    
    @radio_view.should_not have_value that_is_empty
    
  end
  
end