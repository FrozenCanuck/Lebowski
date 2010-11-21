# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module RSpec
    module Matchers
      
      #
      # Create owr own Has class that inherits from RSpec's Has class. This class
      # adds some logic to check if the given "actual" object has a property with
      # the name extracted from @expected. If not, then pass control back to the
      # parent class.
      #
      # Ideally it would have been better if the original Has class provided hooks
      # to include custom pattern checks that are used before the default pattern
      # checks are performed.
      #
      class Has < ::RSpec::Matchers::Has
      
        def matches?(actual)
          support = HasPredicateWithPrefixHas.new(actual, @expected, *@args)
          return support.result if support.has_match? 

          support = HasPredicateWithNoPrefix.new(actual, @expected, *@args)
          return support.result if support.has_match?
          
          support = HasObjectFunction.new(actual, @expected, *@args)
          return support.result if support.has_match?
          
          # None of the above options worked. Now we can default back to the
          # parent object's approach
          super
        end
        
      end
    end
  end
end