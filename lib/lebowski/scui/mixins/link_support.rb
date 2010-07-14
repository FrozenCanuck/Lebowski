# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module SCUI
    module Mixins
      
      module LinkSupport
        
        def start_node
          return self['startNode']
        end
        
        def end_node
          return self['endNode']
        end
        
        def start_terminal
          return self['startTerminal']
        end
        
        def end_terminal
          return self['endTerminal']
        end
        
      end
   
    end
  end
end