describe "Palette Pane Test" do
    
  before(:all) do
    show_control :palette_pane
    @app = App.get_instance
    @create_palette = @app['#create-palette', ButtonView]
    @reset = @app['#reset-palette-id-counter', ButtonView]
    @anchor1 = @app['#palette-anchor-1', View]
    @anchor2 = @app['#palette-anchor-2', View]
    @anchor3 = @app['#palette-anchor-3', View]
  end
  
  before(:each) do
    @reset.click
  end
  
  it "will open multiple palette panes, drag them, and close them all" do
    
    3.times { @create_palette.click }
    
    @app.responding_panes.should have_count(PalettePane, 3)
    
    panes = @app.responding_panes.filter(PalettePane)
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
    
    @app.responding_panes.should have_count(PalettePane, 0)
    
  end
  
end