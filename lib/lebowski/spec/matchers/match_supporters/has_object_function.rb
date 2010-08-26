# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Spec
    module Matchers
      
      class HasObjectFunction < MatchSupporter
      
        def has_match?()
          
          return false if @args.length == 0 
          
          #
          # Note: If the method name is "test" then trying to invoke
          # a method with name "test" on the given object will always
          # fail whenever __send__ is used. There appears to be an
          # actual method called test that belongs to a Ruby object.
          #
          method_name = obj_property(@expected)
          
          ret_val = nil
          invoked_method = false
          
          # Try with arguments
          begin
            args = @args.clone; args.pop
            ret_val = @object.__send__(method_name, *args)
            invoked_method = true
          rescue NoMethodError => nme
          rescue ArgumentError => ae
          end
          
          # Try with no arguments
          begin
            if not invoked_method
              ret_val = @object.__send__(method_name)
              invoked_method = true
            end
          rescue NoMethodError => nme
          rescue ArgumentError => ae
          end
            
          return false if not invoked_method
          
          operator = @args[@args.length - 1]
          if operator.kind_of? Lebowski::Spec::Operators::Operator
            @result = operator.evaluate(ret_val) 
            return true
          end
          
          @result = Lebowski::Spec::Util.match?(@args[@args.length - 1], ret_val)
          
          return true
          
        end
        
      private
      
        def obj_property(sym)
          ["has_", "have_"].each do |prefix|
            if sym.to_s =~ /^#{prefix}/
              return sym.to_s.sub(prefix, "").to_sym
            end
          end
        end
        
      end
    end
  end
end