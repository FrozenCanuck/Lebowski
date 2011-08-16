describe "Radio View - Click Button By Title Tests" do
    
  before(:all) do
    show_control :radio_view
    @app = App.get_instance
    page = @app['radioViewsPage']
    @reset = page['resetButton']
    @radio_view = page['verticalRadioView', RadioView]
  end
  
  before(:each) do
    @reset.click
  end
      
  it "will click radio view's buttons by title" do
  
    @radio_view.buttons.should have_count 3
    
    @radio_view.buttons.should have_some_selected
    @radio_view.buttons.should have_one_selected
    @radio_view.buttons.should have_selected 0
    @radio_view.buttons.should have_selected 'cat'
    @radio_view.should have_value 'cat'
    
    @radio_view.buttons.click 'dog'
    
    @radio_view.buttons.should have_one_selected
    @radio_view.buttons.should have_selected 1
    @radio_view.buttons.should have_selected 'dog'
    @radio_view.should have_value 'dog'
    
    @radio_view.buttons.click 'pig'
    
    @radio_view.buttons.should have_one_selected
    @radio_view.buttons.should have_selected 2
    @radio_view.buttons.should have_selected 'pig'
    @radio_view.should have_value 'pig'
    
    @radio_view.buttons.click 'cat'
    
    @radio_view.buttons.should have_one_selected
    @radio_view.buttons.should have_selected 0
    @radio_view.buttons.should have_selected 'cat'
    @radio_view.should have_value 'cat'
    
  end
  
end