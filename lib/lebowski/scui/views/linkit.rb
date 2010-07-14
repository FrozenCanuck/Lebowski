# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module SCUI
    module Views

      #
      # Represents a proxy to a SCUI LinkIt canvas view (LinkIt.CanvasView)
      #
      class CanvasView < Lebowski::Foundation::Views::CollectionView        
        representing_sc_class 'LinkIt.CanvasView'
        
        def nodes
          return item_views
        end
        
        def empty?
          return self['isEmpty']
        end
        
        protected
          def create_item_views_object_array()
            return Support::NodeItemViewArray.new self
          end
      end

      module Support
        
        class NodeItemViewArray < Lebowski::Foundation::Views::Support::CollectionItemViewArray
          def mix_in_support_for_object(obj)
            if not obj.class.ancestors.member? Lebowski::SCUI::Mixins::NodeItemViewSupport            
              obj.extend Lebowski::SCUI::Mixins::NodeItemViewSupport
            end
          end
        end
        
      end

    end
  end
end