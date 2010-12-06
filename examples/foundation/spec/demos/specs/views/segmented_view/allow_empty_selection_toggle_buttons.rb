describe "Segmented View Test - Allow Empty Selection" do
    
  before(:all) do
    show_control :segmented_view
    @app = App.get_instance
    page = @app['segmentedViewsPage']
    @segment = page['allowEmptySelectionSegmentedView', SegmentedView]
    @reset = page['resetButton', ButtonView]
  end
  
  before(:each) do
    @reset.click
  end
      
  it "will toggle buttons" do
    
    @segment.should be_allowed_empty_selection
    @segment.should_not be_allowed_multiple_selection    
    
    @segment.buttons.should have_count 3
    
    @segment.buttons.should have_selected_count 0
    @segment.buttons.should have_none_selected
    @segment.buttons.should_not have_selected 'cat'
    @segment.buttons.should_not have_selected 'dog'
    @segment.buttons.should_not have_selected 'pig'
    @segment.should have_value that_is_empty

    @segment.buttons.click 'cat'
    
    @segment.buttons.should have_selected_count 1
    @segment.buttons.should have_selected 'cat'
    @segment.should have_value 'cat'
    
    @segment.buttons.click 'dog'
    
    @segment.buttons.should have_selected_count 1
    @segment.buttons.should have_selected 'dog'
    @segment.should have_value 'dog'
    
    @segment.buttons.click 'pig'
    
    @segment.buttons.should have_selected_count 1
    @segment.buttons.should have_selected 'pig'
    @segment.should have_value 'pig'
    
    @segment.buttons.click 'pig'
    
    @segment.buttons.should have_selected_count 0
    @segment.buttons.should have_none_selected
    @segment.buttons.should_not have_selected 'cat'
    @segment.buttons.should_not have_selected 'dog'
    @segment.buttons.should_not have_selected 'pig'
    @segment.should have_value that_is_empty

  end
  
end