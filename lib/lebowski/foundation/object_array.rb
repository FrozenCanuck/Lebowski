# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
   
    #
    # Represents an array of proxied objects. Use this for any proxy object that has a property
    # that is an array of objects within the browser. Provides a set of common functionality to 
    # check and access proxied objects within the array.
    #
    # Many of the methods for the class accept a filter as input. The filter can either be a 
    # type of SproutCore object or a hash made of properties with values that must be matched.
    # For instance, let's say that you want to find all the objects that are of the type
    # 'SC.Foo'. You would do the following:
    #
    #   found = obj.object_array.find_all('SC.Foo')
    #
    # Only those objects in the array that are of type SC.Foo will be returned. As another
    # example, we want to find all the objects in the array that have a property called 
    # "foo" have a matching value of "bar". You would do the following:
    #
    #   found = obj.object_array.find_all({ :foo => 'bar' })
    #
    # Only those objects that have the property foo with value 'bar' will be returned. Instead
    # of just a string value, you can also provided a regular expression, like so:
    #
    #   found = obj.object_array.find_all({ :foo => /bar/i })
    #
    # You are not limited to just one key-value pair; you can have as many as you like:
    #
    #   found = object.object_array.find_all({ :foo => /bar/i, :title => 'hello' })
    #
    # Only objects that satisfy all of the filter's conditions will be returned.
    #
    class ObjectArray
      include Lebowski::Foundation
      
      def initialize(parent, array_rel_path, array_length_property_name=nil, *params)
        init_validate_parent parent
        
        @parent = parent
        @array_rel_path = array_rel_path
        @array_length_property_name = array_length_property_name.nil? ? 'length' : array_length_property_name
        @driver = parent.driver
        @prefilter = {}
        
        if not params.empty?
          if params[0].kind_of?(Hash) and params[0].has_key?(:prefilter) 
            @prefilter = params[0][:prefilter] 
          else
            @prefilter = params[0]
          end
        end
        
      end
      
      def prefilter()
        return @prefilter.clone
      end
      
      #
      # Used to create a new filtered object array from this array based on this given filter. The new object
      # array will only reference those items that match the given filter
      #
      def filter(filter)
        merged_filter = merge_filter_with_prefilter(filter)
        return create_filtered_object_array(@parent, @array_rel_path, @array_length_property_name, merged_filter)
      end
      
      #
      # Returns an enumerable object of indexes for those items in the array that match the given filter
      #
      # This method gives you a chance to perform any processing on the given filter by overriding the
      # find_indexes_process_filter method. Once indexes are found you can also process the index before
      # a final result is returned by overriding the find_indexes_process_indexes method.
      #
      # @see #find_indexes_process_filter
      # @see #find_indexes_process_indexes
      #
      def find_indexes(filter=nil)
        raise ArgumentError.new "No filter was supplied" if (filter.nil? and @prefilter.empty?)
        
        # Do some initial processing of the given filter
        if filter.nil?
          # Filter is nil, so make it an empty hash object
          filter = {}
        elsif filter.kind_of? String
          # Filter is just a string, therefore assume the string is an SproutCore type
          filter = { :sc_type => filter }
        elsif filter.kind_of?(Class) and filter.ancestors.member?(SCObject)
          # Filter is an SCObject, therefore get the SC type as a string
          filter = { :sc_type => filter.represented_sc_class }
        elsif filter.kind_of?(Hash)
          # Filter is a hash object. Just need to check if the hash contains the special
          # key :sc_type. If so then do necessary conversions. 
          if filter.has_key? :sc_type
            type = filter[:sc_type]
            if type.kind_of?(Class) and type.ancestors.member?(SCObject)
              filter[:sc_type] = type.represented_sc_class
            end
          end
        else
          raise ArgumentInvalidTypeError.new "filter", filter, 'class < SCObject', String, Hash
        end
        
        # Merge the given filter with this object's prefilter
        filter = merge_filter_with_prefilter(filter)
        
        # Give a chance for the filter to be processed before finding matching indexes
        processed_filter = find_indexes_process_filter(filter)
        raise StandardError.new "process filter can not be nil" if processed_filter.nil?
        
        if not processed_filter.empty?
          # Filter is not empty therefore actually determine what indexes matches the filter
          sc_path = @parent.abs_path_with(@array_rel_path)
          indexes = @driver.get_sc_object_array_index_lookup(sc_path, processed_filter)
          return indexes if indexes.empty?
        else
          # Filter is empty, so just return a range of indexes for this array
          val = unfiltered_count
          return [] if val <= 0 
          indexes = (0..(val - 1))
        end
        
        # Now give a chance for the matching indexes to be processed before returning the
        # final result
        processed_indexes = find_indexes_process_indexes(indexes)
        raise StandardError.new "process indexes can not be nil" if processed_indexes.nil?
        
        # We're done. Return the final result
        return processed_indexes  
        
      end
      
      #
      # Returns the number of items in the array. If a filter is provided then the count
      # will be for those items in the array that match the filter
      #
      def count(filter=nil, &block)
        if @prefilter.empty? and filter.nil? and (not block_given?)
          return unfiltered_count
        elsif not block_given?
          return find_indexes(filter).length
        end
        
        counter = 0
        each filter do |view, index|
          result = yield view, index
          counter = counter.next if (result == true)
        end
        return counter
      end

      #
      # Returns an item at the given index of the array
      #
      def [](index, expected_type=nil)
        error = ArgumentError.new "index is out of bounds: #{index}" 
        
        if (not index.kind_of? Integer) or index < 0
          raise error
        end
        
        if @prefilter.empty?
          raise error if (index >= count)
          return create_object(index, expected_type)
        else
          indexes = find_indexes
          raise error if (index >= indexes.length)
          return create_object(indexes[index], expected_type)
        end
      end
      
      #
      # Returns the first item in the array
      #
      def first(expected_type=nil)
        return self[0, expected_type]
      end
      
      #
      # Returns the last item in the array
      #
      def last(expected_type=nil)
        return self[count - 1, expected_type]
      end

      #
      # Used to iterative through each item in the array. Can filter what items
      # are iterated over by supply a filter object
      #
      def each(filter=nil, &block)
        raise ArgumentError.new "block is required" if (not block_given?)

        indexes = []
        if @prefilter.empty? and filter.nil?
          value = count
          return if (value == 0)
          indexes = (0..(value - 1))        
          
          indexes.each do |index| 
            yield create_object(index), index  
          end
        else
          indexes = find_indexes(filter)
          return if indexes.empty?
          
          (0..(indexes.length - 1)).each do |i|
            yield create_object(indexes[i]), i  
          end
        end
      end
      
      alias_method :each_with_index, :each

      #
      # Returns all the items matching a given filter. If the filter is nil
      # then all the items are returns. If no mathing items are found then
      # an empty array is returned.
      #
      # @return {Array} basic array containing the matching found items
      #
      def find_all(filter=nil, &block)
        if filter.nil? and (not block_given?)
          raise ArugmentError.new "Must provide at least a filter or a block"
        end
        
        collected = []
        each filter do |view, index|
          if block_given?
            result = yield view, index
            collected << result if not result.nil?
          else
            collected << view
          end
        end
        return collected
      end
      
      #
      # Returns the first item matching the given filter. If no items match 
      # then nil is returned
      #
      def find_first(filter, expected_type=nil)
        if filter.nil?
          raise ArgumentError.new "filter can not be nil"
        end
        
        indexes = find_indexes(filter)
        return nil if indexes.empty?
        return create_object(indexes[0], expected_type)
      end
      
      #
      # Returns the last item matching a given filter. If no items match then
      # nil is returned.
      #
      def find_last(filter, expected_type=nil)
        if filter.nil?
          raise ArgumentError.new "filter can not be nil"
        end
        
        indexes = find_indexes(filter)
        return nil if indexes.empty?
        return create_object(indexes[indexes.length - 1], expected_type)
      end
      
      #
      # Returns the index of the given object
      #
      def index_of(obj)
        return -1 if (not obj.kind_of? ProxyObject)
        indexes = find_indexes({ :sc_guid => obj.sc_guid })
        return indexes.empty? ? -1 : indexes[0]
      end
      
      #
      # Used to determine if an object is part of this array
      #
      def member?(obj)
        return (index_of(obj) >= 0)
      end

      #
      # Used to check if all items in the array match the given filter
      #
      def all?(filter=nil, &block)
        return (count(filter, &block) == count)
      end

      #
      # Used to check if any items in the array match the given filter
      #
      def any?(filter=nil, &block)
        return (count(filter, &block) > 0)
      end
      
      alias_method :some?, :any?

      #
      # Used to check if no items in the array match the given filter
      #
      def none?(filter=nil, &block)
        return (count(filter, &block) == 0)
      end

      #
      # Used to check if only one item in the array matches the given filter
      #
      def one?(filter=nil, &block)
        return (count(filter, &block) == 1)
      end
      
      #
      # Used to check if the array is empty
      #
      def empty?()
        return (count == 0)
      end
      
    protected
    
      def create_object(index, expected_type=nil)
        rel_path = "#{@array_rel_path}.#{index}"
        return @parent[rel_path, expected_type]
      end
      
      def create_filtered_object_array(parent, array_rel_path, array_length_property_name, prefilter)
        klass = self.class
        return klass.new parent, array_rel_path, array_length_property_name, prefilter
      end
      
      def init_validate_parent(parent)
        if not parent.kind_of? ProxyObject
          raise ArgumentInvalidTypeError.new "parent", parent, ProxyObject
        end
      end
      
      #
      # Called by the find_indexes method. Used to do any processing of a given filter before
      # it is used to find matching indexes. By default, the method just returns the given array
      # without any processing done.
      #
      # @return {Hash} a filter object that has been processed.
      #
      # @see #find_indexes
      #
      def find_indexes_process_filter(filter)
        return filter
      end
      
      #
      # Called by the find_indexes method. Used to do any processing of a given enumerable object of
      # indexes before the final result is returned. By default, the method just returns the given
      # indexes without any processing done.
      #
      # @return {Enumerable} an enumerable object of indexes 
      #
      # @see #find_indexes
      #
      def find_indexes_process_indexes(indexes)
        return indexes
      end
      
    private
    
      def unfiltered_count()
        return @parent["#{@array_rel_path}.#{@array_length_property_name}"]
      end
      
      def merge_filter_with_prefilter(filter)
        
        if filter.kind_of? String
          filter = { :sc_type => filter }
        elsif filter.kind_of?(Class) and filter.ancestors.member?(SCObject)
          filter = { :sc_type => filter.represented_sc_class }
        elsif not filter.kind_of?(Hash)
          raise ArgumentInvalidTypeError.new "filter", filter, Hash
        end
        
        merged_filter = {}
        
        @prefilter.each do |key, value|
          merged_filter[key] = value
        end
        
        filter.each do |key, value|
          merged_filter[key] = value if (not merged_filter.has_key? key)
        end
        
        return merged_filter
      end
      
    end
       
  end
end