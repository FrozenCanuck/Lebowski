describe "Segmented View Test" do
    
  before(:all) do
    show_control :segmented_view
    @app = App.get_instance
    page = @app['segmentedViewsPage']
    @segment = page['basic1SegmentedView', SegmentedView]
    @reset = page['resetButton', ButtonView]
  end
  
  before(:each) do
    @reset.click
  end
      
  it "will click segment view's button by name" do
    
    @segment.should_not be_allowed_empty_selection
    @segment.should_not be_allowed_multiple_selection    
    
    @segment.buttons.should have_count 2
    
    @segment.buttons.should have_selected_count 0
    @segment.buttons.should have_none_selected
    @segment.buttons.should_not have_selected 'foo'
    @segment.buttons.should_not have_selected 'bar'
    @segment.should have_value that_is_empty

    @segment.buttons.click 'foo'
    
    @segment.buttons.should have_selected_count 1
    @segment.buttons.should have_one_selected
    @segment.buttons.should have_selected 'foo'
    @segment.should have_value 'foo'
    
    @segment.buttons.click 'bar'
    
    @segment.buttons.should have_selected_count 1
    @segment.buttons.should have_one_selected
    @segment.buttons.should have_selected 'bar'
    @segment.should have_value 'bar'

  end
  
end