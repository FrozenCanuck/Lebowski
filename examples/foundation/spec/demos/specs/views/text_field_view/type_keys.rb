describe "Text Field View Tests" do
    
  before(:all) do
    show_control :text_field_view
    @app = App.get_instance
    page = @app['textFieldViewsPage']
    @basic_text_field = page['basicTextField', TextFieldView]
    @textarea_text_field = page['textAreaTextField', TextFieldView]
    @reset_button = page['resetButton', ButtonView]
  end
  
  before(:each) do
    @reset_button.click
  end

  it "will type individual keys into text field" do
    
    @basic_text_field.type_key "f"
    @basic_text_field.type_key_append "o"
    @basic_text_field.type_key_append "o"
    
    @basic_text_field.should have_value "foo"
    
  end
  
  it "will type keys into text field" do
    
    @basic_text_field.type_keys "hello"
    @basic_text_field.type_keys_append " world"
    
    @basic_text_field.should have_value "hello world"
    
  end
  
  it "will type keys into text field with shift key pressed" do
    
    @basic_text_field.key_down :shift
    @basic_text_field.type_keys "hello"
    @basic_text_field.type_keys_append " world"
    @basic_text_field.key_up :shift
    
    @basic_text_field.should have_value "HELLO WORLD"
    
  end
  
  it "will type text values into text field" do
    
    @basic_text_field.type "hello"
    @basic_text_field.type_append " world"
    
    @basic_text_field.should have_value "hello world"
    
  end
  
  it "will type text into text area text field using return key" do

    @textarea_text_field.should have_value that_is_empty

    @textarea_text_field.type_keys "hello"
    @textarea_text_field.type_key_append :return
    @textarea_text_field.type_keys_append "world"
    
  end
  
end