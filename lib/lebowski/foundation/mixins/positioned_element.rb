# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    module Mixins
   
      module PositionedElement
      
        def position()
          return Coords.new(0,0)
        end
        
        def width()
          return 0
        end
        
        def height()
          return 0
        end
        
        def position_relative_to(obj)
          if not obj.kind_of? PositionedElement
            raise ArgumentInvalidTypeError.new "obj", obj, PositionedElement
          end
          
          x = position.x - obj.position.x
          y = position.y - obj.position.y
          
          return Coords.new(x, y) 
        end
        
        def scroll_to_visible()
          
        end
        
      end
      
    end
  end
end
        