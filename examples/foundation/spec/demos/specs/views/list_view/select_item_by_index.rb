describe "List View Test" do
    
  before(:all) do
    show_control :list_view
    @list = App['#first-employee-list', ListView]
    @reset = App['#reset-list-view-button', ButtonView]
  end
  
  it "will select an item by index" do
    
    @reset.click
    
    @list.item_views[0].select
    @list.item_views.selected.should have_count 1
        
    iv = @list.item_views[0]
    
    iv.should be_selected
    iv.content.should have_guid '1'
    iv.content.should have_first_name /bob/i
    iv.content.should have_last_name /izzo/i
    
    @list.item_views.selected.should have_count 1
    
  end
  
end