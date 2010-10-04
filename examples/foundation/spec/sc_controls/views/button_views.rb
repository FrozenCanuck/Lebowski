describe "Button View Tests" do
    
  before(:all) do
    App['controlsList'].item_views.find_first({ :name => 'SC.ButtonView' }).select
    @click_me_button = App['#click-me-button', ButtonView]
    @click_counter_label = App['#click-counter-label', LabelView]
    @reset_click_counter_button = App['#reset-click-count-button', ButtonView]
    @disabled_button = App['#disabled-button', ButtonView]
  end
  
  it "will confirm views' initial property settings" do
    @click_me_button.should have_title /click me/i
    @click_me_button.should be_enabled
    
    @click_counter_label.should have_value /clicks: 0/i
    
    @reset_click_counter_button.should have_title /reset/i
    @reset_click_counter_button.should be_enabled
    
    @disabled_button.should have_title /disabled/i
    @disabled_button.should_not be_enabled
  end
  
  it "will click the click counter button and confirm changes to label" do
    @click_me_button.click
    @click_counter_label.should have_value /clicks: 1/i
    
    @click_me_button.click
    @click_counter_label.should have_value /clicks: 2/i
  end
  
  it "will reset the click counter and confirm changes to the label" do
    @reset_click_counter_button.click
    @click_counter_label.should have_value /clicks: 0/i
  end
  
end