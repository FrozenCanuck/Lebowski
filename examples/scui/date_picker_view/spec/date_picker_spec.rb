require '../../../../lib/lebowski/spec'

include Lebowski::Foundation
include Lebowski::SCUI::Views

App = MainApplication.new :app_root_path => "/test_app", :app_name => "TestApp", :browser => :firefox

App.start
App.define 'date_empty', 'mainPage.mainPane.dateEmpty', DatePickerView
App.define 'date_today', 'mainPage.mainPane.dateToday', DatePickerView

describe "VIEW: SCUI.DatePickerView" do
  
  describe "TEST: date_empty" do
    before(:all) do
      @view = App['date_empty']
    end

    it "will confirm that a date is not displayed" do
      @view.should have_date_selected nil
    end

    it "will display the calendar" do
      @view.display_calendar
    end
    
    it "will hide the calendar" do
      @view.hide_calendar
    end
    
    it "will select 'Today'" do
      @view.select_today
    end
    
    it "will confirm that today's date is displayed" do
      @view.should have_today_selected
    end

    it "will confirm that 2010 is displayed, and that 2011 is not displayed" do
      @view.should be_showing_year 2010
      @view.should_not be_showing_year 2011
    end
    
    it "will select 'None'" do
      @view.select_none
    end
    
    it "will confirm that a date is not displayed" do
      @view.should have_date_selected nil
    end
    
    it "will select the next month" do
      @view.should be_showing_month 'May'
      @view.select_next_month
      @view.should be_showing_month 'June'
    end
    
    it "will select the previous month" do
      @view.should be_showing_month 'June'      
      @view.select_previous_month
      @view.should be_showing_month 'May'      
    end
    
    it "will select Feb. 10, 2010 and confirm" do
      @view.select_date DateTime.new(2010, 2, 10)
      @view.should be_showing_month 'February'
      @view.should be_showing_year 2010
      @view.should have_date_selected DateTime.new(2010, 2, 10)      
    end
    
    it "will select 'Today' and confim" do
      @view.select_today
      @view.should have_today_selected
    end
    
    it "will select June 15, 2010 and confim" do
      @view.select_date DateTime.new(2010, 6, 15)
      @view.should have_date_selected DateTime.new(2010, 6, 15)
    end
    
    it "will select 'Today' and confim" do
      @view.select_today
      @view.should have_today_selected
    end
    
    it "will select Feb. 10, 2011 and confirm" do
      @view.select_date DateTime.new(2011, 2, 10)
      @view.should have_date_selected DateTime.new(2011, 2, 10)      
    end
    
    it "will select 'Today' and confim" do
      @view.select_today
      @view.should have_today_selected
    end
    
    it "will select June 15, 2011 and confim" do
      @view.select_date DateTime.new(2011, 6, 15)
      @view.should have_date_selected DateTime.new(2011, 6, 15)
    end
    
    it "will select 'Today' and confim" do
      @view.select_today
      @view.should have_today_selected
    end
    
    it "will select Feb. 10, 2009 and confirm" do
      @view.select_date DateTime.new(2009, 2, 10)
      @view.should have_date_selected DateTime.new(2009, 2, 10)      
    end
    
    it "will select 'Today' and confim" do
      @view.select_today
      @view.should have_today_selected
    end
    
    it "will select June 15, 2009 and confim" do
      @view.select_date DateTime.new(2009, 6, 15)
      @view.should have_date_selected DateTime.new(2009, 6, 15)
    end
  end
  
  describe "TEST: date_today" do
    before(:all) do
      @view = App['date_today']
    end
  
    it "will confirm that today's date is displayed" do
      @view.should have_today_selected
    end
    
    it "will select 'None'" do
      @view.select_none
    end
    
    it "will confirm that a date is not displayed" do
      @view.should have_date_selected nil
    end
    
    it "will select 'Today'" do
      @view.select_today
    end
    
    it "will confirm that today's date is displayed" do
      @view.should have_today_selected
    end

    it "will confirm that 2010 is displayed, and that 2011 is not displayed" do
      @view.should be_showing_year 2010
      @view.should_not be_showing_year 2011
    end
    
    it "will select 'None' and confirm" do
      @view.select_none
      @view.should have_date_selected nil      
    end

    it "will select Feb. 10, 2010 and confirm" do
      @view.select_date DateTime.new(2010, 2, 10)
      @view.should have_date_selected DateTime.new(2010, 2, 10)      
    end
    
    it "will select June 15, 2010 and confim" do
      @view.select_date DateTime.new(2010, 6, 15)
      @view.should have_date_selected DateTime.new(2010, 6, 15)
    end
    
    it "will select Feb. 10, 2011 and confirm" do
      @view.select_date DateTime.new(2011, 2, 10)
      @view.should have_date_selected DateTime.new(2011, 2, 10)      
    end
    
    it "will select June 15, 2011 and confim" do
      @view.select_date DateTime.new(2011, 6, 15)
      @view.should have_date_selected DateTime.new(2011, 6, 15)
    end
    
    it "will select Feb. 10, 2009 and confirm" do
      @view.select_date DateTime.new(2009, 2, 10)
      @view.should have_date_selected DateTime.new(2009, 2, 10)      
    end
    
    it "will select June 15, 2009 and confim" do
      @view.select_date DateTime.new(2009, 6, 15)
      @view.should have_date_selected DateTime.new(2009, 6, 15)
    end
  end
    
end
