# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

require 'date'

module Lebowski
  module SCUI
    module Views

      #
      # Represents a proxy to a SCUI date picker view (SCUI.DatePickerView)
      #
      class DatePickerView < Lebowski::Foundation::Views::View
        representing_sc_class 'SCUI.DatePickerView'

        def date_selected?(date)
          return calendar.date_selected?(date)
        end
        
        def showing_month?(month)
          return calendar.showing_month?(month)
        end
        
        def showing_year?(year)
          return calendar.showing_year?(year)
        end
        
        def select_date(date)
          calendar.select_date(date)
        end
        
        def select_previous_month
          calendar.select_previous_month
        end
        
        def select_next_month
          calendar.select_next_month
        end
        
        def select_none
          calendar.select_none
        end
        
        def select_today
          calendar.select_today
        end
        
        def today_selected?
          return date_selected?(Time.now)
        end

        def display_calendar
          click_button if !self['isShowingCalendar']
        end
        
        def hide_calendar
          click_button if self['isShowingCalendar']
        end

      private   
           
        def calendar
          @calendar = DatePickerCalendar.new(self) if @calendar.nil?
          return @calendar
        end
        
        def click_button
          self['_date_button'].click
        end
      
      end
      
      class DatePickerCalendar
       
        def initialize(parent)
          @today_button = parent['_calendar_popup.contentView.todayButton']
          @none_button = parent['_calendar_popup.contentView.noneButton']
          @calendar = parent['_calendar_popup.contentView.calendar']
          @parent = parent
        end
        
        def date_selected?(date)
          curr_year = @calendar['selectedDate.year']
          curr_month = @calendar['selectedDate.month']
          curr_day = @calendar['selectedDate.day']
          
          if date.nil?
            return false if !(curr_month.nil? && curr_day.nil? && curr_year.nil?)            
          else
            return false if !((curr_month == date.month) && (curr_day == date.day) && (curr_year == date.year))            
          end
          return true
        end
        
        def showing_month?(month)
          month_displayed = @calendar['monthStartOn.month'] - 1
          return @calendar['monthStrings'][month_displayed] == month
        end
        
        def showing_year?(year)
          year_displayed = @calendar['monthStartOn.year']
          return year_displayed == year
        end
        
        def select_date(date)
          raise ArgumentError.new "A DateTime object must be provided to the pick_date method." if !(date.class == DateTime || date.class == Time)
       
          if @calendar['selectedDate'].nil?
            year_displayed = @calendar['monthStartOn.year']
            month_displayed = @calendar['monthStartOn.month']
          else
            year_displayed = @calendar['selectedDate.year']
            month_displayed = @calendar['selectedDate.month']           
          end
          
          year_diff = date.year - year_displayed
          month_diff = date.month - month_displayed

          date_diff = year_diff * 12 + month_diff

          if date_diff > 0 #date in the future
            date_diff.abs.times { select_next_month }
          elsif date_diff < 0 #date in the past
            date_diff.abs.times { select_previous_month }            
          else
            @parent.display_calendar
          end
          
          date_int = date.day + @calendar['monthStartOn.dayOfWeek'] + 1
          @calendar.child_views[date_int].click
        end
        
        def select_previous_month
          @parent.display_calendar   
          prev_month = @calendar.child_views[0]
          prev_month.click
        end
        
        def select_next_month
          @parent.display_calendar
          next_month = @calendar.child_views[1]
          next_month.click
        end
        
        def select_none
          @parent.display_calendar
          @none_button.click
        end
        
        def select_today
          @parent.display_calendar
          @today_button.click
        end
      end
      
    end
  end
end