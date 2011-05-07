describe "Menu Pane Tests" do
    
  def click_menu_item(button, title)
    
    panes = @app.responding_panes

    button.click
    
    panes.should have_one MenuPane
    @app.menu_pane.click_item title
    panes.should_not have_any MenuPane
    
    @status_label.should have_value /clicked #{title}/i
    
  end
    
  before(:all) do
    show_control :menu_pane
    @app = App.get_instance
    page = @app['menuPanesPage']
    @status_label = page['statusLabel']
    @short_menu_button = page['shortMenuButton']
    @long_menu_button = page['longMenuButton']
  end

  it "click menu items in short menu list" do
  
    click_menu_item @short_menu_button, 'menu item 1'
    click_menu_item @short_menu_button, 'menu item 2'
    click_menu_item @short_menu_button, 'menu item 3'
    
  end
  
  it "click menu items in long menu list" do
  
    click_menu_item @long_menu_button, 'menu item 5'
    click_menu_item @long_menu_button, 'menu item 60'
    
  end

end