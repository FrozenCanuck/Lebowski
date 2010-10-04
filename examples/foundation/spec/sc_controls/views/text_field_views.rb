describe "Text Field View Tests" do
    
  before(:all) do
    App['controlsList'].item_views.find_first({ :name => 'SC.TextFieldView' }).select
    @basic_text_field = App['#basic-text-field', TextFieldView]
    @hinted_text_field = App['#hinted-text-field', TextFieldView]
    @password_text_field = App['#password-text-field', TextFieldView]
    @text_area_text_field = App['#text-area-text-field', TextFieldView]
    @disabled_text_field = App['#disabled-text-field', TextFieldView]
    @custom_text_field = App['#custom-text-field', TextFieldView]
    @key_event_label = App['#key-event-label', LabelView]
  end
  
  it "will confirm views' initial property settings" do
    @basic_text_field.should have_value that_is_empty
    
    @hinted_text_field.should have_hint /hint/i
    
    @password_text_field.should be_password
    @password_text_field.should have_value '1234'
    
    @text_area_text_field.should be_text_area
    
    @disabled_text_field.should_not be_enabled
    
    @custom_text_field.should have_value that_is_empty
    @key_event_label.should have_value that_is_empty
  end
  
  describe "Basic Text Field" do
    
    it "will type 'hello' into field and confirm" do
      @basic_text_field.type 'hello'
      @basic_text_field.should have_value 'hello'
    end
    
    it "will type append 'world' into field and confirm" do
      @basic_text_field.type_append ' world'
      @basic_text_field.should have_value 'hello world'
    end
    
    it "will clear the field and confirm" do
      @basic_text_field.clear
      @basic_text_field.should have_value that_is_empty
    end
    
    it "will type keys 'a', 'b', and 'c' and confirm value is 'abc'" do
      @basic_text_field.type_keys 'abc'
      @basic_text_field.should have_value 'abc'
    end 
    
    it "will append typed keys 'd', 'e', and 'f' and confirm value is 'abcdef'" do
      @basic_text_field.type_keys_append 'def'
      @basic_text_field.should have_value 'abcdef'
    end
    
    it "will type the function key delete confirm value is 'abcde'" do
      @basic_text_field.type_key_append :delete
      @basic_text_field.should have_value 'abcde'
    end
    
    it "will type the function key backspace confirm value is 'abcd'" do
      @basic_text_field.type_key_append :backspace
      @basic_text_field.should have_value 'abcd'
    end
    
  end
  
  describe "Text Area Text Field" do
    
    it "will type 'hello' into field and confirm" do
      @text_area_text_field.type 'hello'
      @text_area_text_field.should have_value 'hello'
    end
    
    it "will type 'world' on the next line and confirm" do
      @text_area_text_field.type_key_append :return
      
      @text_area_text_field.type_append 'world'
      @text_area_text_field.should have_value "hello\nworld"
    end
  
  end
  
  describe "Respond to Key Events" do
    
    it "will key down and key down the letter 'a' and confirm text field responded" do
      
      #
      # Temporary check. The key up and key down events do not respond properly
      # within Firefox. This is do to the application window unable to obtain
      # proper focus. If you click on the application window when it first appears then
      # the key up and key down events work as expected. Unfortunately, simply calling
      # window.focus() does not fix the problem.
      #
      if App.browser != MainApplication::FIREFOX
        @custom_text_field.key_down 'a'
        @key_event_label.should have_value 'key down = a'

        @custom_text_field.key_up 'a'
        @key_event_label.should have_value 'key up = a'
      end
      
    end
    
    it "will key down and key down the return function key and confirm text field responded" do
      
      #
      # Temporary check
      #
      if App.browser != MainApplication::FIREFOX
        @custom_text_field.key_down :return
        @key_event_label.should have_value 'key down = return'
      
        @custom_text_field.key_up :return
        @key_event_label.should have_value 'key up = return'
      end
      
    end
    
  end
  
end