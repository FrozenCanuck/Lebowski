# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    
    #
    # Represents a proxy to a generic SproutCore view (SC.View). 
    #
    # All other views in this framework derive from this in order to acquire base 
    # functionality. If you intended to create your own view proxy object then you 
    # must inherit from this class as well.
    #
    module Views
      class View < Lebowski::Foundation::SCObject
        include Lebowski::Foundation
        include Lebowski::Foundation::Views
        include Lebowski::Foundation::Mixins::UserActions
        include Lebowski::Foundation::Mixins::DelegateSupport
        
        representing_sc_class 'SC.View'
        
        def assigned_layer_id?()
          return (not (rel_path =~ /^#/).nil?)
        end
        
        def abs_path()
          return rel_path if assigned_layer_id?
          return super
        end
        
        # @override Actions#action_locator_args
        def action_locator_args()
          return [abs_path]
        end
        
        # @override Actions#action_target
        def action_target()
          return :view
        end
        
        #
        # Gets the remote layer ID for this view
        #
        # @see SC.View.layerId
        #
        def layer_id()
          # We only need to fetch the layer ID once since it never changes for a given instance
          @layer_id = @driver.get_sc_property_string_value(abs_path, "layerId") if @layer_id.nil?
          return @layer_id
        end              

        #
        # Gets the frame for this view.
        #
        # @return {Lebowski::Rect}
        #
        def frame()
          return @driver.get_sc_view_frame(abs_path)
        end
        
        # @override Lebowski::Foundation::Mixins::PositionedElement#position
        def position()
          return @driver.get_sc_element_window_position(action_target, *action_locator_args)
        end
        
        # @override Lebowski::Foundation::Mixins::PositionedElement#scroll_to_visible
        def scroll_to_visible()
          @driver.sc_view_scroll_to_visible(abs_path)
        end
        
        #
        # Gets the string representing of the view's layer. The layer in SproutCore is 
        # the root DOM element of the view. This method will return an HTML string 
        # representation of the entire layer that is equivalent to the following:
        #
        #   view.get('layer').outerHTML
        #
        def layer() 
          value = @driver.get_sc_view_layer(abs_path)
          return value
        end
        
        #
        # Obtain a core query object from the view.
        #
        # @param selector {String} a CSS selector that the core query object will use
        # @return returns an instance of Lebowski::Foundation::CoreQuery
        #
        def core_query(selector=nil)
          cq = Lebowski::Foundation::CoreQuery.new abs_path, selector, @driver
          return cq
        end
        
        def child_views()
          if @child_views.nil?
            @child_views = ObjectArray.new self, 'childViews', 'length'
          end
          return @child_views
        end
    
      end
    end
  end
end
      