describe "Menu Pane Tests" do
    
  before(:all) do
    App['controlsList'].item_views.find_first({ :name => 'SC.MenuPane' }).select
    @status_label = App['#menu-panes-status-label', LabelView]
    @basic_menu = App['#basic-menu-pane', ButtonView]
  end
  
  it "will open the menu pane and close it without click a menu item" do
    
    App.responding_panes.should_not have_any MenuPane
    @basic_menu.click
    App.responding_panes.should have_one MenuPane
    pane = App.responding_panes.find_first(MenuPane)
    pane.click_off
    App.responding_panes.should_not have_any MenuPane
    
  end
  
  it "will open the menu pane and click the menu item with title 'menu item 1'" do
    
    @basic_menu.click
    App.responding_panes.should have_one MenuPane
    pane = App.responding_panes.find_first(MenuPane)
    pane.menu_items.click "menu item 1"
    App.responding_panes.should_not have_any MenuPane
    @status_label.should have_value /clicked menu item 1/i
    
  end
  
  it "will open the menu pane and click the menu item with title matching /2/" do
    
    @basic_menu.click
    App.responding_panes.should have_one MenuPane
    pane = App.responding_panes.find_first(MenuPane)
    pane.menu_items.click /2/
    App.responding_panes.should_not have_any MenuPane
    @status_label.should have_value /clicked menu item 2/i
    
  end
  
  it "will open the menu pane and try to click a menu item with title 'foo' and confirm nothing was clicked" do
    
    @basic_menu.click
    App.responding_panes.should have_one MenuPane
    pane = App.responding_panes.find_first(MenuPane)
    pane.menu_items.click 'foo'
    App.responding_panes.should have_one MenuPane
    @status_label.should have_value /opened sc\.menupane/i
    pane.click_off
    App.responding_panes.should_not have_any MenuPane
    
  end
  
end