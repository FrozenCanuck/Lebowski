describe "Segmented View Tests" do
    
  before(:all) do
    App['controlsList'].item_views.find_first({ :name => 'SC.SegmentedView' }).select
    @first_basic_segmented = App['#first-basic-segmented', SegmentedView]
    @second_basic_segmented = App['#second-basic-segmented', SegmentedView]
    @allow_empty_segmented = App['#allow-empty-segmented', SegmentedView]
    @allow_multiple_segmented = App['#allow-multiple-segmented', SegmentedView]
    @allow_empty_multiple_segmented = App['#allow-empty-multiple-segmented', SegmentedView]
    @disabled_segmented = App['#disabled-segmented', SegmentedView]
  end
  
  it "will confirm views' initial property settings" do
    @first_basic_segmented.buttons.should have_count 2
    @first_basic_segmented.buttons.should have_selected_count 0
    @first_basic_segmented.buttons.should have_none_selected
    @first_basic_segmented.should_not be_allowed_empty_selection
    @first_basic_segmented.should_not be_allowed_multiple_selection
    
    @second_basic_segmented.buttons.should have_count 3
    @second_basic_segmented.buttons.should have_selected_count 0
    @second_basic_segmented.buttons.should have_none_selected
    @second_basic_segmented.should_not be_allowed_empty_selection
    @second_basic_segmented.should_not be_allowed_multiple_selection
    
    @allow_empty_segmented.buttons.should have_count 3
    @allow_empty_segmented.buttons.should have_selected_count 0
    @allow_empty_segmented.should be_allowed_empty_selection
    @allow_empty_segmented.should_not be_allowed_multiple_selection
    
    @allow_multiple_segmented.buttons.should have_count 3
    @allow_multiple_segmented.buttons.should have_selected_count 1
    @allow_multiple_segmented.buttons.should have_one_selected
    @allow_multiple_segmented.should_not be_allowed_empty_selection
    @allow_multiple_segmented.should be_allowed_multiple_selection
    @allow_multiple_segmented.buttons.should have_selected 'cat'
    
    @allow_empty_multiple_segmented.buttons.should have_count 3
    @allow_empty_multiple_segmented.buttons.should have_selected_count 1
    @allow_empty_multiple_segmented.buttons.should have_one_selected
    @allow_empty_multiple_segmented.should be_allowed_empty_selection
    @allow_empty_multiple_segmented.should be_allowed_multiple_selection
    @allow_empty_multiple_segmented.buttons.should have_selected 'cat'
    
    @disabled_segmented.should_not be_enabled
  end
  
  describe "First Basic Segmented" do
    
    it "will click segment 'foo' and confirm it is selected" do
      @first_basic_segmented.buttons.click 'foo'
      @first_basic_segmented.buttons.should have_selected_count 1
      @first_basic_segmented.buttons.should have_one_selected
      @first_basic_segmented.buttons.should have_selected 'foo'
      @first_basic_segmented.should have_value 'foo'
    end
    
    it "will click segment 'bar' and confirm it is selected" do
      @first_basic_segmented.buttons.click 'bar'
      @first_basic_segmented.buttons.should have_selected_count 1
      @first_basic_segmented.buttons.should have_one_selected
      @first_basic_segmented.buttons.should have_selected 'bar'
      
      @first_basic_segmented.buttons.should_not have_selected 'foo'
      @first_basic_segmented.should have_value 'bar'
    end
    
  end
  
  describe "Second Basic Segmented" do
    
    it "will click segment 'cat' and confirm it is selected" do
      @second_basic_segmented.buttons.click 'cat'
      @second_basic_segmented.buttons.should have_selected_count 1
      @second_basic_segmented.buttons.should have_one_selected
      @second_basic_segmented.buttons.should have_selected 'cat'
      @second_basic_segmented.should have_value 1
    end
    
    it "will click segment with title 'dog' and confirm it is selected" do
      @second_basic_segmented.buttons.click_with_title 'dog'
      @second_basic_segmented.buttons.should have_selected_count 1
      @second_basic_segmented.buttons.should have_one_selected
      @second_basic_segmented.buttons.should have_selected 'dog'
      @second_basic_segmented.should have_value 2
      
      @second_basic_segmented.buttons.should_not have_selected 'cat'
    end
    
    it "will click the third segment with index 2 and confirm it is selected" do
      @second_basic_segmented.buttons.click_with_index 2
      @second_basic_segmented.buttons.should have_selected_count 1
      @second_basic_segmented.buttons.should have_one_selected
      @second_basic_segmented.buttons.should have_selected 'pig'
      @second_basic_segmented.should have_value 3
      
      @second_basic_segmented.buttons.should_not have_selected 'dog'
    end
    
  end
  
  describe "Allow Empty Segmented" do
    
    it "will click the first segment and confirm it is selected" do
      @allow_empty_segmented.buttons.click 'cat'
      @allow_empty_segmented.buttons.should have_selected_count 1
      @allow_empty_segmented.buttons.should have_one_selected
      @allow_empty_segmented.buttons.should have_selected 'cat'
    end
    
    it "will click the first segment again and confirm nothing is selected" do
      @allow_empty_segmented.buttons.click 'cat'
      @allow_empty_segmented.buttons.should have_selected_count 0
      @allow_empty_segmented.buttons.should have_none_selected
      @allow_empty_segmented.buttons.should_not have_selected 'cat'
    end
    
  end
  
  describe "Allow Multiple Segmented" do
    
    it "will click the second segment and confirm two segments are selected" do
      @allow_multiple_segmented.buttons.click 'dog'
      @allow_multiple_segmented.buttons.should have_selected_count 2
      @allow_multiple_segmented.buttons.should have_some_selected
      @allow_multiple_segmented.buttons.should_not have_one_selected
      @allow_multiple_segmented.buttons.should_not have_none_selected
      @allow_multiple_segmented.buttons.should_not have_all_selected
      @allow_multiple_segmented.buttons.should have_selected 'cat'
      @allow_multiple_segmented.buttons.should have_selected 'dog'
      @allow_multiple_segmented.buttons.should_not have_selected 'pig'
    end
    
    it "will click the third segment and confirm all three segments are selected" do
      @allow_multiple_segmented.buttons.click 'pig'
      @allow_multiple_segmented.buttons.should have_selected_count 3
      @allow_multiple_segmented.buttons.should have_some_selected
      @allow_multiple_segmented.buttons.should_not have_one_selected
      @allow_multiple_segmented.buttons.should_not have_none_selected
      @allow_multiple_segmented.buttons.should have_all_selected
      @allow_multiple_segmented.buttons.should have_selected 'cat'
      @allow_multiple_segmented.buttons.should have_selected 'dog'
      @allow_multiple_segmented.buttons.should have_selected 'pig'
    end
    
    describe "Allow Empty Multiple Segmented" do
      
      it "will select the second and third segment and confirm all segments are selected" do
        @allow_empty_multiple_segmented.buttons.each do |segment|
          segment.select
        end
        
        @allow_empty_multiple_segmented.buttons.should have_selected_count 3
        @allow_empty_multiple_segmented.buttons.should have_all_selected

        @allow_empty_multiple_segmented.buttons.each do |segment|
          segment.should be_selected
        end
      end
      
      it "will click all three segments and confirm none are selected" do
        @allow_empty_multiple_segmented.buttons.each do |segment|
          segment.deselect
        end
        
        @allow_empty_multiple_segmented.buttons.should have_selected_count 0
        @allow_empty_multiple_segmented.buttons.should_not have_all_selected

        @allow_empty_multiple_segmented.buttons.each do |segment|
          segment.should_not be_selected
        end
      end
      
    end
    
  end
  
end