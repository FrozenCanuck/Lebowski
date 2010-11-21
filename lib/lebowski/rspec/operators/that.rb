# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module RSpec
    module Operators

      class That < Operator
        
        def initialize(sym, *args)
          @sym = sym
          @args = args
        end
        
        def evaluate(value)
          case operator
          when :not_empty
            return not_empty? value
          when :empty
            return empty? value
          when :between
            return between? value
          when :at_most
            return at_most? value
          when :at_least
            return at_least? value
          when :greater_than
            return greater_than? value
          when :less_than
            return less_than? value
          when :contains
            return contains? value
          when :matches
            return matches? value
          when :equals
            return equals? value
          when :equal_to
            return equals? value
          else
            raise ArgumentError "Invalid that operator: #{operator}"
          end
        end
        
        def operator()
          ["that_is_", "that_"].each do |prefix|
            if @sym =~ /^#{prefix}/
              return @sym.to_s.sub(prefix, "").to_sym
            end
          end
        end
        
        def method_missing(sym, *args, &block)
          return self
        end
        
      private
        
        def not_empty?(value)
          return (not empty? value)
        end
        
        def empty?(value)
          return true if value.nil?
          return value.length == 0 if value.kind_of?(Array) or value.kind_of?(String)
          return false
        end
        
        def between?(value)
          return false if not value.kind_of? Numeric
          min = @args[0]
          max = @args[1]
          return ((value >= min) and (value <= max))
        end
        
        def at_least?(value)
          return false if not value.kind_of? Numeric
          return value >= @args[0]
        end
        
        def at_most?(value)
          return false if not value.kind_of? Numeric
          return value <= @args[0]
        end
        
        def greater_than?(value)
          return false if not value.kind_of? Numeric
          return value > @args[0]
        end
        
        def less_than?(value)
          return false if not value.kind_of? Numeric
          return value < @args[0]
        end
          
        def contains?(value)
          return false if value.nil?
          @args.all? do |x|
            value.member? x
          end
        end
        
        def matches?(value)
          return Lebowski::RSpec::Util.match?(@args[0], value)
        end
        
        def equals?(value)
          return @args[0] == value
        end
        
      end

    end
  end
end