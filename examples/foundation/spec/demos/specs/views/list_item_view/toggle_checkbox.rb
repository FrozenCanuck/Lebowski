describe "List Item View Test" do
    
  before(:all) do
    show_control :list_view
    @list = App['#first-employee-list', ListView]
    @reset = App['#reset-list-view-button', ButtonView]
  end
      
  it "will edit list item label" do
    
    @reset.click
    
    iv = @list.item_views.find_first({ :guid => '14' })
    
    iv.checkbox.should_not be_selected
    
    iv.checkbox.select
    
    iv.checkbox.should be_selected
    
    iv.checkbox.deselect
    
    iv.checkbox.should_not be_selected

  end
  
end