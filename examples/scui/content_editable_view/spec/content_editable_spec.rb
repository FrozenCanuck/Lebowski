require '../../../../lib/lebowski/spec'

include Lebowski::Foundation
include Lebowski::SCUI::Views

App = Application.new :app_root_path => "/test_app", :app_name => "TestApp"

App.start do |app|
  app['mainPage.mainPane.isPaneAttached'] == true
end

App.window.move_to 1, 1 
App.window.resize_to 1024, 768

DEFAULT_CONTENT_EDITABLE_VALUE = App['DEFAULT_CONTENT_EDITABLE_VALUE'] 
puts DEFAULT_CONTENT_EDITABLE_VALUE

describe "SCUI.ContentEditableView Tests" do
  
  before(:all) do
    @editor = App['#basic-content-editor', ContentEditableView]
    @reset_btn = App['#reset-button', ButtonView]
    @bold_style_btn = App['#styling-controls.bold', ButtonView]
    @underline_style_btn = App['#styling-controls.underline', ButtonView]
    @italic_style_btn = App['#styling-controls.italic', ButtonView]
    @enable_hyperlink_chkbox = App['#hyperlink-controls.enableHyperlink', CheckboxView]
    @url_text_field = App['#hyperlink-controls.urlText', TextFieldView]
    @image_src_text_field = App['#image-controls.srcText', TextFieldView]
    @insert_image_button = App['#image-controls.insertImage', ButtonView]
    @html_src_text_field = App['#html-controls.srcText', TextFieldView]
    @insert_html_button = App['#html-controls.insertSrc', ButtonView]
  end
    
  it "will confirm initial property settings" do
    @editor.should have_empty_selection
    @editor.should have_value DEFAULT_CONTENT_EDITABLE_VALUE
    @editor.should_not have_image_selected
    @editor.should_not have_hyperlink_selected
  end
  
  it "will select all content and make it bold" do
    @editor.select_all
    @editor.should_not have_empty_selection
    @editor.should have_selection DEFAULT_CONTENT_EDITABLE_VALUE
    @bold_style_btn.click
    @editor.should have_value "<b>#{DEFAULT_CONTENT_EDITABLE_VALUE}</b>"
  end
  
  it "will set the cursor to the start of the entire content and insert 'foo'" do
    @reset_btn.click
    @editor.set_cursor_to_start
    @html_src_text_field.type "foo "
    @insert_html_button.click
    @editor.should have_value "foo #{DEFAULT_CONTENT_EDITABLE_VALUE}"
  end
  
  it "will set the cursor to the end of the entire content and insert 'bar'" do
    @reset_btn.click
    @editor.set_cursor_to_end
    @html_src_text_field.type " bar"
    @insert_html_button.click
    @editor.should have_value "#{DEFAULT_CONTENT_EDITABLE_VALUE} bar"
  end
  
  it "will delete all content" do
    @reset_btn.click
    @editor.delete_all_content
    @editor.should have_value ""
  end
  
  it "will select the word 'content' and make it bold and then unbold it" do
    @reset_btn.click
    
    body = @editor.find_element('body')
    body.should_not be_nil
    
    range = @editor.create_range
    range.set_start body, "@tn0-6"
    range.set_end body, "@tn0-13"
    range.select
    
    @editor.should have_selection "content"
    
    @bold_style_btn.should have_value false
    @bold_style_btn.click
    
    @editor.should have_value "Basic <b>content</b> editable view"
    @bold_style_btn.should have_value true
    
    @editor.select_none
    
    @bold_style_btn.should have_value false
    @editor.should have_selection ""
    
    bold_content = @editor.find_element('b')
    bold_content.should_not be_nil
    
    bold_content.select
    
    @bold_style_btn.should have_value true
    @editor.should have_selection "content"
  
    @bold_style_btn.click
    
    @bold_style_btn.should have_value false
    @editor.should have_value DEFAULT_CONTENT_EDITABLE_VALUE
  end
  
end