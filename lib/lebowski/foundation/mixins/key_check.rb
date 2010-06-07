module Lebowski
  module Foundation
    module Mixins
   
      module KeyCheck
        
        #
        # Check if a key is pressed down. Note that the key is not specific to any object. So the
        # following scenario is valid:
        #
        #   objA.key_down? 'a' # => false
        #   objB.key_down 'a'
        #   objA.key_down? 'a' # => true
        #
        def key_down?(key)
          return @driver.key_down? key
        end
        
        #
        # Check if a key is pressed down. Note that the key is not specific to any object. So the
        # following scenario is valid:
        #
        #   objA.key_up? 'a' # => true
        #   objB.key_down 'a'
        #   objA.key_up? 'a' # => false
        #
        def key_up?(key)
          return @driver.key_up? key
        end
        
      end
      
    end
  end
end