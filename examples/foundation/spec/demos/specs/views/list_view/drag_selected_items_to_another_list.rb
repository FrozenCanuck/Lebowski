describe "List View Test" do
    
  before(:all) do
    show_control :list_view
    @app = App.get_instance
    @list1 = @app['#first-employee-list', ListView]
    @list2 = @app['#second-employee-list', ListView]
    @reset = @app['#reset-list-view-button', ButtonView]
  end
  
  before(:each) do
    @reset.click
  end
      
  it "will drag items having company 'widgets inc' to another list view" do
    
    @list1.item_views.select({ :company => /widgets inc/i })
    
    iv = @list1.item_views.selected.first
    
    @list2.item_views.should have_count 0
    
    iv.drag_on_to @list2
    
    @list2.item_views.should have_count 2
    
  end
  
end