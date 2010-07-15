shared_examples_for "sheet panes" do
  
  describe "Sheet Pane Tests" do
    
    before(:all) do
      App['controlsList'].item_views.find_first({ :name => 'SC.SheetPane' }).select
      @show_sheet_pane = App['#show-sheet-pane', ButtonView]
      @status_label = App['#sheet-panes-status-label', LabelView]
    end
    
    it "will open and close sheet pane" do
      
      App.responding_panes.should_not have_any SheetPane
      
      @show_sheet_pane.click
      
      App.responding_panes.should have_one SheetPane
      
      pane = App.key_pane(SheetPane)
      
      pane['contentView.close', ButtonView].click
      
      App.responding_panes.should_not have_any SheetPane
      
    end
    
  end
  
end