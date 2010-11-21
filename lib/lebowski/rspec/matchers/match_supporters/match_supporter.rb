# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module RSpec
    module Matchers
      
      class MatchSupporter
        
        attr_reader :result
        
        def initialize(object, expected, *args)
          @object = object
          @expected = expected
          @args = args
          @result = nil
        end
        
        def has_match?()
          return false
        end
        
      end
    
    end
  end
end