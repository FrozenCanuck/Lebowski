describe "Radio View Tests" do
    
  before(:all) do
    App['controlsList'].item_views.find_first({ :name => 'SC.RadioView' }).select
    @horizontal_radio = App['#horizontal-radio', RadioView]
    @vertical_radio = App['#vertical-radio', RadioView]
    @mixed_state_radio = App['#mixed-state-radio', RadioView]
    @reset_mixed_state_radio_button = App['#reset-mixed-state-radio-button', ButtonView]
    @disabled_radio = App['#disabled-radio', RadioView]
  end
  
  it "will confirm views' initial property settings" do
    @horizontal_radio.buttons.should have_count 3
    @horizontal_radio.buttons.should have_selected_count 0
    @horizontal_radio.buttons.should_not have_any_selected
    @horizontal_radio.buttons.should have_none_selected
    @horizontal_radio.should_not be_in_mixed_state
    
    @vertical_radio.buttons.should have_count 3
    @vertical_radio.buttons.should have_selected_count 1
    @vertical_radio.buttons.should have_some_selected 
    @vertical_radio.buttons.should have_one_selected
    @vertical_radio.buttons.should_not have_none_selected
    @vertical_radio.buttons.should have_selected_with_index 0
    @vertical_radio.buttons.should have_selected_with_title 'cat'
    @vertical_radio.should_not be_in_mixed_state
    
    @mixed_state_radio.buttons.should have_count 3
    @mixed_state_radio.buttons.should have_selected_count 1
    @mixed_state_radio.buttons.should have_some_selected
    @mixed_state_radio.buttons.should_not have_none_selected
    @mixed_state_radio.buttons.should have_count 3
    @mixed_state_radio.buttons.should have_selected_with_index 0
    @mixed_state_radio.buttons.should have_selected_with_title 'cat'
    @mixed_state_radio.should be_in_mixed_state
    
    @disabled_radio.should_not be_enabled
    
    @reset_mixed_state_radio_button.should have_title /reset/i
  end
  
  describe "Horizontal Radio" do
    
    it "will click button square and confirm" do
      @horizontal_radio.buttons.click 'square'
      @horizontal_radio.buttons.should have_selected_count 1
      @horizontal_radio.buttons.should have_one_selected
      @horizontal_radio.buttons.should have_some_selected
      @horizontal_radio.buttons.should_not have_none_selected
      @horizontal_radio.buttons.should have_selected 'square'
      @horizontal_radio.buttons.should have_selected 0
    end
    
    it "will click button with index of 1 (circle) and confirm" do
      @horizontal_radio.buttons.click 1
      @horizontal_radio.buttons.should have_one_selected
      
      @horizontal_radio.buttons.should have_selected 'circle'
      @horizontal_radio.buttons.should have_selected 1
      
      @horizontal_radio.buttons.should_not have_selected 'square'
      @horizontal_radio.buttons.should_not have_selected 0
    end
    
    it "will click the last button with title 'triangle' and confirm" do
      @horizontal_radio.buttons.click 'triangle'
      @horizontal_radio.buttons.should have_one_selected
      
      @horizontal_radio.buttons.should have_selected 'triangle'
      @horizontal_radio.buttons.should have_selected 2
      
      @horizontal_radio.buttons.should_not have_selected 'circle'
      @horizontal_radio.buttons.should_not have_selected 1
    end
    
  end
  
  describe "Vertical Radio" do
    
    it "will click button with title 'dog' and confirm" do
      @vertical_radio.buttons.click_with_title 'dog'
      @vertical_radio.buttons.should have_one_selected
      
      @vertical_radio.buttons.should have_selected_with_title 'dog'
      @vertical_radio.buttons.should have_selected_with_index 1

      @vertical_radio.buttons.should_not have_selected_with_title 'cat'
      @vertical_radio.buttons.should_not have_selected_with_index 0
    end
    
    it "will click button with index 2 (pig) and confirm" do
      @vertical_radio.buttons.click_with_index 2
      @vertical_radio.buttons.should have_one_selected

      @vertical_radio.buttons.should have_selected_with_title 'pig'
      @vertical_radio.buttons.should have_selected_with_index 2

      @vertical_radio.buttons.should_not have_selected_with_title 'dog'
      @vertical_radio.buttons.should_not have_selected_with_index 1
    end
    
  end
  
  describe "Mixed State Radio" do
    
    it "will click button cat and confirm the radio view is not in a mixed state" do
      @mixed_state_radio.buttons.click 'cat'
      @mixed_state_radio.buttons.should have_one_selected
      @mixed_state_radio.buttons.should have_selected 'cat'
      @mixed_state_radio.should_not be_in_mixed_state
    end
    
    it "will reset the radio to a mixed state, click on button dog, and confirm not in mixed state" do
      @reset_mixed_state_radio_button.click
      @mixed_state_radio.should be_in_mixed_state
      
      @mixed_state_radio.buttons.click 'dog'
      @mixed_state_radio.buttons.should have_one_selected
      @mixed_state_radio.buttons.should have_selected 'dog'
      @mixed_state_radio.should_not be_in_mixed_state
    end
    
  end
  
end