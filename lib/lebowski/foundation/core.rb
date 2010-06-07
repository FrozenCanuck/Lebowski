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

    end
    
  end
end