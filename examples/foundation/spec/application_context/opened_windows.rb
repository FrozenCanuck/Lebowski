describe "Acquiring Opened Window Application Context" do

  before(:all) do
    @reset_button = App['resetButton']
    @open_win_button = App['openBasicAppWinButton']
    @win_name_text_field = App['winNameTextField']
    @win_title_text_field = App['winTitleTextField']
    @win_anchor_text_field = App['winAnchorTextField']
  end

  it "will open a window with name 'foo', access its controls, and then close it" do
    @reset_button.click
    
    App.should have_current_application_context
    
    windows = App.opened_windows
    
    @win_name_text_field.type "foo"
    @open_win_button.click
    
    windows.should have_window_with_name "foo"
    windows.should_not have_window_with_name "bar"
    
    window = windows.find_by_name "foo"
    window.should_not be_nil
    
    window.should be_opened
    window.should_not have_current_application_context
    
    window.acquire_application_context 'BasicApp'
    
    window.should have_current_application_context
    App.should_not have_current_application_context
    
    window['counterLabel'].should have_value /counter: 0/i
    window['incButton'].click
    window['counterLabel'].should have_value /counter: 1/i
    
    window['#counter-label'].should have_value /counter: 1/i
    window['#increment-button'].click
    window['#counter-label'].should have_value /counter: 2/i
    
    window['mainPage.mainPane.label'].should have_value /counter: 2/i
    window['mainPage.mainPane.increment'].click
    window['mainPage.mainPane.label'].should have_value /counter: 3/i
    
    App.reset_application_context
    
    App.should have_current_application_context
    window.should_not have_current_application_context
    
    window.close
    
    window.should_not be_opened
  end
  
  it "will open a window with title 'test title', access its controls, and then close it" do
    #
    # Can only do this particular test in Firefox. Safari and Chrome fail because Selenium
    # replaces the window's open method with its own function, which causes a problem for
    # the browsers in that they no longer call the window's onload function. Therefore,
    # for this test the window's title does not end up getting changed.
    #
    if App.browser == MainApplication::FIREFOX
      @reset_button.click
    
      App.should have_current_application_context
    
      windows = App.opened_windows
    
      @win_title_text_field.type "test title"
      @open_win_button.click
    
      windows.should have_window_with_title "test title"
      windows.should_not have_window_with_title "title"
          
      window = windows.find_by_title /test title/i
      window.should_not be_nil
    
      window.should be_opened
      window.should_not have_current_application_context
    
      window.acquire_application_context 'BasicApp'
    
      window.should have_current_application_context
      App.should_not have_current_application_context
    
      window['#counter-label'].should have_value /counter: 0/i
      window['#increment-button'].click
      window['#counter-label'].should have_value /counter: 1/i
    
      App.reset_application_context
    
      App.should have_current_application_context
      window.should_not have_current_application_context
    
      window.close
    
      window.should_not be_opened
    end
  end
  
  it "will open a window with anchor 'id=123', access its controls, and then close it" do
    @reset_button.click
    
    App.should have_current_application_context
    
    windows = App.opened_windows
    
    @win_anchor_text_field.type "id=123"
    @open_win_button.click
    
    windows.should have_window_with_location /id=123/i
    windows.should_not have_window_with_location /id=321/i
    
    window = windows.find_by_location /id=123/i
    
    window.should_not be_nil
    window.should be_opened
    
    App.should have_current_application_context
    
    window.exec_in_context 'BasicApp' do |win|
      win['counterLabel'].should have_value /counter: 0/i
      win['incButton'].click
      win['counterLabel'].should have_value /counter: 1/i
      
      win['#counter-label'].should have_value /counter: 1/i
      win['#increment-button'].click
      win['#counter-label'].should have_value /counter: 2/i
    end
    
    window.should_not have_current_application_context
    App.should have_current_application_context
    
    window.close
    
    window.should_not be_opened
  end
  
  it "will open a window and access controls via the driver" do
    
    @reset_button.click
    
    App.should have_current_application_context
    
    windows = App.opened_windows
    
    @win_name_text_field.type "foo"
    @open_win_button.click
    
    window = windows.find_by_name "foo"
    
    window.should_not be_nil
    window.should be_opened
    
    App.should have_current_application_context
    
    window.exec_driver_in_context do |driver|
      driver.mouse_down "css=#reset-button"
      driver.mouse_up "css=#reset-button"
      
      text = driver.get_text "css=#counter-label"
      text.should =~ /counter: 0/i
      
      driver.mouse_down "css=#decrement-button"
      driver.mouse_up "css=#decrement-button"
      
      text = driver.get_text "css=#counter-label"
      text.should =~ /counter: -1/i
    end
    
    window.should_not have_current_application_context
    App.should have_current_application_context
    
    window.close
    window.should_not be_opened
  end
  
  it "wil open two windows, access their controls, and then close them" do
    @reset_button.click
    
    App.should have_current_application_context
    
    windows = App.opened_windows
    
    @win_name_text_field.type "foo"
    @open_win_button.click
    
    win1 = windows.find_by_name "foo"
    win1.should_not be_nil
    win1.should be_opened
    win1.move_to 1, 1
    
    @win_name_text_field.type "bar"
    @open_win_button.click
    
    win2 = windows.find_by_name "bar"
    win2.should_not be_nil
    win2.should be_opened
    win2.move_to 401, 1
    
    win1.acquire_application_context "BasicApp"
    
    win1.should have_current_application_context
    win2.should_not have_current_application_context
    App.should_not have_current_application_context
      
    win1['#counter-label'].should have_value /counter: 0/i
    win1['#increment-button'].click
    win1['#counter-label'].should have_value /counter: 1/i
    
    win2.acquire_application_context "BasicApp"
    
    win1.should_not have_current_application_context
    win2.should have_current_application_context
    App.should_not have_current_application_context
    
    win1['#counter-label'].should have_value /counter: 0/i
    win1['#decrement-button'].click
    win1['#counter-label'].should have_value /counter: -1/i
    
    App.reset_application_context
    
    win1.should_not have_current_application_context
    win2.should_not have_current_application_context
    App.should have_current_application_context
    
    win1.close
    win2.close
    
    win1.should_not be_opened
    win2.should_not be_opened
  end

end