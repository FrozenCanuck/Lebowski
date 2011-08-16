describe "Select Button View - Diplay and Hide Menu Tests" do
    
  before(:all) do
    show_control :select_button_view
    @app = App.get_instance
    page = @app['selectButtonViewsPage']
    @basic = page['basicSelectButtonView', SelectButtonView]
    @reset = page['reset', ButtonView]
  end
  
  before(:each) do
    @reset.click
  end
      
  it "display and hide basic select button view's menu" do
    
    @basic.should have_value /one/i
    @basic.should_not have_menu_displayed
    @basic.display_menu
    @basic.should have_menu_displayed
    @basic.hide_menu
    @basic.should_not have_menu_displayed
    @basic.should have_value /one/i
    
  end
  
end