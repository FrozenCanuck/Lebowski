# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    module Mixins

      #
      # Mixin containing a set of commonly performed user actions. Mix this into any
      # class that is able to perform these set of actions. 
      #
      module UserActions
        include PositionedElement
        include KeyCheck
        include StallSupport
        
        def mouse_move_at(x, y)
          @driver.sc_mouse_move_at action_target, x, y, *action_locator_args
          stall :mouse_move          
        end
        
        def mouse_up_at(x, y)
          @driver.sc_mouse_up_at action_target, x, y, *action_locator_args
          stall :mouse_up
        end
        
        def mouse_down_at(x, y)
          scroll_to_visible
          @driver.sc_mouse_down_at action_target, x, y, *action_locator_args
          stall :mouse_down
        end
        
        def right_mouse_down_at(x, y)
          scroll_to_visible
          @driver.sc_right_mouse_down_at action_target, x, y, *action_locator_args
          stall :right_mouse_down
        end
        
        def right_mouse_up_at(x, y)
          @driver.sc_right_mouse_up_at action_target, x, y, *action_locator_args
          stall :right_mouse_up
        end
        
        def click_at(x, y)
          mouse_down_at x, y
          mouse_up_at x, y
          stall :click
        end
        
        def double_click_at(x, y)
          scroll_to_visible
          @driver.sc_double_click_at action_target, x, y, *action_locator_args
          stall :double_click
        end
        
        def right_click_at(x, y)
          right_mouse_down_at x, y
          right_mouse_up_at x, y
          stall :right_click
        end
        
        def mouse_move()
          @driver.sc_mouse_move action_target, *action_locator_args
          stall :mouse_move
        end
        
        #
        # Used to perform a mouse down on this view in the remote application
        #
        def mouse_down()
          mouse_down_at :center, :center
        end
        
        #
        # Used to perform a mouse up on this view in the remote application
        #
        def mouse_up()
          mouse_up_at :center, :center
        end
        
        #
        # Used to perform a mouse down with right button on this view in the remote application
        #
        def right_mouse_down()
          right_mouse_down_at :center, :center
        end
        
        #
        # Used to perform a mouse up with right button on this view in the remote application
        #
        def right_mouse_up()
          right_mouse_up_at :center, :center
        end
        
        #
        # Used to perform a double click on this view in the remote application
        #
        def double_click()
          double_click_at :center, :center
        end
        
        #
        # Used to perform a single click on this view in the remote application
        #
        def click()
          mouse_down
          mouse_up
          stall :click
        end
        
        #
        # Used to perform a single right click on this view in the remote application
        #
        def right_click()
          right_mouse_down
          right_mouse_up
          stall :right_click
        end
        
        #
        # Used to perform a single basic click on this view in the remote application
        #
        def basic_click()
          scroll_to_visible
          @driver.sc_basic_click action_target, *action_locator_args
          stall :click
        end
        
        #
        # Used to perform a mouse wheel action on the x-axis
        #
        def mouse_wheel_delta_x(delta)
          @driver.sc_mouse_wheel_delta_x action_target, delta, *action_locator_args
          stall :mouse_wheel
        end
        
        #
        # Used to perform a mouse wheel action on the y-axis
        #
        def mouse_wheel_delta_y(delta)
          @driver.sc_mouse_wheel_delta_y action_target, delta, *action_locator_args
          stall :mouse_wheel
        end
        
        #
        # Used to perform a key down on this view in the remote application
        #
        # You can either type a printable character or a function key. If you want to type a printable
        # character then the 'key' parameter just has to be a string, such as 'a'. If you want to type
        # a function key such as F1, then the 'key' parameter must be the corresponding symbol. 
        #
        # Example:
        #
        #   view.key_down 'a'       # key down for printable character 'a'
        #   view.key_down :delete   # key down for function key delete
        #   view.key_down :meta_key # key down for the meta key
        #
        def key_down(key)
          focus
          @driver.sc_key_down action_target, key, *action_locator_args
          stall :key_down
        end

        #
        # Used to perform a key up on this view in the remote application
        #
        # You can either type a printable character or a function key. If you want to type a printable
        # character then the 'key' parameter just has to be a string, such as 'a'. If you want to type
        # a function key such as F1, then the 'key' parameter must be the corresponding symbol. 
        #
        # Example:
        #
        #   view.key_up 'a'       # key up for printable character 'a'
        #   view.key_up :delete   # key up for function key delete
        #   view.key_up :meta_key # key up for the meta key
        #
        def key_up(key)
          focus
          @driver.sc_key_up action_target, key, *action_locator_args
          stall :key_up
        end

        #
        # Used to type a key on this view in the remote application. This will cause a key down followed
        # by a key up
        #
        # You can either type a printable character or a function key. If you want to type a printable
        # character then the 'key' parameter just has to be a string, such as 'a'. If you want to type
        # a function key such as F1, then the 'key' parameter must be the corresponding symbol. 
        #
        # Example:
        #
        #   view.type_key 'a'      # type printable character 'a'
        #   view.type_key :delete  # type function key delete
        #
        def type_key(key)
          focus
          @driver.sc_type_key action_target, key, *action_locator_args
          stall :type_key
        end 
        
        def type(text)
          focus
          @driver.sc_type action_target, text, *action_locator_args
          stall :type_key
        end
        
        def focus()
          @driver.sc_focus action_target, *action_locator_args
        end
        
        def drag(x, y, *params)
          if (not x.kind_of? Integer) or (not y.kind_of? Integer)
            raise ArgumentError.new "Must supply valid x-y coordinates: x = #{x}, y = #{y}" 
          end
          
          relative_to = nil
          mouse_offset_x = 0
          mouse_offset_y = 0
          
          if params.length > 0 and params[0].kind_of?(Hash)
            relative_to = params[0][:relative_to]
            mouse_offset_x = get_mouse_offset(params[0][:mouse_offset_x], :x)
            mouse_offset_y = get_mouse_offset(params[0][:mouse_offset_y], :y)
          end
          
          # First be sure to disable autoscrolling in the application. This needs
          # to be done so that autoscrolling will not interfere with our drag
          # and drop user action
          @driver.sc_disable_all_autoscrolling
          
          mouse_down_at mouse_offset_x, mouse_offset_y
          
          # Need to incoporate an intentional sleep so sproutcore
          # has enough time to do its thing
          sleep 0.2
          
          mouse_move_at mouse_offset_x, mouse_offset_y
     
          # Make sure the element we are dragging relative to is visible
          relative_to.scroll_to_visible if relative_to.kind_of? PositionedElement
          
          rel_pos = relative_position(x, y, relative_to)
          mouse_move_at rel_pos.x, rel_pos.y

          rel_pos = relative_position(x, y, relative_to)
          mouse_up_at rel_pos.x, rel_pos.y

          # Enable autoscrolling and mouse move events since we have completed the 
          # drag and drop operation
          @driver.sc_enable_all_autoscrolling
          @driver.sc_enable_mouse_move_event
        end
        
        def drag_to(source, offset_x=nil, offset_y=nil, *params)
          if not (source.kind_of? PositionedElement or source == :window)
            raise ArgumentError.new "source must be an positioned element: #{source.class}"
          end
          
          offset_x = offset_x.nil? ? 0 : offset_x
          offset_y = offset_y.nil? ? 0 : offset_y
          
          params2 = { :relative_to => source }
          if params.length > 0 and params[0].kind_of? Hash
            params2[:mouse_offset_x] = params[0][:mouse_offset_x]
            params2[:mouse_offset_y] = params[0][:mouse_offset_y]
          end
          
          drag offset_x, offset_y, params2
        end
        
        def drag_on_to(source)
          drag_to source, 1, 1
        end
        
        def drag_before(item)
          assert_item_has_collection_item_view_support(item, 'item')
          return if not item.can_drag_before?
          item.apply_drag_before self
        end
        
        def drag_after(item)
          assert_item_has_collection_item_view_support(item, 'item')
          return if not item.can_drag_after?
          item.apply_drag_after self
        end
        
        def drag_to_start_of(view)
          assert_is_collection_view(view, 'view');
          return if not view.can_drag_to_start_of?
          view.apply_drag_to_start_of self
        end
        
        def drag_to_end_of(view)
          assert_is_collection_view(view, 'view');
          return if not view.can_drag_to_end_of?
          view.apply_drag_to_end_of self
        end    
      
      protected
        
        #
        # Override this to supply the target, which can either be one of the following:
        #
        #   :view
        #   :core_query_element
        #
        def action_target()
          
        end
        
        #
        # Override this to supply the arguments to generate the locator
        #
        def action_locator_args()
          
        end
        
      private
      
        def relative_position(x, y, relative_to)
          rel_x = 0
          rel_y = 0     
          
          if not relative_to.nil?
            position = self.position
            rel_x += position.x * -1
            rel_y += position.y * -1
            if relative_to.kind_of? PositionedElement
              position = relative_to.position
              rel_x += position.x
              rel_y += position.y
            elsif relative_to == :window
            else
              raise ArgumentError.new "relative to source must be a positioned element: #{relative_to.class}"
            end
          end
          
          rel_x += x
          rel_y += y
          
          return Lebowski::Coords.new rel_x, rel_y
        end
      
        def assert_is_collection_view(value, name)
          if not value.kind_of? Lebowski::Foundation::Views::CollectionView
            raise ArgumentInvalidTypeError.new name, value, Lebowski::Foundation::Views::CollectionView
          end
        end

        def assert_item_has_collection_item_view_support(value, name)
          if not value.respond_to? :has_collection_item_view_support
            raise ArgumentError.new "#{name} must have collection item view support (#{CollectionItemViewSupport})"
          end
        end
        
        def get_mouse_offset(offset, coord)
          return 0 if offset.nil?
          if offset == :center
            return (width / 2).floor if (coord == :x)
            return (height / 2).floor if (coord == :y)
          end
          return offset if (offset.kind_of? Integer and offset >= 0)
          raise ArgumentError.new "Invalid offset value: #{offset}"
        end
      
      end
    end
  end
end