describe "Segmented View Test - Allow Multiple Selection" do
    
  before(:all) do
    show_control :segmented_view
    @app = App.get_instance
    page = @app['segmentedViewsPage']
    @segment = page['allowEmptyMultipleSelectionSegmentedView', SegmentedView]
    @reset = page['resetButton', ButtonView]
  end
  
  before(:each) do
    @reset.click
  end
      
  it "will toggle buttons" do
    
    @segment.should be_allowed_empty_selection
    @segment.should be_allowed_multiple_selection    
    
    @segment.buttons.should have_count 3
    
    @segment.buttons.should have_selected_count 1
    @segment.buttons.should have_one_selected
    @segment.buttons.should have_selected 'cat'
    @segment.buttons.should_not have_selected 'dog'
    @segment.buttons.should_not have_selected 'pig'
    @segment.should have_value 'cat'
    
    @segment.buttons.click 'dog'
    
    @segment.buttons.should have_selected_count 2
    @segment.buttons.should have_selected 'dog'
    @segment.should have_value that_contains('cat', 'dog')
    
    @segment.buttons.click 'pig'
    
    @segment.buttons.should have_selected_count 3
    @segment.buttons.should have_selected 'pig'
    @segment.should have_value that_contains('cat', 'dog', 'pig')
    
    @segment.buttons.click 'pig'
    @segment.buttons.click 'dog'
    @segment.buttons.click 'cat'
    
    @segment.buttons.should have_selected_count 0
    @segment.buttons.should have_none_selected
    @segment.buttons.should_not have_selected 'cat'
    @segment.buttons.should_not have_selected 'dog'
    @segment.buttons.should_not have_selected 'pig'
    @segment.should have_value that_is_empty

  end
  
end