shared_examples_for "select button views" do

  describe "Select 'SC.SelectButtonView'" do
    before(:all) do
      App['controlsList'].item_views.find_first({ :name => 'SC.SelectButtonView' }).select
    end
    
    describe "Initial State Tests - Basic Button" do
      before(:all) do
        @basic_button = App['#basic-button', SelectButtonView]
      end
    
      it "will verify that the checkbox option is enabled" do
        @basic_button.should have_checkbox_enabled      
      end
          
      it "will verify that the initial value is 'One'" do
        @basic_button.should have_value 'One'
      end
          
      it "will verify that the initial title is 'One'" do
        @basic_button.should have_title 'One'
        @basic_button.should_not have_title 'Two'
      end
    
      it "will display the menu and verify that it has been displayed" do
        @basic_button.display_menu
        @basic_button.should have_menu_displayed
      end

      it "will verify that menu item 'One' is checked and the other menu items are not" do
        @basic_button.menu.should have_item_checked 'one'
        @basic_button.menu.should_not have_item_checked 'two'
        @basic_button.menu.should_not have_item_checked 'three'
        @basic_button.menu.should_not have_item_checked 'four'
        @basic_button.menu.should_not have_item_checked 'five'
      end
    
      it "will hide the menu and verify that it is not displayed" do
        @basic_button.hide_menu
        @basic_button.should_not have_menu_displayed
      end    
    end
  
    describe "Initial State Tests - Without Checkbox Button" do
      before(:all) do
        @without_checkbox = App['#without-checkbox', SelectButtonView]
      end
      
      it "will verify that the checkbox option is not enabled" do
        @without_checkbox.should_not have_checkbox_enabled
      end
    
      it "will verify that the initial value is '1'" do
        @without_checkbox.should have_value 1
        @without_checkbox.should_not have_value 2
      end
    
      it "will verify that the initial title is 'One'" do
        @without_checkbox.should have_title 'One'
        @without_checkbox.should_not have_title 'Two'
      end
    
      it "will display the menu and verify that it has been displayed" do
        @without_checkbox.display_menu
        @without_checkbox.should have_menu_displayed
      end
    
      it "will hide the menu and verify that it is not displayed" do
        @without_checkbox.hide_menu
        @without_checkbox.should_not have_menu_displayed
      end
    end
      
    describe "Menu Selection Tests" do
      before(:all) do
        @basic_button = App['#basic-button', SelectButtonView]
      end
      
      it "will select 'Five' from the menu and verify that it is selected" do
        @basic_button.select_item 'Five'
        @basic_button.should have_value 'Five'
      end
    
      it "will verify that the menu has been closed" do
        @basic_button.should_not have_menu_displayed
      end
    
      it "will select 'Four' from the menu and verify that it is selected" do
        @basic_button.select_item 'Four'
        @basic_button.should have_value 'Four'
      end
    
      it "will verify that the menu has been closed" do
        @basic_button.should_not have_menu_displayed
      end

      it "will select 'Two' from the menu and verify that it is selected" do
        @basic_button.select_item 'Two'
        @basic_button.should have_value 'Two'
      end
    
      it "will verify that the menu has been closed" do
        @basic_button.should_not have_menu_displayed
      end
        
      it "will select 'Four' from the menu and verify that it is selected" do
        @basic_button.select_item 'Four'
        @basic_button.should have_value 'Four'
      end
    
      it "will verify that the menu has been closed" do
        @basic_button.should_not have_menu_displayed
      end
    end
    
  end
  
end