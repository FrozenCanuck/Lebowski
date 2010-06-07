# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    module Panes
      
      #
      # Represents a proxy to a SproutCore panel pane (SC.PanelPane)
      #
      class PanelPane < Lebowski::Foundation::Panes::Pane
        
        representing_sc_class 'SC.PanelPane'
        
        # @see SC.PanelPane#modalPane
        def modal()
          return self['modalPane']
        end
                
      end
    end
  end
end