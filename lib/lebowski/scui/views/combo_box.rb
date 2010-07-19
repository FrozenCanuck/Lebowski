# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module SCUI
    module Views

      #
      # Represents a proxy to a SCUI combo box view (SCUI.ComboBoxView)
      #
      class ComboBoxView < Lebowski::Foundation::Views::View
        
        representing_sc_class 'SCUI.ComboBoxView'

        def empty?
          val = self['value']
          return (val.nil? or val.empty?)
        end

        def display_list
          click_button if !list_displayed?
        end
        
        def hide_list
          click_button if list_displayed?
        end
        
        def list_displayed?
          return list_pane.isPaneAttached
        end

        def select_item(item)
          list.select_item(item)
        end

        def list
          if @list.nil?
            if sc_path_defined?('_listPane.contentView.listView.contentView')
              @list = ComboBoxList.new(self, '_listPane.contentView.listView.contentView', @driver)
            else
              @list = ComboBoxList.new(self, '_listPane.contentView.contentView', @driver)
            end
          end
          return @list
        end
        
      private
        def list_pane
          @list_pane = self['_listPane'] if @list_pane.nil?
          return @list_pane
        end
        
        def click_button
          self['dropDownButtonView'].click
        end
      end
      
    end
    
    class ComboBoxList < Lebowski::Foundation::Views::ListView
      
      def count?(expected_count, item)
        type(item)
        return (item_views.count == expected_count)
      end
      
      def any?(item)
        type(item)
        return item_views.any?({value_key => /#{item}/i})
      end
      
      alias_method :some?, :any?
      
      def one?(item)
        type(item)
        return item_views.one?({value_key => /#{item}/i})
      end
      
      def none?(item)
        type(item)
        item_views.none?({value_key => /#{item}/i})
      end
              
      def select_item(item)
        @parent.display_list
        if item.kind_of? Integer
          select_item_by_index(item)
        elsif item.kind_of? String
          select_item_by_name(item)
        else
          raise ArgumentError.new "The argument must be either an integer or a string."
        end
        @parent.hide_list
      end

    private
      def value_key
        @value_key = self['contentValueKey'] if @value_key.nil?
        return @value_key
      end
      
      def select_item_by_index(index)
        raise ArgumentError.new "Index out of range. The item number must be greater than or equal to zero." if (index < 0)
        raise ArgumentError.new "Index out of range. There are fewer than #{index.to_s} items in the list." if (index >= item_views.count)          
        item_views[index].select            
      end

      def select_item_by_name(name)          
        if any?(name)
          item_views.find_first({value_key => /#{name}/i}).select 
        end
      end
      
      def type(text)
        @parent.child_views[0].type_keys(text)
      end
    end
    
  end
end