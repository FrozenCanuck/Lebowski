describe "Picker Pane Test" do
    
  before(:all) do
    show_control :picker_pane
    @app = App.get_instance
    page = @app['pickerPanesPage']
    @menu_picker_button = page['menuPickerButton']
    @pointer_picker_button = page['pointerPickerButton']
  end
  
  it "will close a menu picker pane by clicking off of it" do
    
    panes = @app.responding_panes
    
    panes.should have_count 1
    panes.should_not have_any PickerPane
    
    @menu_picker_button.click
    
    panes.should have_count that_is_greater_than 1
    panes.should have_one PickerPane
    
    pane = panes.find_first PickerPane
    pane.should be_menu
    
    pane.click_off
    
    panes.should have_count 1
    panes.should_not have_any PickerPane
    
  end
  
  it "will close a pointer picker pane by clicking off of it" do
    
    panes = @app.responding_panes
    
    panes.should have_count 1
    panes.should_not have_any PickerPane
    
    @pointer_picker_button.click
    
    panes.should have_count that_is_greater_than 1
    panes.should have_one PickerPane
    
    pane = panes.find_first PickerPane
    pane.should be_pointer
    
    pane.click_off
    
    panes.should have_count 1
    panes.should_not have_any PickerPane
    
  end
  
end