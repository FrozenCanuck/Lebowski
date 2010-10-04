describe "Alert Pane Tests" do
    
  before(:all) do
    App['controlsList'].item_views.find_first({ :name => 'SC.AlertPane' }).select
    @alert_warn = App['#alert-warn', ButtonView]
    @alert_error = App['#alert-error', ButtonView]
    @alert_info = App['#alert-info', ButtonView]
    @alert_plain = App['#alert-plain', ButtonView]
    @alert_extra_button = App['#alert-extra-button', ButtonView]
    @alert_one_button = App['#alert-one-button', ButtonView]
    @status_label = App['#alert-panes-status-label', LabelView]
  end
  
  it "will open alert warn pane, click the OK button, and confirm closing" do

    App.responding_panes.should have_count 1
    App.responding_panes.should_not have_any AlertPane
    
    @alert_warn.click
    
    @status_label.should have_value /opened alert pane - warn/i
    
    App.responding_panes.should have_count that_is_greater_than 1
    App.responding_panes.should have_one AlertPane

    pane = App.key_pane AlertPane
    pane.should be_warn
    pane.should have_button_count 2
    pane.should have_button 'ok'
    pane.should have_button 'cancel'
    pane.should_not have_button 'yes'
  
    pane.click_button 'ok'
    
    @status_label.should have_value /ok button clicked/i
    
    App.responding_panes.should have_count 1
    App.responding_panes.should_not have_any AlertPane
    
  end
  
  it "will open alert error pane, click the Cancel button, and confirm closing" do
    
    App.responding_panes.should have_count 1
    App.responding_panes.should_not have_any AlertPane
    
    @alert_error.click
    
    @status_label.should have_value /opened alert pane - error/i
    
    App.responding_panes.should have_count that_is_greater_than 1
    App.responding_panes.should have_one AlertPane

    pane = App.key_pane AlertPane
    pane.should be_error
    pane.should have_button_count 2
    pane.should have_button 'ok'
    pane.should have_button 'cancel'
  
    pane.click_button 'cancel'
    
    @status_label.should have_value /cancel button clicked/i
    
    App.responding_panes.should have_count 1
    App.responding_panes.should_not have_any AlertPane
    
  end
  
  it "will open alert plain pane, click the Yes button, and confirm closing" do
    
    App.responding_panes.should have_count 1
    App.responding_panes.should_not have_any AlertPane
    
    @alert_plain.click
    
    @status_label.should have_value /opened alert pane - plain/i
    
    App.responding_panes.should have_count that_is_greater_than 1
    App.responding_panes.should have_one AlertPane

    pane = App.key_pane AlertPane
    pane.should be_plain
    pane.should have_button_count 2
    pane.should have_button 'yes'
    pane.should have_button 'no'
    pane.should_not have_button 'ok'
    pane.should_not have_button 'cancel'
  
    pane.click_button 'yes'
    
    @status_label.should have_value /yes button clicked/i
    
    App.responding_panes.should have_count 1
    App.responding_panes.should_not have_any AlertPane
    
  end
  
  
  it "will open the alert pane with an extra button, click the extra button, and confirm closing" do

    App.responding_panes.should have_count 1
    App.responding_panes.should_not have_any AlertPane

    @alert_extra_button.click
    
    @status_label.should have_value /opened alert pane - extra button/i
    
    App.responding_panes.should have_count that_is_greater_than 1
    App.responding_panes.should have_one AlertPane
      
    pane = App.key_pane AlertPane
    pane.should be_plain
    pane.should have_button_count 3
    pane.should have_button 'foo'
    pane.should have_button 'bar'
    pane.should have_button 'extra'
      
    pane.click_button 'extra'
    
    @status_label.should have_value /extra button clicked/i
    
    App.responding_panes.should have_count 1
    App.responding_panes.should_not have_any AlertPane

  end
  
  it "will open the alert pane with one button, click the button, and confirm closing" do

    App.responding_panes.should have_count 1
    App.responding_panes.should_not have_any AlertPane

    @alert_one_button.click
    
    @status_label.should have_value /opened alert pane - one button/i
    
    App.responding_panes.should have_count that_is_greater_than 1
    App.responding_panes.should have_one AlertPane
      
    pane = App.key_pane AlertPane
    pane.should be_plain
    pane.should have_button_count 1
    pane.should have_button 'ok'
      
    pane.click_button 'ok'
    
    @status_label.should have_value /ok button clicked/i
    
    App.responding_panes.should have_count 1
    App.responding_panes.should_not have_any AlertPane

  end
  
end