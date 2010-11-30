describe "Palette Pane Test" do
    
  before(:all) do
    show_control :palette_pane
    @create_palette = App['#create-palette', ButtonView]
  end
  
  it "will create a palette pane and drag it relative to the window's origin" do
    
    @create_palette.click
    
    pane = App.responding_panes.find_first PalettePane
    
    pane.drag_to :window
    
    pane.position.should have_x 0
    pane.position.should have_y 0
    
    pane.drag_to :window, 200, 0
    
    pane.drag_to :window, 0, 50
    
    pane.drag_to :window, 200, 50
    
    close_button = pane['contentView.group.close']
    close_button.click
    
  end
  
end