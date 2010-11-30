describe "List View Test" do
    
  before(:all) do
    show_control :list_view
    @list = App['#first-employee-list', ListView]
    @reset = App['#reset-list-view-button', ButtonView]
  end
  
  it "will move an item view before another item within the same list" do
    
    @reset.click
    
    benny_hill = @list.item_views.find_first({ :guid => '10' })
    amy_grant = @list.item_views.find_first({ :guid => '14' })
    
    benny_hill.drag_before amy_grant
    
    benny_hill = @list.item_views.find_first({ :guid => '10' })
    
    iv = benny_hill.previous_item_view
    iv.content.should have_guid '13'
    iv.content.should have_first_name /norah/i
    iv.content.should have_last_name /jackson/i
    
    iv = benny_hill.next_item_view
    iv.content.should have_guid '14'
    iv.content.should have_first_name /amy/i
    iv.content.should have_last_name /grant/i
    
  end
  
  it "will move an item view after another item within the same list" do
    
    @reset.click
    
    benny_hill = @list.item_views.find_first({ :guid => '10' })
    lily_allen = @list.item_views.find_first({ :guid => '7' })
    
    benny_hill.drag_after lily_allen
    
    benny_hill = @list.item_views.find_first({ :guid => '10' })
    
    iv = benny_hill.previous_item_view
    iv.content.should have_guid '7'
    iv.content.should have_first_name /lily/i
    iv.content.should have_last_name /allen/i
    
    iv = benny_hill.next_item_view
    iv.content.should have_guid '8'
    iv.content.should have_first_name /trey/i
    iv.content.should have_last_name /paul/i
    
  end
  
  it "will move an item view to beginning of the list" do
    
    @reset.click
    
    jim_jones = @list.item_views.find_first({ :guid => '9' })
    
    jim_jones.drag_to_start_of @list
    
    jim_jones = @list.item_views.find_first({ :guid => '9' })
    
    iv = jim_jones.previous_item_view
    iv.should be_nil
    
    iv = jim_jones.next_item_view
    iv.content.should have_guid '1'
    iv.content.should have_first_name /bob/i
    iv.content.should have_last_name /izzo/i
    
  end
  
  it "will move an item view to end of the list" do
    
    @reset.click
    
    bob_izzo = @list.item_views.find_first({ :guid => '1' })
    
    bob_izzo.drag_to_end_of @list
    
    bob_izzo = @list.item_views.find_first({ :guid => '1' })
    
    iv = bob_izzo.previous_item_view
    iv.content.should have_guid '9'
    iv.content.should have_first_name /jim/i
    iv.content.should have_last_name /jones/i
    
    iv = bob_izzo.next_item_view
    iv.should be_nil
        
  end
  
end