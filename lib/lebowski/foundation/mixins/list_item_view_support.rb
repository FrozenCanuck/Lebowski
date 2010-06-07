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
          source.drag_to self
        end
        
        def apply_drag_after(source)
          source.drag_to self, 0, row_height
        end
        
        def row_height()
          return @parent["rowHeightForContentIndex.#{index}"]
        end
        
      end
      
    end
  end
end