# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Spec
    module Util
      
      #
      # Will determine if the given two values match each other. If neither val1 or val2
      # are regular expression then then will be compared using the standard == operator.
      # Otherwise, if val1 or val2 is a regular expression, then it will be compared
      # against the other value that must be a string
      #
      def self.match?(val1, val2)
        if val1.kind_of? Regexp or val2.kind_of? Regexp
          return (val1 =~ val2).nil? ? false : true
        else
          return val1 == val2
        end
      end
      
    end
  end
end