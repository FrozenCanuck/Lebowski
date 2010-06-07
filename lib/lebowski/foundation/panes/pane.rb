# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    module Panes
      
      #
      # Represents a proxy to the root SproutCore pane (SC.Pane)
      #
      class Pane < Lebowski::Foundation::Views::View
        
        representing_sc_class 'SC.Pane'
        
        def attached?()
          return self['isPaneAttached']
        end
        
      end
    end
  end
end