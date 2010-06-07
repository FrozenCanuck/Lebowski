# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    module Views
      
      #
      # Represents a proxy to a SproutCore segemented view (SC.SegmentedView)
      #
      class SegmentedView < Lebowski::Foundation::Views::View

        representing_sc_class 'SC.SegmentedView'
        
        def allowed_empty_selection?()
          return self['allowsEmptySelection']
        end
        
        def allowed_multiple_selection?()
          return self['allowsMultipleSelection']
        end
        
        def buttons()
          @items = create_simple_item_array if @items.nil?
          return @items
        end
        
      protected
      
        def create_simple_item_array()
          return Support::SegmentItemArray.new self, '.sc-segment'
        end
        
      end
      
      module Support
      
        class SegmentItem < SimpleItem
          
          def deselect()
            view = @parent.segmented_view
            allow_empty = view.allowed_empty_selection?
            allow_multiple = view.allowed_multiple_selection?
            if allow_empty and allow_multiple
              click if selected?
            elsif allow_empty
              click if selected?
            elsif allow_multiple
              click if (selected? and @parent.selected_count > 1)
            end
          end
          
        end
      
        class SegmentItemArray < SimpleItemArray
          
          def segmented_view()
            return @parent
          end
          
          def deselect(value)
            if value.kind_of? Integer
              deselect_with_index(value) 
            elsif value.kind_of? String
              deselect_with_title(value)
            else
              raise ArgumentInvalidTypeError.new "value", value, Integer, String
            end
          end
          
          def deselect_with_index(index)
            item = self[index]
            item.deselect
          end
          
          def deselect_with_title(value)
            index = find_index_with_title(value)
            return if (index == :no_index)
            item = self[index]
            item.deselect
          end
        
        protected
        
          def create_simple_item(title, value)
            return SegmentItem.new self, title, value
          end
        
        end
      
      end
      
    end
  end
end