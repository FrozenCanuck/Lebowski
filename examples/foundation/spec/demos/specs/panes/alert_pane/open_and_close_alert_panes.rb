describe "Alert Pane Tests" do
    
  before(:all) do
    show_control :alert_pane
    @app = App.get_instance
    page = @app['alertPanesPage']
    @alert_warn_button = page['alertWarnButton']
    @alert_error_button = page['alertErrorButton']
    @alert_info_button = page['alertInfoButton']
    @alert_plain_button = page['alertPlainButton']
    @alert_extra_button = page['alertExtraButton']
    @alert_one_button = page['alertOneButton']
    @status_label = page['statusLabel']
  end
  
  it "will open alert warn pane, click buttons, and confirm closing" do

    panes = @app.responding_panes

    panes.should have_count 1
    panes.should_not have_any AlertPane
    
    @alert_warn_button.click
    
    @status_label.should have_value /opened alert pane - warn/i
    
    panes.should have_count that_is_greater_than 1
    panes.should have_one AlertPane

    pane = @app.key_pane AlertPane
    pane.should be_warn
    pane.should have_button_count 2
    pane.should have_button 'ok'
    pane.should have_button 'cancel'
    pane.should_not have_button 'yes'
  
    pane.click_button 'ok'
    
    @status_label.should have_value /ok button clicked/i
    
    panes.should have_count 1
    panes.should_not have_any AlertPane
    
    @alert_warn_button.click
    
    panes.should have_count that_is_greater_than 1
    panes.should have_one AlertPane
    
    pane = panes.find_first AlertPane
    
    pane.click_button 'cancel'
    
    @status_label.should have_value /cancel button clicked/i
    
    panes.should have_count 1
    panes.should_not have_any AlertPane
    
  end
  
  it "will open alert pane with extra button, click extra button, and confirm closing" do
    
    panes = @app.responding_panes

    panes.should have_count 1
    panes.should_not have_any AlertPane
    
    @alert_extra_button.click
    
    panes.should have_count that_is_greater_than 1
    panes.should have_one AlertPane

    pane = @app.key_pane AlertPane
    pane.should be_plain
    pane.should have_button_count 3
    pane.should have_button 'yes'
    pane.should have_button 'no'
    pane.should have_button 'extra'
    pane.should_not have_button 'cancel'
  
    pane.click_button 'extra'
    
    @status_label.should have_value /extra button clicked/i
    
  end
  
  it "will open alert pane with single button, click button, and confirm closing" do
    
    panes = @app.responding_panes

    panes.should_not have_any AlertPane
    
    @alert_one_button.click
    
    panes.should have_one AlertPane

    pane = @app.key_pane AlertPane
    pane.should be_plain
    pane.should have_button_count 1
    pane.should have_button 'ok'
  
    pane.click_button 'ok'
    
    panes.should_not have_any AlertPane
    
  end
  
  it "will open alert error pane and close pane" do
    
    panes = @app.responding_panes

    panes.should_not have_any AlertPane
    
    @alert_error_button.click
    
    panes.should have_one AlertPane

    pane = @app.key_pane AlertPane
    pane.should be_error
    
    pane.click_button 'ok'
    
    panes.should_not have_any AlertPane
    
  end
  
  it "will open alert info pane and close pane" do
    
    panes = @app.responding_panes

    panes.should_not have_any AlertPane
    
    @alert_info_button.click
    
    panes.should have_one AlertPane

    pane = @app.key_pane AlertPane
    pane.should be_info
    
    pane.click_button 'ok'
    
    panes.should_not have_any AlertPane
    
  end
  
end