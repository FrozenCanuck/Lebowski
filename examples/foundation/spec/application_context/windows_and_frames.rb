describe "Acquire Frame and Window Application Context" do

  before(:all) do
    @reset_button = App['resetButton']
    @open_win_button = App['openBasicAppWinButton']
    @win_name_text_field = App['winNameTextField']
    @win_title_text_field = App['winTitleTextField']
    @win_anchor_text_field = App['winAnchorTextField']
    @web_view1 = App['webView1']
    @web_view2 = App['webView2']
  end

  it "will open a window, access the window's controls and then access a frame's controls" do
    @reset_button.click
    
    App.should have_current_application_context
    
    windows = App.opened_windows
    
    @win_name_text_field.type "foo"
    @open_win_button.click
    
    window = windows.find_by_name "foo"
    frame = @web_view1.frame
    
    window.acquire_application_context "BasicApp"
    
    window['#counter-label'].should have_value /counter: 0/i
    window['#increment-button'].click
    window['#counter-label'].should have_value /counter: 1/i
    
    App.reset_application_context
    
    frame.acquire_application_context "BasicApp"
    
    frame['#reset-button'].click
    frame['#counter-label'].should have_value /counter: 0/i
    frame['#decrement-button'].click
    frame['#counter-label'].should have_value /counter: -1/i
    
    App.reset_application_context
    
    window.acquire_application_context "BasicApp"
    
    window['#counter-label'].should have_value /counter: 1/i
    window['#increment-button'].click
    window['#counter-label'].should have_value /counter: 2/i
    
    App.reset_application_context
    
    frame.acquire_application_context "BasicApp"
    
    frame['#counter-label'].should have_value /counter: -1/i
    frame['#decrement-button'].click
    frame['#counter-label'].should have_value /counter: -2/i
    
    App.reset_application_context
    
    window.close
    window.should_not be_opened
  end
  
  it "will access a window and frame's controls using exec_in_context" do
    @reset_button.click
    
    App.should have_current_application_context
    
    windows = App.opened_windows
    
    @win_name_text_field.type "bar"
    @open_win_button.click
    
    window = windows.find_by_name "bar"
    frame = @web_view1.frame
    
    window.exec_in_context "BasicApp" do |win|
      win['#counter-label'].should have_value /counter: 0/i
      win['#increment-button'].click
      win['#counter-label'].should have_value /counter: 1/i
    end
    
    frame.exec_in_context "BasicApp" do |frame|
      frame['#reset-button'].click
      frame['#counter-label'].should have_value /counter: 0/i
      frame['#decrement-button'].click
      frame['#counter-label'].should have_value /counter: -1/i
    end
    
    window.exec_in_context "BasicApp" do |win|
      win['#counter-label'].should have_value /counter: 1/i
      win['#increment-button'].click
      win['#counter-label'].should have_value /counter: 2/i
    end
    
    frame.exec_in_context "BasicApp" do |frame|
      frame['#counter-label'].should have_value /counter: -1/i
      frame['#decrement-button'].click
      frame['#counter-label'].should have_value /counter: -2/i
    end
    
    window.close
    window.should_not be_opened
  end

end