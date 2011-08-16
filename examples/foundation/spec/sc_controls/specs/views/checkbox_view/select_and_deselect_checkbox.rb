describe "Checkbox View Tests" do
    
  before(:all) do
    show_control :checkbox_view
    @app = App.get_instance
    page = @app['checkboxViewsPage']
    @basic_checkbox = page['basicCheckboxView', CheckboxView]
    @mixed_state_checkbox = page['mixedStateCheckboxView', CheckboxView]
    @reset_button = page['resetButton', ButtonView]
  end
  
  before(:each) do
    @reset_button.click
  end
  
  it "will click the basic checkbox" do

    @basic_checkbox.should_not be_in_mixed_state
    @basic_checkbox.should_not be_selected
    
    @basic_checkbox.click
    
    @basic_checkbox.should_not be_in_mixed_state
    @basic_checkbox.should be_selected
    
    @basic_checkbox.click
    
    @basic_checkbox.should_not be_in_mixed_state
    @basic_checkbox.should_not be_selected
    
  end
      
  it "will select and deselect basic checkbox" do
    
    @basic_checkbox.should_not be_in_mixed_state
    @basic_checkbox.should_not be_selected
    
    @basic_checkbox.select
    
    @basic_checkbox.should_not be_in_mixed_state
    @basic_checkbox.should be_selected
    
    @basic_checkbox.deselect
    
    @basic_checkbox.should_not be_in_mixed_state
    @basic_checkbox.should_not be_selected

  end
  
  it "will select mixed state checkbox" do
    
    @mixed_state_checkbox.should be_in_mixed_state
    @mixed_state_checkbox.should be_selected
    
    @mixed_state_checkbox.select
    
    @mixed_state_checkbox.should_not be_in_mixed_state
    @mixed_state_checkbox.should be_selected
    
  end
  
  it "will deselect mixed state checkbox" do
    
    @mixed_state_checkbox.should be_in_mixed_state
    @mixed_state_checkbox.should be_selected
    
    @mixed_state_checkbox.deselect
    
    @mixed_state_checkbox.should_not be_in_mixed_state
    @mixed_state_checkbox.should_not be_selected
    
  end
  
end