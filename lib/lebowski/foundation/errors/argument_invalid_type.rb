# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
   
    class ArgumentInvalidTypeError < Exception
   
      def initialize(arg_name, value, *expected_types)
        
        raise ArgumentError.new "invalid argument name supplied: #{arg_name}" if arg_name.nil? 
        
        message = "argument '#{arg_name}' is an invalid type: #{value} (#{value.class})."
        
        if not expected_types.nil?
          message << " Accepted types: "
          expected_types.each do |type|
            message << type.to_s << ", "
          end
        end
        
        super(message)
        
      end
      
    end
  
  end
end