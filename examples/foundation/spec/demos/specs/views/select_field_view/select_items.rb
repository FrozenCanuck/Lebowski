describe "Select Field View Tests" do
    
  before(:all) do
    show_control :select_field_view
    @app = App.get_instance
    page = @app['selectFieldViewsPage']
    @basic_select_field1 = page['basicSelectField1', SelectFieldView]
    @basic_select_field2 = page['basicSelectField2', SelectFieldView]
    @empty_option_select_field = page['emptyOptionSelectField', SelectFieldView]
    @sorted_select_field = page['sortedSelectField', SelectFieldView]
    @long_select_field = page['largeSelectField', SelectFieldView]
    @reset_button = page['resetButton', ButtonView]
  end
  
  before(:each) do
    @reset_button.click
  end
  
  it "will change select field view's value by item's name" do
  
    @basic_select_field1.should_not have_empty_option
    
    @basic_select_field1.select_with_name 'triangle'
    
    @basic_select_field1.should have_value 'triangle'
    @basic_select_field1.should have_selected_with_name 'triangle'
    @basic_select_field1.should have_selected_with_value 'triangle'
    
    @basic_select_field1.select_with_value 'circle'
    
    @basic_select_field1.should have_value 'circle'
    @basic_select_field1.should have_selected_with_name 'circle'
    @basic_select_field1.should have_selected_with_value 'circle'
    
    @basic_select_field1.select 'square'
    
    @basic_select_field1.should have_value 'square'
    @basic_select_field1.should have_selected_with_name 'square'
    @basic_select_field1.should have_selected_with_value 'square'
    
  end
  
  it "will change select field view's value by item's value" do
  
    @basic_select_field2.should_not have_empty_option
    
    @basic_select_field2.select_with_value 3000
    
    @basic_select_field2.should have_value 3000
    @basic_select_field2.should have_selected_with_name 'triangle'
    @basic_select_field2.should have_selected_with_value 3000
    
    @basic_select_field2.select_with_value 1000
    
    @basic_select_field2.should have_value 1000
    @basic_select_field2.should have_selected_with_name 'square'
    @basic_select_field2.should have_selected_with_value 1000
    
    @basic_select_field2.select_with_value 2000
    
    @basic_select_field2.should have_value 2000
    @basic_select_field2.should have_selected_with_name 'circle'
    @basic_select_field2.should have_selected_with_value 2000
    
  end
  
  it "will change field's value from empty and back to empty" do
    
    @empty_option_select_field.should have_empty_option
    @empty_option_select_field.should_not be_selected
    
    @empty_option_select_field.select 'square'
    
    @empty_option_select_field.should be_selected
    @empty_option_select_field.should have_value 'square'
    
    @empty_option_select_field.select_empty
    
    @empty_option_select_field.should_not be_selected
    
    @empty_option_select_field.select 'circle'
    
    @empty_option_select_field.should be_selected
    @empty_option_select_field.should have_value 'circle'
    
    @empty_option_select_field.select :empty
    
    @empty_option_select_field.should_not be_selected
  
  end
  
  it "will select sorted items" do
    
    @sorted_select_field.should_not have_empty_option
    
    @sorted_select_field.select_with_name 'cat'  
    @sorted_select_field.should have_value 'cat'
  
    @sorted_select_field.select_with_value 'kite'
    @sorted_select_field.should have_value 'kite'
    
    @sorted_select_field.select 'zebra'
    @sorted_select_field.should have_value 'zebra'
    
  end
  
  it "will select items from long select field" do
    
    @long_select_field.select_with_name 'item 70'
    @long_select_field.should have_value 'item 70'
    
    @long_select_field.select_with_value 'item 5'
    @long_select_field.should have_value 'item 5'
    
    @long_select_field.select 'item 99'
    @long_select_field.should have_value 'item 99'
    
  end
  
end