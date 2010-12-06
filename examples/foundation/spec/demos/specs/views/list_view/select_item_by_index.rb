describe "List View Test" do
    
  before(:all) do
    show_control :list_view
    @app = App.get_instance
    @list = @app['#first-employee-list', ListView]
    @reset = @app['#reset-list-view-button', ButtonView]
  end
  
  before(:each) do
    @reset.click
  end
  
  it "will select an item by index" do
    
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