# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
   
    # A SproutCore error instance (SC.Error)
    SC_T_ERROR = 'error'

    # Null value
    SC_T_NULL = 'null' 

    # Undefined value
    SC_T_UNDEFINED = 'undefined'

    # A function
    SC_T_FUNCTION = 'function'

    # Number primitive
    SC_T_NUMBER = 'number'

    # Boolean primitive 
    SC_T_BOOL = 'boolean'

    # An instance of Array
    SC_T_ARRAY = 'array'

    # String primitive
    SC_T_STRING = 'string' 

    # A JavaScript object not inheriting from SC.Object 
    SC_T_HASH = 'hash' 

    # A SproutCore class (created using SC.Object.extend())
    SC_T_CLASS = 'class'

    # A SproutCore object instance
    SC_T_OBJECT = 'object'
    
    SC_MIXED_STATE = '__MIXED__'
    
    # Constants used by the collection view. see SproutCore file collection_content.js
    SC_LEAF_NODE = 0x0020
    SC_BRANCH_OPEN = 0x0011
    SC_BRANCH_CLOSED = 0x0012
    
    module Util

      def assert_is_object(value, name) 
        if not value.kind_of? Lebowski::Foundation::ProxyObject
          raise ArgumentInvalidTypeError.new name, value, Lebowski::Foundation::ProxyObject
        end
      end

      def assert_is_view(value, name)
        if not value.kind_of? Lebowski::Foundation::Views::View
          raise ArgumentInvalidTypeError.new name, value, Lebowski::Foundation::Views::View
        end
      end
      
      def self.get_root_application_object(proxy)
        if proxy.nil?
          raise ArgumentInvalidTypeError.new "proxy", proxy, Lebowski::Foundation::ProxyObject
        end
        
        current_proxy = proxy
        while not current_proxy.nil? do
          return current_proxy if current_proxy.kind_of?(Lebowski::Foundation::Application)
          current_proxy = current_proxy.parent
        end
        
        return nil
      end
      
      def get_root_application_object()
        return Util.get_root_application_object(self)
      end
      
      #
      # Will return a string in camel case format for any value that follows the Ruby
      # variable and method naming convention (e.g. my_variable_name). As an example:
      # 
      #   Util.to_camel_case(:some_long_name) # => "someLongName"
      #   Util.to_camel_case("function_foo_bar") # => "functionFooBar"
      #
      def self.to_camel_case(value)
        camel_case_str = ""
        word_counter = 1
        words = value.to_s.split('_')
        return words[0] if words.length == 1
        words.each do |word|
          camel_case_str << ((word_counter == 1) ? word : word.sub(/./) { |s| s.upcase })   
          word_counter = word_counter.next
        end
        return camel_case_str
      end

    end
    
  end
end