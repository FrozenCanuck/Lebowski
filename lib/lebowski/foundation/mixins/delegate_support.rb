module Lebowski
  module Foundation
    module Mixins
      
      module DelegateSupport
        
        def get_delegate_property(key, *delegates)
          val = self[key]
          return val if (not val.nil?)
          return nil if (delegates.length == 0)
          delegates.each do |del|
            val = self["#{del}.#{key}"]
            return val if (val != :undefined and not val.nil?)
          end
          return nil
        end
        
      end
      
    end
  end
end