describe "List Item View Test" do
    
  before(:all) do
    show_control :list_view
    @app = App.get_instance
    @list = @app['#third-employee-list', ListView]
    @reset = @app['#reset-list-view-button', ButtonView]
  end
  
  before(:each) do
    @reset.click
  end
      
  it "will toggle list item disclosure" do
    
    iv = @list.item_views.find_first({ :summary => /verizon/i })
    
    iv.disclosure.should_not be_expanded
    iv.disclosure.should_not be_toggled_on
    iv.disclosure.should be_collapsed
    iv.disclosure.should be_toggled_off
    
    iv.disclosure.expand
    
    iv.disclosure.should be_expanded
    iv.disclosure.should be_toggled_on
    iv.disclosure.should_not be_collapsed
    iv.disclosure.should_not be_toggled_off
    
    iv.disclosure.collapse
    
    iv.disclosure.should_not be_expanded
    iv.disclosure.should_not be_toggled_on
    iv.disclosure.should be_collapsed
    iv.disclosure.should be_toggled_off

  end
  
end