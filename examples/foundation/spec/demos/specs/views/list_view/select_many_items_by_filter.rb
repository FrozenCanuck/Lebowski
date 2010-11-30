describe "List View Test" do
    
  before(:all) do
    show_control :list_view
    @list = App['#first-employee-list', ListView]
    @reset = App['#reset-list-view-button', ButtonView]
  end
      
  it "will select items with title matching 'manager'" do
  
    @reset.click
    
    @list.item_views.should have_some({ :title => /manager/i })
    @list.item_views.should have_count({ :title => /manager/i }, 2)
        
    ivs = @list.item_views.find_all({ :title => /manager/i })
    ivs.should have_length 2
        
    @list.item_views.select({ :title => /manager/i })
        
    @list.item_views.selected.should have_count 2
        
    iv = @list.item_views.selected.find_first({ :guid => '2' })
    iv.should_not be_nil
    iv.should be_selected
    iv.content.should have_guid '2'
    iv.content.should have_first_name /joe/i
    iv.content.should have_last_name /mcdonnel/i
    iv.content.should have_title /^manager$/i
        
    iv = @list.item_views.selected.find_first({ :guid => '7' })
    iv.should_not be_nil
    iv.should be_selected
    iv.content.should have_guid '7'
    iv.content.should have_first_name /lily/i
    iv.content.should have_last_name /allen/i
    iv.content.should have_title /^senior manager$/i
    
  end
  
end