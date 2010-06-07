# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    module Views
      
      #
      # Represents a proxy to a SproutCore disclosure view (SC.DisclosureView)
      #
      class DisclosureView < Lebowski::Foundation::Views::ButtonView
        
        representing_sc_class 'SC.DisclosureView'
        
        #
        # Used to determine if this view's toggle is on
        #
        def is_toggled_on?()
          val = self['value']
          return (val == self['toggleOnValue'] or val.kind_of?(Array))
        end
        
        #
        # Used to determine if this view's toggle is off
        #
        def is_toggled_off?()
          return (self['value'] == self['toggleOffValue'])
        end
        
        def toggle_on()
          if in_mixed_state? 
            click
            click
          elsif is_toggled_off?
            click
          end
        end
        
        def toggle_off()
          click if (in_mixed_state? or is_toggled_on?)
        end
        
        #
        # Used to determine if this view is in a mixed state. The view is
        # in a mixed state when it has a value when it has more than one
        # value (e.g. [true, false])
        #
        def in_mixed_state?()
          val = self['value']
          return val.kind_of?(Array)
        end
        
      end
      
    end
  end
end