# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
   
    #
    # Represents a SproutCore Core Query object. This proxy provides a subset of the
    # functionality that the actual core query object has.
    #
    # The core query is obtained through a view object and requires a CSS selector.
    # Based on the associated view and given selector, the core query object will
    # then contain zero or more DOM elements that match the selector starting from
    # the view's layer (read: root DOM element).
    #
    # For feature and integration testing, the use of the core query object may be
    # too low-level. Rather, this object is handy for custom views that override
    # the render method. By creating a proxy to the custom view you can then use
    # this object to do some fine grained checks that you don't want to expose
    # to the casual tester, for instance.
    #
    class CoreQuery
     
      INVALID_HANDLE = -1
     
      attr_reader :selector, # The CSS selector
                  :handle,   # The handle to the remote core query object
                  :abs_path  # The absolute path to the view this object comes from
     
      #
      # Creates an instance. Once created, it will have a handle to the remote
      # core query object in order to perform subsequent calls. Call the done()
      # method when this object is no longer used
      #
      # @param abs_path {String} a property path to the view the core query object will come from
      # @param selector {String} a CSS selector. See SproutCore's CoreQuery object for more details
      # @param driver {Object} driver to communicate with the selenium server
      #
      def initialize(abs_path, selector, driver)
        @abs_path = abs_path
        @selector = selector.nil? ? "" : selector
        @driver = driver
        @handle = INVALID_HANDLE
        @size = 0
        
        @handle = @driver.get_sc_core_query(abs_path, selector)
        @size = @driver.get_sc_core_query_size(@handle) if has_handle?
      end
     
      #
      # Returns the number of elements found by this core query object
      #
      def size()
        return @size if has_handle?
        return -1
      end
      
      #
      # Checks if this object has a handle to the remote core query object
      #
      def has_handle?()
        return (not @handle == INVALID_HANDLE) 
      end
      
      #
      # Will clean up this object when no longer used 
      #
      def done()
        @driver.sc_core_query_done(@handle)
        @handle = INVALID_HANDLE
      end
      
      #
      # Get an element at a given index. Returns an instance of DOMElement
      #
      # @param index {Number} returns element if this object has a handle and
      #        the index is within range
      #
      def [](index)
        if has_handle? and (index > -1) and (index <= (@size - 1))
          return Lebowski::Foundation::DOMElement.new @handle, index, @driver
        end
        return nil
      end
      
      #
      # Used to iterate through each element in this object. The block provided
      # will be provided to argments: the element and its index. You can use this
      # method as follows:
      #
      #   core_query.each do |element, index |
      #     ...
      #   end
      #
      def each(&block)
        return if (not has_handle? or not block_given? or size <= 0) 
        
        for i in 0..size - 1 do
          elem = Lebowski::Foundation::DOMElement.new @handle, i, @driver
          yield elem, i
        end
      end
      
      #
      # Used to fetch elements from this object. The block provided
      # is used to return an element that will be added to the array
      # of elements to be returned. If the block does not return an
      # element then the element will not be added to the resulting 
      # array. As an example:
      #
      #   elements = core_query.fetch { |element, index| element if element.text == 'foo' }
      #
      # The result array will then contain all elements in the core query
      # object that have text equal to 'foo'. if no elements match then
      # an empty array is returned.
      #
      # The block provided is to have the following setup:
      #
      #   do |element, index|    OR   { |element, index| ... }
      #     ...
      #   end
      #
      def fetch(&block)
        return [] if not block_given? 
        elems = []
        each do |elem, index|
          result = yield elem, index
          elems << result if not result.nil?
        end
        return elems
      end
      
      #
      # Used to perform a check on the elements from this core query. The
      # block provided is used to return true or false based of if the
      # given element passed some condition. In addition to the block
      # supplied to this method, you also pass in a condition about the
      # check being perform, which can be one of the following:
      #
      #   :all - Check that all elements meet the block's checks
      #   :any - Check that one or more elements meet the block's checks
      #   :none - Check that no elements meet the block's checks
      #   :one - Check that there is only one element that meets the block's checks
      #
      # If no condition argument is gien this :all is the default. 
      #
      # Here is an example of how to use this method:
      #
      #   meets_condition = core_query.check :all, do |elem, index|
      #                       if elem.text == 'foo'
      #                         true # element passes check
      #                       else
      #                         false # element does not pass check
      #                       end
      #                     end
      #
      # @see #all?
      # @see #any?
      # @see #none?
      # @see #one?
      #
      def check(condition=nil, &block)
        return false if not block_given?
        counter = 0
        each do |elem, index|
          result = yield elem, index
          counter = counter + 1 if result == true
        end
        
        case condition
        when :all
          return counter == size
        when :any
          return counter > 0
        when :none
          return counter == 0
        when :one
          return counter == 1
        else
          return counter == size
        end
      end
      
      #
      # Used to check if all of the element for this core query meet
      # the conditions for the given block
      #
      # @see #check
      #
      def all?(&block)
        check :all &block
      end
      
      #
      # Used to check if any of the element for this core query meet
      # the conditions for the given block
      #
      # @see #check
      #
      def any?(&block)
        check :any &block
      end
      
      #
      # Used to check if none of the element for this core query meet
      # the conditions for the given block
      #
      # @see #check
      #
      def none?(&block)
        check :none &block
      end
      
      #
      # Used to check if there is only one element for this core query that
      # meets the conditions for the given block
      #
      # @see #check
      #
      def one?(&block)
        check :one &block
      end
      
      alias_method :element, :[]
     
    end
    
  end
end