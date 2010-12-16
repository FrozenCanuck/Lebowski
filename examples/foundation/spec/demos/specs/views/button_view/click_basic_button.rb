describe "Button View Test" do
    
  before(:all) do
    show_control :button_view
    @app = App.get_instance
    @button = @app['#click-me-button', ButtonView]
    @label = @app['#click-counter-label', LabelView]
    @reset = @app['#reset-click-count-button', ButtonView]
  end
  
  before(:each) do
    @reset.click
  end
      
  it "will click basic button" do
    
    @label.should have_value /clicks: 0/i
    
    3.times { @button.click }

    @label.should have_value /clicks: 3/i

  end
  
end