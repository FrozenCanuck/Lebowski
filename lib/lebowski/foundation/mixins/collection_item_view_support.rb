module Lebowski
  module Foundation
    module Mixins
        
      #  
      # Mixin is used to provide colletion item view support to any view that 
      # that will be an item view for a collection view
      #
      module CollectionItemViewSupport
  
        def has_collection_item_view_support()
          return true
        end
  
        def index()
          return @parent.item_views.index_of self
        end
  
        def next_item_view(offset=nil)
          idx = @parent.item_views.index_of self
          return nil if idx < 0
          items_count = @parent.item_views.count
          offset = offset.nil? ? 1 : offset
          return nil if (idx + offset) >= items_count
          return @parent.item_views[idx + offset]
        end
  
        def previous_item_view(offset=nil)
          idx = @parent.item_views.index_of self
          return nil if idx < 0
          offset = offset.nil? ? 1 : offset
          return nil if (idx - offset) < 0
          return @parent.item_views[idx - offset]
        end
        
        def click()
          self.scroll_to_visible
          super
        end
        
        def selected?()
          return self['isSelected']
        end
  
        def select()
          self.click if (self['isSelected'] == false)
        end
  
        def select_add()
          if self['isSelected'] == false
            self.scroll_to_visible
            self.key_down :meta_key
            self.click
            self.key_up :meta_key
          end
        end
  
        def deselect()
          if self['isSelected'] == true
            self.scroll_to_visible
            self.key_down :meta_key
            self.click 
            self.key_up :meta_key
          end
        end
        
        def can_drag_before?()
          return false
        end
        
        def can_drag_after?()
          return false
        end
        
        def apply_drag_before(source)
          # no-op
        end
        
        def apply_drag_after(source)
          # no-op
        end
    
      end
  
    end
  end
end