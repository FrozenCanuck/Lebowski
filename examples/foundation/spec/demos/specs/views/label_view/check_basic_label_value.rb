describe "Label View Test" do
    
  before(:all) do
    show_control :label_view
    @app = App.get_instance
    page = @app['labelViewsPage']
    @label = page['basicLabel', LabelView]
    @foo_button = page['fooButton', ButtonView]
    @bar_button = page['barButton', ButtonView]
    @reset = page['resetButton', ButtonView]
  end
  
  before(:each) do
    @reset.click
  end
      
  it "will check a basic label's value" do
    
    @label.should have_value that_is_empty
    
    @foo_button.click
    
    @label.should have_value 'foo'
    
    @bar_button.click
    
    @label.should have_value /bar/i

  end
  
end