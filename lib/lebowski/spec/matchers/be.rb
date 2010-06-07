# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Spec
    module Matchers
      
      #
      # Create owr own Be class that inherits from RSpec's Be class. This class
      # adds some logic to check for predicates that have a prefix is_. If
      # there is no such prefix then we hand back control to parent class to
      # apply the default pattern matching
      #
      # We are trying to accomplish the following:
      #
      #   myobject.should be_orange ==> myobject.is_orange? == true
      #
      # RSpec's default implementation of Be does not support checks for the is_
      # prefix.
      #
      # Ideally, it would've been better if the original class had hooks in it
      # to try custom patterns before ultimately applying the default pattern
      # checks
      #
      class Be < ::Spec::Matchers::BePredicate
        
        def matches?(actual)
          
          begin
            return @result = actual.__send__("is_#{@expected.to_s}?".to_sym, *@args)
          rescue NoMethodError => nme
          rescue ArgumentError => ae
          end
          
          begin
            return @result = actual.__send__("#{@expected.to_s}?".to_sym, *@args)
          rescue NoMethodError => nme
          rescue ArgumentError => ae
          end
          
          begin
            return @result = actual.__send__("is_#{@expected.to_s}".to_sym, *@args)
          rescue NoMethodError => nme
          rescue ArgumentError => ae
          end
          
          begin
            return @result = actual.__send__(@expected, *@args)
          rescue NoMethodError => nme
          rescue ArgumentError => ae
          end
          
          # None of the above options worked. Now we can default back to the
          # parent object's approach
          super
        end
      
      end
    end
  end
end