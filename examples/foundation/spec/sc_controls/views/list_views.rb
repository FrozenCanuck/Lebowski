describe "List View Tests" do
    
  before(:all) do
    App['controlsList'].item_views.find_first({ :name => 'SC.ListView' }).select
    @first_employee_list = App['#first-employee-list', ListView]
    @second_employee_list = App['#second-employee-list', ListView]
    @third_employee_list = App['#third-employee-list', ListView]
    @list_status_label = App['#list-status-label', LabelView]
  end
  
  it "will confirm views' initial property settings" do
    @list_status_label.should have_value /no items selected/i
    
    @first_employee_list.content.should have_count 15
    @first_employee_list.item_views.selected.should have_count 0
    
    @second_employee_list.content.should have_count 0
  end
  
  describe "Collection View Tests" do
     
    describe "Basic Item View Tests" do
     
      it "will confirm the list has 15 item views" do
        @first_employee_list.item_views.should have_count 15
      end
           
      it "will get the first item from the list and confirm" do
        iv = @first_employee_list.item_views.first
        iv.should_not be_nil
        iv.content.should have_guid '1'
        iv.content.should have_first_name /bob/i
        iv.content.should have_last_name /izzo/i
        iv.content.should have_title /architect/i
        iv.content.should have_company /microsoft/i
             
        iv = @first_employee_list.item_views[0]
        iv.should_not be_nil
        iv.content.should have_guid '1'
      end
           
      it "will get the last item from the list and confirm" do
        iv = @first_employee_list.item_views.last
        iv.should_not be_nil
        iv.content.should have_guid '9'
        iv.content.should have_first_name /jim/i
        iv.content.should have_last_name /jones/i
        iv.content.should have_title /director of finance/i
        iv.content.should have_company /verizon/i
             
        iv = @first_employee_list.item_views[14]
        iv.should_not be_nil
        iv.content.should have_guid '9'
      end
           
      it "will find all item views with content having company 'microsoft' and confirm" do
        @first_employee_list.item_views.should have_count({ :company => /microsoft/i }, 2)
        @first_employee_list.item_views.should have_some({ :company => /microsoft/i })
        @first_employee_list.item_views.should_not have_none({ :company => /microsoft/i })
             
        ivs = @first_employee_list.item_views.find_all({ :company => /microsoft/i })
        ivs.should_not be_nil
        ivs.should have_length 2
        ivs[0].content.should have_guid '1'
        ivs[1].content.should have_guid '6'
             
        ivs = @first_employee_list.item_views.filter({ :company => /microsoft/i })
        ivs.should have_count 2
        ivs[0].content.should have_guid '1'
        ivs[1].content.should have_guid '6'
      end
      
      it "will find the first item view with content having company 'wigets inc' and confirm" do
        iv = @first_employee_list.item_views.find_first({ :company => /widgets inc/i })
        iv.should_not be_nil
        iv.content.should have_guid '11'
        iv.content.should have_first_name /sean/i
        iv.content.should have_last_name /caillat/i
        iv.content.should have_company /widgets inc/i
      end
      
      it "will find the last item view with content having company 'wigets inc' and confirm" do
        iv = @first_employee_list.item_views.find_last({ :company => /widgets inc/i })
        iv.should_not be_nil
        iv.content.should have_guid '13'
        iv.content.should have_first_name /norah/i
        iv.content.should have_last_name /jackson/i
        iv.content.should have_company /widgets inc/i
      end
      
      it "will access an item view's neighbouring item views" do
        first_item_view = @first_employee_list.item_views.first
        first_item_view.should have_index 0
        
        iv = first_item_view.previous_item_view
        iv.should be_nil
        
        iv = first_item_view.previous_item_view 2
        iv.should be_nil
        
        iv = first_item_view.next_item_view
        iv.should_not be_nil
        iv.should have_index 1
        iv.content.should have_guid '10'
        iv.content.should have_full_name /benny hill/i
        
        iv = first_item_view.next_item_view 2
        iv.should_not be_nil
        iv.should have_index 2
        iv.content.should have_guid '11'
        iv.content.should have_full_name /sean caillat/i
        
        iv = first_item_view.next_item_view 16
        iv.should be_nil
        
        last_item_view = @first_employee_list.item_views.last
        last_item_view.should have_index 14
        
        iv = last_item_view.next_item_view
        iv.should be_nil
        
        iv = last_item_view.next_item_view 2
        iv.should be_nil
        
        iv = last_item_view.previous_item_view
        iv.should_not be_nil
        iv.should have_index 13
        iv.content.should have_guid '8'
        iv.content.should have_full_name /trey paul/i
        
        iv = last_item_view.previous_item_view 2
        iv.should_not be_nil
        iv.should have_index 12
        iv.content.should have_guid '7'
        iv.content.should have_full_name /lily allen/i
      end
      
      it "will confirm there is no item view with guid '100'" do
        @first_employee_list.item_views.should_not have_any({ :guid => '100' })
        @first_employee_list.item_views.should have_none({ :guid => '100' })
        iv = @first_employee_list.item_views.find_first({ :guid => '100' })
        iv.should be_nil
            
        @list_status_label.should have_value /no items selected/i
      end
         
    end
  
    describe "Selection Tests" do
   
      it "will select the fist item in the list and confirm" do
        @first_employee_list.item_views[0].select
        @first_employee_list.item_views.selected.should have_count 1
            
        iv = @first_employee_list.item_views[0]
        iv.should be_selected
        iv.content.should have_guid '1'
        iv.content.should have_first_name /bob/i
        iv.content.should have_last_name /izzo/i
            
        @list_status_label.should have_value /\[1\]$/i
      end
          
      it "will select the item view with guid '9' and confirm it is the only one selected" do
        @first_employee_list.item_views.should have_one({ :guid => '9' })
            
        iv = @first_employee_list.item_views.find_first({ :guid => '9' })
        iv.should_not be_nil
        iv.content.should have_guid '9'
        iv.content.should have_first_name /jim/i
        iv.content.should have_last_name /jones/i
            
        iv.select
            
        iv.should be_selected
        @first_employee_list.item_views.selected.should have_count 1
            
        iv2 = @first_employee_list.item_views.selected[0]
            
        iv.content.should eql iv2['content']
            
        @list_status_label.should have_value /\[9\]$/i
      end
          
      it "will deselect all items and confirm" do
        @first_employee_list.item_views.deselect_all
        @first_employee_list.item_views.selected.should have_count 0
      end
          
      it "will confirm that there are two item views with title matching /manager/i and select them" do
        @first_employee_list.item_views.should have_some({ :title => /manager/i })
        @first_employee_list.item_views.should_not have_all({ :title => /manager/i })
        @first_employee_list.item_views.should_not have_none({ :title => /manager/i })
        @first_employee_list.item_views.should_not have_one({ :title => /manager/i })
        @first_employee_list.item_views.should have_count({ :title => /manager/i }, 2)
            
        ivs = @first_employee_list.item_views.find_all({ :title => /manager/i })
        ivs.should have_length 2
            
        @first_employee_list.item_views.select({ :title => /manager/i })
            
        @first_employee_list.item_views.selected.should have_count 2
            
        iv = @first_employee_list.item_views.selected.find_first({ :guid => '2' })
        iv.should_not be_nil
        iv.should be_selected
        iv.content.should have_guid '2'
        iv.content.should have_first_name /joe/i
        iv.content.should have_last_name /mcdonnel/i
        iv.content.should have_title /^manager$/i
            
        iv = @first_employee_list.item_views.selected.find_first({ :guid => '7' })
        iv.should_not be_nil
        iv.should be_selected
        iv.content.should have_guid '7'
        iv.content.should have_first_name /lily/i
        iv.content.should have_last_name /allen/i
        iv.content.should have_title /^senior manager$/i
            
        @list_status_label.should have_value /\[2,7\]$/i
      end
          
      it "will a select range of item views that sit between guid 10 and guid 13 and confirm" do
        iv1 = @first_employee_list.item_views.find_first({ :guid => '10' })
        iv2 = @first_employee_list.item_views.find_first({ :guid => '13' })
        iv3 = @first_employee_list.item_views.find_first({ :guid => '14' })
            
        @first_employee_list.item_views.select_range iv1, iv2
            
        selected = @first_employee_list.item_views.selected
        selected.should have_count 4
        selected.should have_one({ :guid => '10' })
        selected.should have_one({ :guid => '11' })
        selected.should have_one({ :guid => '12' })
        selected.should have_one({ :guid => '13' })
        selected.should have_none({ :guid => '14' })
            
        selected.should have_member iv1
        selected.should have_member iv2
        selected.should_not have_member iv3
            
        @list_status_label.should have_value /\[10,11,12,13\]$/i
      end
           
      it "will select all item views and confirm" do
        @first_employee_list.item_views.deselect_all
        @first_employee_list.item_views.selected.should have_count 0
      
        @first_employee_list.item_views.select_all
      
        selected = @first_employee_list.item_views.selected 
        selected.should have_count 15
          
        iv = selected.first
        iv.should_not be_nil
        iv.content.should have_guid '1'
          
        iv = selected.last
        iv.should_not be_nil
        iv.content.should have_guid '9'
      end
     
      it "will select and deselect individual item views from an active selection and confirm changes" do          
        @first_employee_list.item_views.deselect_all
        
        # TODO: Temporary. Need to click the first item. There is odd behavior with the item view's selection.
        # Although there are no items selected, the first item view's isSelected property comes
        # back as true. This appears to be a bug in SproutCore, but will have to investigate 
        # further.
        @first_employee_list.item_views[0].click
        
        @first_employee_list.item_views[0].select
        @first_employee_list.item_views.selected.should have_count 1
        
        @first_employee_list.item_views[1].select_add
        @first_employee_list.item_views.selected.should have_count 2
        
        @first_employee_list.item_views[0].deselect
        @first_employee_list.item_views.selected.should have_count 1
      end
      
      it "will add to selection based on use of filter and confirm changes" do
        
        @first_employee_list.item_views.deselect_all
        
        @first_employee_list.item_views.select({ :company => /verizon/i })
        @first_employee_list.item_views.selected.should have_count 2
        
        @first_employee_list.item_views.select_add({ :company => /google/i })
        @first_employee_list.item_views.selected.should have_count 6
        
      end
      
    end
   
  end
  
  describe "List View Tests" do
  
    # TODO
  
  end
  
  describe "List Item View Tests" do
    
    # TODO
    
  end
  
end