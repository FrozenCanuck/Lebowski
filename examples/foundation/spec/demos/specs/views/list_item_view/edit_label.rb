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
      
  it "will edit list item label" do
    
    iv = @list.item_views.find_first({ :guid => '14' })
    
    iv.content.should have_guid '14'
    iv.content.should have_first_name 'Amy'
    iv.content.should have_last_name 'Grant'
    
    iv.edit_label 'firstName=Nancy'
    iv.edit_label 'lastName=Bonds'
    
    iv.content.should have_guid '14'
    iv.content.should have_first_name 'Nancy'
    iv.content.should have_last_name 'Bonds' 
    
  end
  
end