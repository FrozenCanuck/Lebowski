describe "Palette Pane Test" do
    
  before(:all) do
    show_control :palette_pane
    @create_palette = App['#create-palette', ButtonView]
    @reset_palette_id_counter = App['#reset-palette-id-counter', ButtonView]
    @anchor1 = App['#palette-anchor-1', View]
    @anchor2 = App['#palette-anchor-2', View]
    @anchor3 = App['#palette-anchor-3', View]
  end
  
  it "will open multiple palette panes, drag them, and close them all" do
    
    @reset_palette_id_counter.click
    
    3.times { @create_palette.click }
    
    App.responding_panes.should have_count(PalettePane, 3)
    
    panes = App.responding_panes.filter(PalettePane)
    panes.should have_count 3
    
    pane1 = panes.find_first({ :id => 0 })
    pane1.drag_to @anchor1
    
    pane2 = panes.find_first({ :id => 1 })
    pane2.drag_to @anchor2
    
    pane3 = panes.find_first({ :id => 2 })
    pane3.drag_to @anchor3
    
    (0..2).each do |i|
      pane = panes.find_first({ :id => i })
      pane['contentView.group.close'].click
    end
    
    App.responding_panes.should have_count(PalettePane, 0)
    
  end
  
end