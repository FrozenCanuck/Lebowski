# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

# require '../../../../lib/lebowski/spec'
# 
# include Lebowski::Foundation
# include Lebowski::Foundation::Views

App = MainApplication.new \
  :app_root_path => "/application_context", 
  :app_name => "TestApp",
  :browser => :firefox

App.start do |app|
  app['mainPage.mainPane.isPaneAttached']
end

App.move_to 1, 1
App.resize_to 1024, 768

describe "Application Context Tests" do
  
  before(:all) do
    @reset_button = App['#reset-button', ButtonView]
    @open_win_button = App['#open-window.openButton', ButtonView]
    @win_name_text_field = App['#open-window.nameTextField', TextFieldView]
    @win_title_text_field = App['#open-window.titleTextField', TextFieldView]
    @win_anchor_text_field = App['#open-window.anchorTextField', TextFieldView]
    @web_view1 = App['#web-view1', WebView]
    @web_view2 = App['#web-view2', WebView]
  end
  
  describe "Acquiring Opened Window Application Context" do
  
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
      
      window['#counter-label'].should have_value /counter: 0/i
      window['#increment-button'].click
      window['#counter-label'].should have_value /counter: 1/i
      
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
        win['#counter-label'].should have_value /counter: 0/i
        win['#increment-button'].click
        win['#counter-label'].should have_value /counter: 1/i
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
  
  describe "Aquiring Frame Application Context" do
    
    it "will access the first web view's frame and access the frame's controls" do
      @reset_button.click
      
      frame = @web_view1.frame
      
      frame.should_not have_current_application_context
      App.should have_current_application_context
      
      frame.acquire_application_context 'BasicApp'
      
      frame.should have_current_application_context
      App.should_not have_current_application_context
      
      frame['#counter-label'].should have_value /counter: 0/i
      frame['#increment-button'].click
      frame['#counter-label'].should have_value /counter: 1/i
      
      App.reset_application_context
      
      App.should have_current_application_context
      frame.should_not have_current_application_context
    end
    
    it "will access the second web view's frame and access the frame's controls" do
      @reset_button.click
      
      frame = @web_view2.frame
      
      frame.should_not have_current_application_context
      App.should have_current_application_context
      
      frame.exec_in_context 'BasicApp' do |frame|
        frame['#counter-label'].should have_value /counter: 0/i
        frame['#decrement-button'].click
        frame['#counter-label'].should have_value /counter: -1/i
      end
      
      frame.should_not have_current_application_context
      App.should have_current_application_context
    end
    
    it "will access both web views' frames and access the frames' controls" do
      @reset_button.click
      
      frame1 = @web_view1.frame
      frame2 = @web_view2.frame
      
      frame1.should_not have_current_application_context
      frame2.should_not have_current_application_context
      App.should have_current_application_context
      
      frame1.acquire_application_context 'BasicApp'
      
      frame1.should have_current_application_context
      frame2.should_not have_current_application_context
      App.should_not have_current_application_context
      
      frame1['#reset-button'].click
      frame1['#counter-label'].should have_value /counter: 0/i
      frame1['#increment-button'].click
      frame1['#counter-label'].should have_value /counter: 1/i
      
      App.reset_application_context
      
      frame1.should_not have_current_application_context
      frame2.should_not have_current_application_context
      App.should have_current_application_context
      
      frame2.acquire_application_context 'BasicApp'
      
      frame1.should_not have_current_application_context
      frame2.should have_current_application_context
      App.should_not have_current_application_context
      
      frame2['#reset-button'].click
      frame2['#counter-label'].should have_value /counter: 0/i
      frame2['#decrement-button'].click
      frame2['#counter-label'].should have_value /counter: -1/i
      
      App.reset_application_context
      
      frame1.should_not have_current_application_context
      frame2.should_not have_current_application_context
      App.should have_current_application_context
    end
  
  end
  
  describe "Acquire Frame and Window Application Context" do
  
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
  
end