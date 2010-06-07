# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    module Views
      module Support
        
        class SimpleItem
          
          attr_reader :title, :value
          
          def initialize(parent, title, value)
            @title = title
            @value = value
            @parent = parent
          end
          
          def click()
            @parent.click @title
          end
          
          def selected?()
            return @parent.selected?(@title)
          end
          
          def select()
            click if not selected?
          end
          
          def to_s()
            return "SimpleItem<title: #{title}, value: #{value}>"
          end
          
        end
        
        class SimpleItemArray
          include Lebowski::Foundation
          include Lebowski::Foundation::Views
          
          def initialize(parent, item_selector, value_rel_path=nil, items_rel_path=nil, item_title_key=nil, item_value_key=nil)
            if not parent.kind_of? View
              raise ArgumentInvalidTypeError.new "parent", parent, View
            end
    
            if not item_selector.kind_of? String
              raise ArgumentInvalidTypeError.new "item_selector", item_selector, String
            end
            
            @parent = parent
            @driver = parent.driver
            @item_selector = item_selector
            @value_rel_path = value_rel_path.nil? ? 'value' : value_rel_path
            @items_rel_path = items_rel_path.nil? ? 'items' : items_rel_path
            @item_title_key = item_title_key.nil? ? parent['itemTitleKey'] : parent[item_title_key]
            @item_value_key = item_value_key.nil? ? parent['itemValueKey'] : parent[item_value_key]
          end
          
          def selected?(value)
            return selected_with_index?(value) if (value.kind_of? Integer)
            return selected_with_title?(value) if (value.kind_of? String)
            raise ArgumentInvalidTypeError.new "value", value, Integer, String
          end
          
          def selected_count()
            value = @parent[@value_rel_path]
            return 0 if value.nil?
            return value.length if value.kind_of?(Array)
            return 1
          end
          
          def any_selected?()
            return (selected_count > 0)
          end
          
          alias_method :some_selected?, :any_selected?
          
          def all_selected?()
            return (selected_count == count)
          end
          
          def one_selected?()
            return (selected_count == 1)
          end
          
          def none_selected?()
            return (selected_count == 0)
          end
          
          def [](index)
            if index < 0 or index > count
              raise ArgumentError "index must be between 0 and #{count}"
            end
            
            items = @parent[@items_rel_path]
            return __create_simple_item(items[index])
          end
          
          def each(&block)
            items = @parent[@items_rel_path]
    
            items.each_with_index do |item, index|
              item = __create_simple_item(item)
              yield item, index
            end
          end
          
          def count(&block)
            return @parent["#{@items_rel_path}.length"] if (not block_given?)
            counter = 0
            each do |item, index|
              result = yield item, index
              counter = counter.next if (result == true)
            end
            return counter
          end

          def all?(&block)
            raise ArgumentError "require block" if (not block_given?)
            return (count(&block) == count)
          end
          
          def any?(&block)
            raise ArgumentError "require block" if (not block_given?)
            return (count(&block) > 0)
          end
          
          alias_method :some?, :any?
          
          def one?(&block)
            raise ArgumentError "require block" if (not block_given?)
            return (count(&block) == 1)
          end
          
          def none?(&block)
            raise ArgumentError "require block" if (not block_given?)
            return (count(&block) == 0)
          end
          
          def selected_with_index?(index)
            value = @parent[@value_rel_path]
            items = @parent[@items_rel_path]
            
            items.each_with_index do |item, idx|
              item_value = get_item_value(item)
              if index == idx 
                return (value == item_value) if (not value.kind_of? Array)
                return (value.member? item_value) if value.kind_of?(Array)
              end
            end
            
            return false
          end
          
          def selected_with_title?(value)
            index = find_index_with_title value
            return false if (index == :no_index)
            return selected_with_index?(index)
          end
               
          def click(value)
            if value.kind_of? Integer
              click_with_index(value) 
            elsif value.kind_of? String
              click_with_title(value)
            else
              raise ArgumentInvalidTypeError.new "value", value, Integer, String
            end
          end
          
          def click_with_index(value)
            cq = @parent.core_query(@item_selector)
            cq[value].mouse_down
            cq[value].basic_click # Required for slightly older versions of SC (pre 1.0)
            cq.done
            
            cq = @parent.core_query(@item_selector)
            cq[value].mouse_up
            cq.done
          end
            
          def click_with_title(value)
            index = find_index_with_title value
            return if (index == :no_index)
            click_with_index index
          end
          
          def select(value)
            if value.kind_of? Integer
              select_with_index(value) 
            elsif value.kind_of? String
              select_with_title(value)
            else
              raise ArgumentInvalidTypeError.new "value", value, Integer, String
            end
          end
          
          def select_with_index(index)
            item = self[index]
            item.select
          end
          
          def select_with_title(value)
            index = find_index_with_title(value)
            return if (index == :no_index)
            item = self[index]
            item.select
          end
          
          def find_index_with_title(value)
            items = @parent[@items_rel_path]      
            items.each_with_index do |item, index|
              title = get_item_title(item)
              return index if (title =~ /^#{value}/i)
            end
            
            return :no_index
          end  
          
        protected
        
          def create_simple_item(title, value)
            return SimpleItem.new self, title, value
          end
        
          def get_item_title(item)
            return item if item.kind_of? String
            return item[@item_title_key]
          end
          
          def get_item_value(item)
            return item if item.kind_of? String
            return item[@item_value_key]
          end
          
        private
          
          def __create_simple_item(item)
            return create_simple_item(get_item_title(item), get_item_value(item))
          end
          
        end
        
      end
    end
  end
end