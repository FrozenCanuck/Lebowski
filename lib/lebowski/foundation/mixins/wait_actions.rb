module Lebowski
  module Foundation
    
    module Mixins
  
      #
      # Mixin provides actions to wait on something. By waiting no further action
      # will be taken until a condition has been met or a timeout has been reached.
      #
      module WaitActions
        include Lebowski::Foundation
      
        DEFAULT_TIMEOUT = 10 # seconds
        
        def wait_until(timeout=nil, &block)
          timeout = timeout.nil? ? DEFAULT_TIMEOUT : timeout
          
          if not timeout.kind_of? Integer or timeout <= 0
            raise ArgumentError.new "Must supply a valid timeout that is greater than 0"
          end
          
          if not block_given?
            raise ArgumentError.new "Must supply a block"
          end
        
          start_time = Time.now
          current_time = Time.now
        
          while (current_time - start_time) < timeout
            result = yield self
            return if (result == true)
            sleep 0.5
            current_time = Time.now
          end
          
          raise TimeoutError.new "Timed out after #{timeout} seconds"
          
        end

      end
      
    end
  end
end