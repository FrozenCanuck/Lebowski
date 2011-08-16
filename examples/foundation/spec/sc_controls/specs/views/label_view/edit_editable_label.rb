describe "Label View Test" do
    
  before(:all) do
    show_control :label_view
    @app = App.get_instance
    page = @app['labelViewsPage']
    @label = page['editableLabel', LabelView]
    @reset = page['resetButton', ButtonView]
  end
  
  before(:each) do
    @reset.click
  end
      
  it "will edit editable label's value" do
    
    @label.should be_editable
    @label.should have_value /edit me/i
    
    @label.edit 'hello'
    
    @label.should have_value 'hello'
    
    @label.edit 'world'
    
    @label.should have_value 'world'

  end
  
end