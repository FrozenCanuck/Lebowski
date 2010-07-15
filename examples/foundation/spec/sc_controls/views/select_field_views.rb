shared_examples_for "select field views" do
  
  describe "Select Field Views" do
    
    before(:all) do
      App['controlsList'].item_views.find_first({ :name => 'SC.SelectFieldView' }).select
      @first_basic_select_field = App['#first-basic-select-field', SelectFieldView]
      @second_basic_select_field = App['#second-basic-select-field', SelectFieldView]
      @empty_select_field = App['#empty-option-select-field', SelectFieldView]
      @sorted_select_field = App['#sorted-select-field', SelectFieldView]
      @disabled_select_field = App['#disabled-select-field', SelectFieldView]
    end
    
    it "will confirm views' initial property settings" do
      @first_basic_select_field.should be_selected
      @first_basic_select_field.should_not have_empty_option
      @first_basic_select_field.should have_selected_with_name 'square'
      @first_basic_select_field.should have_selected_with_value 'square'
      
      @second_basic_select_field.should be_selected
      @second_basic_select_field.should_not have_empty_option
      @second_basic_select_field.should have_selected_with_name 'circle'
      @second_basic_select_field.should have_selected_with_value 2000
      
      @empty_select_field.should_not be_selected
      @empty_select_field.should have_empty_option
      
      @sorted_select_field.should be_selected
      @sorted_select_field.should_not have_empty_option
      @sorted_select_field.should have_selected_with_name 'apple'
      @sorted_select_field.should have_selected_with_value 'apple'

      @disabled_select_field.should_not be_enabled
    end
    
    describe "First Basic Select Field" do
      
      it "will select option with name 'circle' and confirm" do
        @first_basic_select_field.select_with_name 'circle'
        
        @first_basic_select_field.should be_selected
        @first_basic_select_field.should have_selected_with_name 'circle'
        @first_basic_select_field.should have_selected_with_value 'cirlce'
      end
      
      it "will select option with value 'triangle' and confirm" do
        @first_basic_select_field.select_with_value 'triangle'
        
        @first_basic_select_field.should be_selected
        @first_basic_select_field.should have_selected_with_name 'triangle'
        @first_basic_select_field.should have_selected_with_value 'triangle'
      end
      
      it "will select option with index 0 (square) and confirm" do
        @first_basic_select_field.select_with_index 0
        
        @first_basic_select_field.should be_selected
        @first_basic_select_field.should have_selected_with_name 'circle'
        @first_basic_select_field.should have_selected_with_value 'circle'
      end
      
    end
    
    describe "Second Basic Select Field" do
      
      it "will select option with name 'square' and confirm" do
        @second_basic_select_field.select_with_name 'square'
        
        @second_basic_select_field.should be_selected
        @second_basic_select_field.should have_selected_with_name 'square'
        @second_basic_select_field.should have_selected_with_value 1000
      end
      
      it "will select option with value 3000 (triangle) and confirm" do
        @second_basic_select_field.select_with_value 3000
        
        @second_basic_select_field.should be_selected
        @second_basic_select_field.should have_selected_with_name 'triangle'
        @second_basic_select_field.should have_selected_with_value 3000
      end
      
      it "will select option with index 1 (circle) and confirm" do
        @second_basic_select_field.select_with_index 0
        
        @second_basic_select_field.should be_selected
        @second_basic_select_field.should have_selected_with_name 'circle'
        @second_basic_select_field.should have_selected_with_value 2000
      end
      
    end
    
    describe "Empty Option Selet Field" do
      
      it "will select option with name 'circle' and confirm the field is selected" do
        @empty_select_field.select_with_name 'circle'
        
        @empty_select_field.should be_selected
        @empty_select_field.should have_selected_with_name 'circle'
      end
      
      it "will select the empty option and confirm the field is not selected" do
        @empty_select_field.select_empty
        @empty_select_field.should_not be_selected
      end
      
    end
    
    describe "Sorted Select Field" do
      
      it "will select the option with name 'zebra' and confirm" do
        @sorted_select_field.select_with_name 'zebra'
        
        @sorted_select_field.should be_selected
        @sorted_select_field.should have_selected_with_name 'zebra'
        @sorted_select_field.should have_selected_with_value 'zebra'
      end
      
    end
    
  end
  
end