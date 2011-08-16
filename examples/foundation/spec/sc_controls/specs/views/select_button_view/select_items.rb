describe "Select Button View - Select Items Tests" do
    
  before(:all) do
    show_control :select_button_view
    @app = App.get_instance
    page = @app['selectButtonViewsPage']
    @basic = page['basicSelectButtonView', SelectButtonView]
    @advanced = page['advancedSelectButtonView', SelectButtonView]
    @reset = page['reset', ButtonView]
  end
  
  before(:each) do
    @reset.click
  end
      
  it "click all of basic select button view's items" do
    
    @basic.should have_value /one/i
  
    ['two', 'three', 'four', 'five'].each do |value|
      @basic.select_item value
      @basic.should have_value /#{value}/i
    end
    
  end
  
end