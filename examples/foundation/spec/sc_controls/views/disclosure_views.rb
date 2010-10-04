describe "Disclosure View Tests" do
    
  before(:all) do
    App['controlsList'].item_views.find_first({ :name => 'SC.DisclosureView' }).select
    @basic_disclosure = App['#basic-disclosure', DisclosureView]
    @disabled_disclosure = App['#disabled-disclosure', DisclosureView]
    @mixed_state_disclosure = App['#mixed-state-disclosure', DisclosureView]
    @reset_mixed_state_disclosure_button = App['#reset-mixed-state-disclosure-button', ButtonView]
  end
  
  it "will confirm views' initial property settings" do
    @basic_disclosure.should be_toggled_on
    @basic_disclosure.should_not be_toggled_off
    @basic_disclosure.should_not be_in_mixed_state
    @basic_disclosure.should be_enabled
    
    @disabled_disclosure.should_not be_enabled
    
    @mixed_state_disclosure.should be_toggled_on
    @mixed_state_disclosure.should be_in_mixed_state
  end
  
  describe "Basic Disclosure" do
    
    it "will toggle off the disclosure and confirm" do
      @basic_disclosure.toggle_off
      @basic_disclosure.should be_toggled_off
      @basic_disclosure.should_not be_toggled_on
    end
    
    it "will toggle on the disclosure and confirm" do
      @basic_disclosure.toggle_on
      @basic_disclosure.should be_toggled_on
      @basic_disclosure.should_not be_toggled_off
    end
    
  end
  
  describe "Mixed State Disclosure" do
    
    it "will toggle on the disclosure and confirm" do
      @mixed_state_disclosure.toggle_on
      @mixed_state_disclosure.should be_toggled_on
      @mixed_state_disclosure.should_not be_toggled_off
      @mixed_state_disclosure.should_not be_in_mixed_state
    end
    
    it "will reset the mixed state disclosure, toggle it off, and confirm" do
      @reset_mixed_state_disclosure_button.click
      @mixed_state_disclosure.should be_in_mixed_state        
      
      @mixed_state_disclosure.toggle_off
      @mixed_state_disclosure.should be_toggled_off
      @mixed_state_disclosure.should_not be_toggled_on
      @mixed_state_disclosure.should_not be_in_mixed_state
    end
    
  end
  
end