# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module RSpec
    module Matchers
      
      class HasPredicateWithNoPrefix < MatchSupporter
        
        def has_match?()
          
          executed_method = false
          
          method_name = predicate_with_no_prefix(@expected)
          
          # Try with arguments
          begin
            @result = @object.__send__(method_name, *@args)
            executed_method = true
          rescue NoMethodError => nme
          rescue ArgumentError => ae
          end
          
          return true if executed_method
          
          # Try with no arguments
          begin
            @result = @object.__send__(method_name)
            executed_method = true
          rescue NoMethodError => nme
          rescue ArgumentError => ae
          end
          
          return executed_method
          
        end
    
      private
      
        def predicate_with_no_prefix(sym)
          return (sym.to_s.sub('have_', '') << '?').to_sym
        end
        
      end
      
    end
  end
end