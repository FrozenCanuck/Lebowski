describe "Palette Pane Test" do
    
  before(:all) do
    show_control :palette_pane
    @create_palette = App['#create-palette', ButtonView]
    @anchor1 = App['#palette-anchor-1', View]
    @anchor2 = App['#palette-anchor-2', View]
    @anchor3 = App['#palette-anchor-3', View]
  end
  
  it "will create a palette pane and drag it to all three anchor views" do
    
    @create_palette.click
    
    pane = App.responding_panes.find_first PalettePane
    
    pane.drag_to @anchor1
    
    pane.position.should have_x @anchor1.position.x
    pane.position.should have_y @anchor1.position.y

    pane.drag_to @anchor2, 20, 0
    
    pane.drag_to @anchor3, 0, 20
    
    pane.drag_to @anchor1, 100, -20
    
    close_button = pane['contentView.group.close']
    close_button.click
    
  end
  
end