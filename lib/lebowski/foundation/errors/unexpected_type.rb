# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
   
    class UnexpectedTypeError < Exception
      
      def initialize(path, expected_type, result_type, value)
        
        if value.kind_of?(Lebowski::Foundation::SCObject)
          value = value.sc_class
        end
        
        if expected_type.kind_of?(Class) and expected_type.ancestors.member?(Lebowski::Foundation::SCObject)
          expected_type = expected_type.represented_sc_class
        end
        
        message = "Did not get expected type '#{expected_type}' for path '#{path}'. Instead got #{result_type}: #{value}"
        
        super(message)
        
      end
      
    end
    
  end
end