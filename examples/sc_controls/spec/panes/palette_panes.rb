shared_examples_for "palette panes" do
  
  describe "Palette Pane Tests" do
    
    before(:all) do
      App['controlsList'].item_views.find_first({ :name => 'SC.PalettePane' }).select
      @create_palette = App['#create-palette', ButtonView]
      @reset_palette_id_counter = App['#reset-palette-id-counter', ButtonView]
      @status_label = App['#palette-panes-status-label', LabelView]
      @anchor1 = App['#palette-anchor-1', View]
      @anchor2 = App['#palette-anchor-2', View]
      @anchor3 = App['#palette-anchor-3', View]
    end
    
    it "will create a palette pane, close it, and confirm" do
      
      App.responding_panes.should have_count 1
      App.responding_panes.should_not have_any PalettePane
      
      @create_palette.click
      
      App.responding_panes.should have_count that_is_greater_than 1
      App.responding_panes.should have_one PalettePane
    
      pane = App.responding_panes.find_first PalettePane
    
      close_button = pane['contentView.group.close']
      close_button.click
      
      App.responding_panes.should have_count 1
      App.responding_panes.should_not have_any PalettePane
      
    end
    
    it "will create a palette pane and drag it to all three anchor views" do
      
      @create_palette.click
      
      pane = App.responding_panes.find_first PalettePane
      
      pane.drag_to @anchor1
      pane.position.should have_x @anchor1.position.x
      pane.position.should have_y @anchor1.position.y
      
      pane.drag_to @anchor2, 20, 0
      pane.position.should have_x (@anchor2.position.x + 20)
      pane.position.should have_y @anchor2.position.y
      
      pane.drag_to @anchor3, 0, 20
      pane.position.should have_x @anchor3.position.x
      pane.position.should have_y (@anchor3.position.y + 20)
      
      pane.drag_to @anchor1, 100, -20
      pane.position.should have_x (@anchor1.position.x + 100)
      pane.position.should have_y (@anchor1.position.y - 20)
      
      close_button = pane['contentView.group.close']
      close_button.click
      
    end
    
    it "will create a palette pane and drag it relative to the window's origin" do
      
      @create_palette.click
      
      pane = App.responding_panes.find_first PalettePane
      
      pane.drag_to :window
      pane.position.should have_x 0
      pane.position.should have_y 0
      
      pane.drag_to :window, 200, 0
      pane.position.should have_x 200
      pane.position.should have_y 0
      
      pane.drag_to :window, 0, 50
      pane.position.should have_x 0
      pane.position.should have_y 50
      
      pane.drag_to :window, 200, 50
      pane.position.should have_x 200
      pane.position.should have_y 50
      
      close_button = pane['contentView.group.close']
      close_button.click
      
    end
    
    it "will open multiple palette panes, drag them, and close them all" do
      
      @reset_palette_id_counter.click
      
      App.responding_panes.should have_count 1
      App.responding_panes.should_not have_any PalettePane
      App.responding_panes.should have_count(PalettePane, 0)
      
      3.times { @create_palette.click }
      
      App.responding_panes.should have_some PalettePane
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
      
    end
    
  end
  
end