describe "Segmented View Test" do
    
  before(:all) do
    show_control :segmented_view
    @app = App.get_instance
    page = @app['segmentedViewsPage']
    @segment = page['basic2SegmentedView', SegmentedView]
    @reset = page['resetButton', ButtonView]
  end
  
  before(:each) do
    @reset.click
  end
      
  it "will click segment view's button by index" do
    
    @segment.should_not be_allowed_empty_selection
    @segment.should_not be_allowed_multiple_selection    
    
    @segment.buttons.should have_count 3
    
    @segment.buttons.should have_selected_count 0
    @segment.buttons.should have_none_selected
    @segment.buttons.should_not have_selected 'cat'
    @segment.buttons.should_not have_selected 'dog'
    @segment.buttons.should_not have_selected 'pig'
    @segment.should have_value that_is_empty

    @segment.buttons.click 0
    
    @segment.buttons.should have_selected_count 1
    @segment.buttons.should have_one_selected
    @segment.buttons.should have_selected 'cat'
    @segment.should have_value 1
    
    @segment.buttons.click 1
    
    @segment.buttons.should have_selected_count 1
    @segment.buttons.should have_one_selected
    @segment.buttons.should have_selected 'dog'
    @segment.should have_value 2
    
    @segment.buttons.click 2
    
    @segment.buttons.should have_selected_count 1
    @segment.buttons.should have_one_selected
    @segment.buttons.should have_selected 'pig'
    @segment.should have_value 3

  end
  
end