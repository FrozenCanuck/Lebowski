describe "Picker Pane Tests" do
    
  before(:all) do
    App['controlsList'].item_views.find_first({ :name => 'SC.PickerPane' }).select
    @menu_picker = App['#menu-picker', ButtonView]
    @pointer_picker = App['#pointer-picker', ButtonView]
    @status_label = App['#picker-panes-status-label', LabelView]
  end
  
  it "will open menu picker pane, click the close button, and confirm closing" do
    
    App.responding_panes.should have_count 1
    App.responding_panes.should_not have_any PickerPane
    
    @menu_picker.click
    
    App.responding_panes.should have_count that_is_greater_than 1
    App.responding_panes.should have_one PickerPane
    
    pane = App.key_pane PickerPane
    pane.should be_menu
    
    close_button = pane['contentView.close', ButtonView]
    close_button.click
    
    App.responding_panes.should have_count 1
    App.responding_panes.should_not have_any PickerPane
    
  end
  
  it "will open the menu picker pane, click off the pane, and confirm closing" do
    
    App.responding_panes.should have_count 1
    App.responding_panes.should_not have_any PickerPane
    
    @menu_picker.click
    
    App.responding_panes.should have_count that_is_greater_than 1
    App.responding_panes.should have_one PickerPane
    
    pane = App.key_pane PickerPane
    pane.should be_menu
    
    pane.click_off
    
    App.responding_panes.should have_count 1
    App.responding_panes.should_not have_any PickerPane
    
  end
  
  it "will open pointer picker pane, click the close button, and confirm closing" do
    
    App.responding_panes.should have_count 1
    App.responding_panes.should_not have_any PickerPane
    
    @pointer_picker.click
    
    App.responding_panes.should have_count that_is_greater_than 1
    App.responding_panes.should have_one PickerPane
    
    pane = App.key_pane PickerPane
    pane.should be_pointer
    
    close_button = pane['contentView.close', ButtonView]
    close_button.click
    
    App.responding_panes.should have_count 1
    App.responding_panes.should_not have_any PickerPane
    
  end
  
  it "will open the pointer picker pane, click off the pane, and confirm closing" do
    
    App.responding_panes.should have_count 1
    App.responding_panes.should_not have_any PickerPane
    
    @pointer_picker.click
    
    App.responding_panes.should have_count that_is_greater_than 1
    App.responding_panes.should have_one PickerPane
    
    pane = App.key_pane PickerPane
    pane.should be_pointer
    
    pane.click_off
    
    App.responding_panes.should have_count 1
    App.responding_panes.should_not have_any PickerPane
    
  end
  
end