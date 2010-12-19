describe "Picker Pane Test" do
    
  before(:all) do
    show_control :picker_pane
    @app = App.get_instance
    page = @app['pickerPanesPage']
    @menu_picker_button = page['menuPickerButton']
    @pointer_picker_button = page['pointerPickerButton']
  end
  
  it "will access close button on menu picker pane" do
    
    panes = @app.responding_panes
    
    panes.should have_count 1
    panes.should_not have_any PickerPane
    
    @menu_picker_button.click
    
    panes.should have_count that_is_greater_than 1
    panes.should have_one PickerPane
    
    pane = panes.find_first PickerPane
    pane.should be_menu
    
    close_button = pane['contentView.close']
    close_button.click
    
    panes.should have_count 1
    panes.should_not have_any PickerPane
    
  end
  
  it "will access close button on pointer picker pane" do
    
    panes = @app.responding_panes
    
    panes.should have_count 1
    panes.should_not have_any PickerPane
    
    @pointer_picker_button.click
    
    panes.should have_count that_is_greater_than 1
    panes.should have_one PickerPane
    
    pane = panes.find_first PickerPane
    pane.should be_pointer
    
    close_button = pane['contentView.close']
    close_button.click
    
    panes.should have_count 1
    panes.should_not have_any PickerPane
    
  end
  
end