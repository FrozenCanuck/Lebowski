# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    
    # Constants used by the picker pane. see SproutCore file picker.js
    SC_PICKER_MENU = 'menu'
    SC_PICKER_FIXED = 'fixed'
    SC_PICKER_POINTER = 'pointer'
    
    module Panes
      
      #
      # Represents a proxy to a SproutCore picker pane (SC.PickerPane)
      #
      class PickerPane < Lebowski::Foundation::Panes::PalettePane
        
        representing_sc_class 'SC.PickerPane'
        
        def is_fixed?()
          return (self['preferType'] == SC_PICKER_FIXED)
        end
        
        def is_menu?()
          return (self['preferType'] == SC_PICKER_MENU)
        end
        
        def is_pointer?()
          return (self['preferType'] == SC_PICKER_POINTER)
        end
        
        def click_off()
          modal.click_at(0, 0)
        end
        
      end
      
    end
  end
end