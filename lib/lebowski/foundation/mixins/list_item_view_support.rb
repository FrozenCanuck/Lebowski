# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    module Mixins
        
      #
      # Mixin provides support to any view that will act as a list item view
      # for a list view. 
      #
      module ListItemViewSupport
        include CollectionItemViewSupport
        
        def can_drag_before?()
          return true
        end
        
        def can_drag_after?()
          return true
        end
        
        def apply_drag_before(source)
          params = { 
            :mouse_offset_x => :center, 
            :mouse_offset_y => :center 
          }
          source.drag_to self, (self.width / 2).floor, 2, params
        end
        
        def apply_drag_after(source)
          params = { 
            :mouse_offset_x => :center, 
            :mouse_offset_y => :center
          }
          source.drag_to self, (self.width / 2).floor, row_height, params
        end
        
        def row_height()
          return @parent["rowHeightForContentIndex.#{index}"]
        end
        
      end
      
    end
  end
end