describe "Checkbox View Tests" do
    
  before(:all) do
    App['controlsList'].item_views.find_first({ :name => 'SC.CheckboxView' }).select
    @basic_checkbox = App['#basic-checkbox', CheckboxView]
    @disabled_checkbox = App['#disabled-checkbox', CheckboxView]
    @mixed_state_checkbox = App['#mixed-state-checkbox', CheckboxView]
    @reset_mixed_state_checkbox_button = App['#reset-mixed-state-checkbox-button', ButtonView]
  end
  
  it "will confirm views' initial property settings" do
    @basic_checkbox.should_not be_selected
    @basic_checkbox.should_not be_checked
    @basic_checkbox.should be_enabled
    @basic_checkbox.should_not be_in_mixed_state

    @disabled_checkbox.should_not be_enabled
    
    @mixed_state_checkbox.should be_selected
    @mixed_state_checkbox.should be_in_mixed_state
  end
  
  describe "Basic Checkbox" do
    
    it "will select the checkbox and confirm" do
      @basic_checkbox.select
      @basic_checkbox.should be_selected
      @basic_checkbox.should_not be_in_mixed_state
    end
    
    it "will deselect the checkbox and confirm" do
      @basic_checkbox.deselect
      @basic_checkbox.should_not be_selected
      @basic_checkbox.should_not be_in_mixed_state
    end
    
  end
  
  describe "Mixed State Checkbox" do
    
    it "will select the mixed state checkbox and confirm" do
      @mixed_state_checkbox.select
      @mixed_state_checkbox.should be_selected
      @mixed_state_checkbox.should_not be_in_mixed_state
    end
    
    it "will reset the mixed state checkbox, deselect it, and confirm" do
      @reset_mixed_state_checkbox_button.click
      @mixed_state_checkbox.should be_in_mixed_state
      
      @mixed_state_checkbox.deselect
      @mixed_state_checkbox.should_not be_selected
      @mixed_state_checkbox.should_not be_in_mixed_state
    end
    
  end
  
end