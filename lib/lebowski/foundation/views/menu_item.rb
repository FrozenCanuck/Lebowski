# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    module Views
      
      #
      # Represents a proxy to a SproutCore menu item view (SC.MenuItemview)
      #
      class MenuItemView < Lebowski::Foundation::Views::View
        
        representing_sc_class 'SC.MenuItemView'
        
        def click()
          mouse_move
          mouse_down
          mouse_up
          
          # Need to incoporate an intentional sleep so sproutcore
          # has enough time to do its thing
          sleep 0.2
        end
        
      end
  
    end
  end
end