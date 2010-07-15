shared_examples_for "label views" do
  
  describe "Label Views" do
    
    before(:all) do
      App['controlsList'].item_views.find_first({ :name => 'SC.LabelView' }).select
      @basic_label = App['#basic-label', LabelView]
      @foo_button = App['#basic-label-foo-button', ButtonView]
      @bar_button = App['#basic-label-bar-button', ButtonView]
      @editable_label = App['#editable-label', LabelView]
    end
    
    it "will confirm views' initial property settings" do
      @basic_label.should have_value that_is_empty
      @basic_label.should_not be_editable
      
      @foo_button.should have_title /foo/i
      @bar_button.should have_title /bar/i
      
      @editable_label.should have_value /edit me/i
      @editable_label.should be_editable
    end
    
    describe "Basic Label" do
      
      it "will click the foo button and confirm the label's value is 'foo'" do
        @foo_button.click
        @basic_label.should have_value /foo/i
      end
      
      it "will click the bar button and confirm the label's value is 'bar'" do
        @bar_button.click
        @basic_label.should have_value /bar/i
      end
      
      it "will try to edit the label to be 'hello' and confirm the label was not edited" do
        @basic_label.edit 'hello'
        @basic_label.should_not have_value 'hello'
        @basic_label.should have_value 'bar'
      end
      
    end
    
    describe "Editable Label" do
      
      it "will edit the label to have the value 'foobar' and confirm" do
        @editable_label.edit 'foobar'
        @editable_label.should have_value 'foobar'
      end
      
      it "will edit the label again to have the value 'hello' and confirm" do
        @editable_label.edit 'hello'
        @editable_label.should have_value 'hello'
      end
      
    end
    
  end
  
end