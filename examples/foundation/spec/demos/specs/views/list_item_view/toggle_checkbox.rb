describe "List Item View Test" do
    
  before(:all) do
    show_control :list_view
    @app = App.get_instance
    @list = @app['#first-employee-list', ListView]
    @reset = @app['#reset-list-view-button', ButtonView]
  end
  
  before(:each) do
    @reset.click
  end
      
  it "will toggle list item checkbox" do
    
    iv = @list.item_views.find_first({ :guid => '14' })
    
    iv.checkbox.should_not be_selected
    
    iv.checkbox.select
    
    iv.checkbox.should be_selected
    
    iv.checkbox.deselect
    
    iv.checkbox.should_not be_selected

  end
  
end