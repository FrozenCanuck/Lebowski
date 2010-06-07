require '../../../../lib/lebowski/spec'

include Lebowski::Foundation
include Lebowski::SCUI::Views

App = Application.new :app_root_path => "/test_app", :app_name => "TestApp" , :browser => :firefox

App.start

describe "VIEW: SCUI.ComboBoxView" do

  describe "TEST: init_empty" do
    App.define 'init_empty', 'mainPage.mainPane.initEmpty', ComboBoxView
    before(:all) do
      @view = App['init_empty']
    end
  
    it "will confirm that the text field is empty" do
      @view.should be_empty
      @view.should have_hint nil
    end
    
    it "will display the list and verify that the list is displayed" do
      @view.should_not have_list_displayed
      @view.display_list
      @view.should have_list_displayed
    end
      
    it "will hide the list and verify that the list is hidden" do
      @view.should have_list_displayed
      @view.hide_list
      @view.should_not have_list_displayed
    end
    
    it "will select each item in the list in order" do
      @view.select_item 0
      @view.select_item 1  
      @view.select_item 2                    
    end
        
    it "will select 'pear', followed by 'apple', followed by 'strawberry' from the list by name, and confirm" do
      @view.select_item 'pear'
      @view.should have_value 'pear'
      
      @view.select_item 'apple'
      @view.should have_value 'apple'
      
      @view.select_item 'strawberry'
      @view.should have_value 'strawberry'
    end
    
    it "will select 'pear', followed by 'apple', followed by 'strawberry' from the list by name, and confirm - capitalized, regex" do
      @view.select_item 'Pear'
      @view.should have_value 'pear'
      
      @view.select_item 'APPLE'
      @view.should have_value 'apple'
      
      @view.select_item /berry/
      @view.should have_value 'strawberry'
    end
    
    it "will attempt to select 'mango' from the list and verify that it was not selected." do
      @view.select_item 'mango'
      @view.should have_value 'strawberry'
    end

    it "will confirm that 'cranberry' is not in the list" do
      @view.list.should_not have_some 'cranberry'      
      @view.list.should have_none 'cranberry'
    end    

    it "will confirm that 'apple' is in the list once" do
      @view.list.should have_some 'apple'
      @view.list.should have_one 'apple'
      @view.list.should have_count(1, 'apple')
    end
    
    it "will confirm that typing 'p' leaves two items in the list" do
      @view.list.should have_count(2, 'p')
    end
  end
  
  describe "TEST: init_hint" do
    App.define 'init_hint', 'mainPage.mainPane.initHint', ComboBoxView
    before(:all) do
      @view = App['init_hint']
    end
    
    it "will confirm that the text field is empty" do
      @view.should be_empty
    end
    
    it "will confirm the text field has hint 'Fruit'" do
      @view.should have_hint 'Fruit'
    end
    
    it "will select each item in the list in order" do
      @view.select_item 0
      @view.select_item 1
      @view.select_item 2            
    end
  end
  
  describe "TEST: init_set" do
    App.define 'init_set', 'mainPage.mainPane.initSet', ComboBoxView
    before(:all) do
      @view = App['init_set']
    end
    
    it "will confirm the text field has value 'strawberry'" do
      @view.should have_value 'strawberry'
    end

    it "will select each item in the list in order" do
      @view.select_item 0
      @view.select_item 1
      @view.select_item 2            
    end
  end
  
  describe "TEST: text_area" do
    App.define 'text_area', 'mainPage.mainPane.textArea', ComboBoxView
    before(:all) do
      @view = App['text_area']
    end
    
    it "will confirm that the text field is empty" do
      @view.should be_empty
      @view.should have_hint nil
    end
    
    it "will select each item in the list in order" do
      @view.select_item 0
      @view.select_item 1
      @view.select_item 2            
    end
  end
  
  describe "TEST: objects_empty" do
    App.define 'objects_empty', 'mainPage.mainPane.objectsEmpty', ComboBoxView
    before(:all) do
      @view = App['objects_empty']
    end
    
    it "will confirm that the text field is empty" do
      @view.should be_empty
      @view.should have_hint nil
    end
  end
  
  describe "TEST: many_objects" do
    App.define 'many_objects', 'mainPage.mainPane.manyObjects', ComboBoxView
    before(:all) do
      @view = App['many_objects']
    end
    
    it "will confirm that the text field is empty" do
      @view.should be_empty
      @view.should have_hint nil
    end

    it "will select each item in the list in order" do
      @view.select_item 'a'
      @view.should have_value 'A'
      
      @view.select_item 'z'
      @view.should have_value 'Z'
      
      @view.select_item 0
      @view.should have_value 'A'
      
      @view.select_item 25
      @view.should have_value 'Z'
    end
  end
  
end
