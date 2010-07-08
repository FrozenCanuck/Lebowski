require '../../../../lib/lebowski/spec'

include Lebowski::Foundation
include Lebowski::SCUI::Views

App = Application.new :app_root_path => "/test_app", :app_name => "TestApp"

App.start do |app|
  app['mainPage.mainPane.isPaneAttached'] == true
end

App.window.move_to 1, 1 
App.window.resize_to 1024, 768

describe "SCUI.ContentEditableView Tests" do
  
  before(:all) do
    @editor = App['#basic-content-editor', ContentEditableView]
  end
    
  it "will confirm initial property settings" do
    @editor.should have_empty_selection
    @editor.should have_value /^basic content editable view$/i
    @editor.should_not have_image_selected
    @editor.should_not have_hyperlink_selected
  end
  
  describe "Find Elements Test" do
    
    it "will debug" do
      
    end
    
  end
  
end
