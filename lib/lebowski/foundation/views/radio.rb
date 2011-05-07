# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    module Views
      
      #
      # Represents a proxy to a SproutCore radio view (SC.RadioView)
      #
      class RadioView < Lebowski::Foundation::Views::View
        
        representing_sc_class 'SC.RadioView'
        
        def in_mixed_state?()
          value = self['value']
          return value.kind_of?(Array)
        end
        
        def buttons()
          @items = create_simple_item_array if @items.nil?
          return @items
        end
        
      protected
      
        def create_simple_item_array()
          return Support::RadioViewItemArray.new self
        end
        
      end
      
      module Support
      
        class RadioViewItemArray < SimpleItemArray
          
          SELECTOR = '.sc-radio-button'
          
          def click_with_index(value)
            cq = @parent.core_query(SELECTOR)
            cq[value].mouse_down
            cq.done
            
            cq = @parent.core_query(SELECTOR)
            cq[value].mouse_up
            cq.done
          end
          
        end
        
      end
      
    end
  end
end