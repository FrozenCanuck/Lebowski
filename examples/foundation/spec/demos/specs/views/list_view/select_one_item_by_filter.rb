describe "List View Test" do
    
  before(:all) do
    show_control :list_view
    @list = App['#first-employee-list', ListView]
    @reset = App['#reset-list-view-button', ButtonView]
  end
      
  it "will select the item view with guid '9'" do
    
    @reset.click
    
    @list.item_views.should have_one({ :guid => '9' })
        
    iv = @list.item_views.find_first({ :guid => '9' })
        
    iv.select
    
    iv.should be_selected
    iv.content.should have_guid '9'
    iv.content.should have_first_name /jim/i
    iv.content.should have_last_name /jones/i
    
    @list.item_views.selected.should have_count 1
    
  end
  
  it "will select the item view with first name 'Amy' and last name 'Grant'" do
    
    @reset.click
    
    @list.item_views.should have_one({ 'firstName' => 'Amy', 'lastName' => 'Grant' })
        
    iv = @list.item_views.find_first({ 'firstName' => 'Amy', 'lastName' => 'Grant' })
        
    iv.select
    
    iv.should be_selected
    iv.content.should have_guid '14'
    iv.content.should have_first_name /amy/i
    iv.content.should have_last_name /grant/i
    
    @list.item_views.selected.should have_count 1
    
  end
  
end