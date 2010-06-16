# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    
    #
    # Represents a DOM element. Primarily used by the CoreQuery object. Use this
    # object to acquire details about a given element.
    #
    class DOMElement
      include Lebowski::Foundation::Mixins::UserActions
      
      attr_reader :handle,
                  :index
      
      #
      # Create an instance. 
      #
      # @param handle {Number} the handle used by a core query object
      # @param index {Number} the index to the element in the core query object
      # @param driver {object} used to communicate with the selenium server
      #
      def initialize(handle, index, driver)
        @handle = handle
        @index = index
        @driver = driver
      end
      
      def action_locator_args()
        return [@handle, @index]
      end
      
      def action_target()
        return :core_query_element
      end
      
      #
      # Returns the classes of the element as a string
      #
      def classes()
        return @driver.get_sc_core_query_element_classes(@handle, @index)
      end
      
      #
      # Checks if this DOM element has a given CSS class
      #
      # @return true if the element has the class, otherwise false is returned
      #
      def has_class?(klass)
        return has_classes? [klass]
      end

      #
      # Checks if this DOM element has a set of given CSS classes
      #
      # @return true if the element has all teh given classes, otherwise false is returned
      #
      def has_classes?(klasses)
        klasses1 = klasses.kind_of?(Array) ? klasses : klasses.split
        klasses2 = classes.split
        for k in klasses1 do
          if not klasses2.find_index(k)
            return false
          end
        end
        return true
      end
   
      #
      # Returns the raw HTML of this element as a string
      #
      def html()
        return @driver.get_sc_core_query_element_html(@handle, @index)
      end
      
      #
      # Returns the text of this element
      #
      def text()
        return @driver.get_sc_core_query_element_text(@handle, @index)
      end
      
      #
      # Returns the HTML tag of this element (e.g. IMG, A, DIV)
      #
      def tag()
        return @driver.get_sc_core_query_element_tag(@handle, @index)
      end
      
      #
      # Used to get the value of specific attribute belonging to the element
      #
      # @param val {String} the name of the attribute on the element
      #
      def attribute(val)
        return @driver.get_sc_core_query_element_attribute(@handle, @index, val)
      end
      
      # @override Lebowski::Foundation::Mixins::PositionedElement#position
      def position()
        return @driver.get_sc_element_window_position(action_target, *action_locator_args)
      end
      
      # @override Lebowski::Foundation::Mixins::PositionedElement#width
      def width()
        return @driver.get_sc_element_width(action_target, *action_locator_args)
      end
      
      # @override Lebowski::Foundation::Mixins::PositionedElement#height
      def height()
        return @driver.get_sc_element_height(action_target, *action_locator_args)
      end
      
      #
      # If the method can not be found then assume we are trying to get the value
      # of an attribute on the element.
      #
      def method_missing(sym, *args, &block)
        return attribute(sym.to_s) if not sym.to_s =~ /\?$/
        super
      end
      
    end
    
  end
end