shared_examples_for "panel panes" do
  
  describe "Panel Pane Tests" do
    
    before(:all) do
      App['controlsList'].item_views.find_first({ :name => 'SC.PanelPane' }).select
        @show_panel_pane = App['#show-panel-pane', ButtonView]
        @status_label = App['#panel-panes-status-label', LabelView]
      end

      it "will open and close sheet pane" do

        App.responding_panes.should_not have_any PanelPane

        @show_panel_pane.click

        App.responding_panes.should have_one PanelPane

        pane = App.key_pane(PanelPane)

        pane['contentView.close', ButtonView].click

        App.responding_panes.should_not have_any PanelPane

      end
    
  end
  
end