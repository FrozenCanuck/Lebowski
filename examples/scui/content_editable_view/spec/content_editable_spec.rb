require '../../../../lib/lebowski/spec'

include Lebowski::Foundation
include Lebowski::SCUI::Views

App = Application.new :app_root_path => "/test_app", :app_name => "TestApp", :browser => :firefox

App.start

App.define 'basic_editor', 'mainPage.mainPane.basic', ContentEditableView
App.define 'resizable_editor', 'mainPage.mainPane.resizable', ContentEditableView

describe "VIEW: ContentEditableView" do

    describe "DEBUGGING" do
      before(:all) do
        @editor = App['basic_editor']
      end
      
      it "will debug" do
        @editor.debug
      end
    end
    break

  # describe "TEST: basic" do
  #   before(:all) do
  #     @editor = App['basic_editor']
  #   end
  #    
  #    it "will click the editor" do
  #      @editor.click
  #    end
  #    
  #    it "will print out the HTML content" do
  #      puts @editor.value
  #    end
  # end
  
  # describe "TEST: resizable" do
  #   before(:all) do
  #     @editor = App['resizable_editor']
  #   end
  #    
  #    it "will click the editor" do
  #      @editor.click
  #    end
  # 
  #    it "will print out the HTML content" do
  #      puts @editor.value
  #    end
  # end
  
end
