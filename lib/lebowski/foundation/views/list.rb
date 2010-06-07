# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    module Views
      
      #
      # Represents a proxy to a SproutCore list view (SC.ListView)
      #
      class ListView < Lebowski::Foundation::Views::CollectionView
        
        representing_sc_class 'SC.ListView'
        
        def can_drag_to_start_of?()
          return true
        end
        
        def can_drag_to_end_of?()
          return true
        end
        
        def apply_drag_to_start_of(source)
          if item_views.count == 0
            source.drag_to self
          else
            item = item_views[0]
            source.drag_before item
          end
        end
        
        def apply_drag_to_end_of(source)
          if item_views.count == 0
            source.drag_to self
          else
            item = item_views[item_views.count - 1]
            source.drag_after item
          end
        end
        
      protected
      
        def create_item_views_object_array()
          return Support::ListItemViewArray.new self
        end
    
      end
      
      module Support
        
        class ListItemViewArray < CollectionItemViewArray
          
          def mix_in_support_for_object(obj)
            if not obj.class.ancestors.member? Mixins::ListItemViewSupport            
              obj.extend Mixins::ListItemViewSupport
            end
          end
          
        end
        
      end
      
    end
  end
end