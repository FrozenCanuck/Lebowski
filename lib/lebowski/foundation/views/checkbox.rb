# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    module Views
      
      #
      # Represents a proxy to a SproutCore button view (SC.CheckboxView)
      #
      class CheckboxView < Lebowski::Foundation::Views::View
        
        representing_sc_class 'SC.CheckboxView'
        
        # A value the view's isSelected property can return other than a boolean value
        MIXED_STATE = '__MIXED__'
        
        #
        # @override
        #
        # Need to perform a basic click so that the view will respond correctly
        #
        def click()
          mouse_down
          mouse_up
          basic_click
          stall :click
        end
        
        def deselect()
          if in_mixed_state?
            click
            click
          elsif is_selected?
            click
          end
        end
        
        def select()
          click if (not is_selected?) or in_mixed_state?
        end
        
        def is_selected?()
          val = self['isSelected']
          return (val == true or val == MIXED_STATE)
        end
        
        alias_method :is_checked?, :is_selected?
        
        #
        # Used to check if this view is in a mixed state. The view is in 
        # a mixed state if it has assigned value but nothing is selected
        #
        def in_mixed_state?()
          return (self['isSelected'] == MIXED_STATE)
        end
        
      end
    end
  end
end