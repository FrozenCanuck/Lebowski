describe "Palette Pane Test" do
    
  before(:all) do
    show_control :palette_pane
    @app = App.get_instance
    @create_palette = @app['#create-palette', ButtonView]
    @anchor1 = @app['#palette-anchor-1', View]
    @anchor2 = @app['#palette-anchor-2', View]
    @anchor3 = @app['#palette-anchor-3', View]
    @reset = @app['#reset-palette-id-counter', ButtonView]
  end
  
  before(:each) do
    @reset.click
  end
  
  it "will create a palette pane and drag it to all three anchor views" do
    
    @create_palette.click
    
    pane = @app.responding_panes.find_first PalettePane
    
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