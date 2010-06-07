module Lebowski
  module Foundation
    module Mixins
      
      #
      # Mixin provides support to objects that need to stall an
      # action. This is needed in many cases where a user action is
      # being performed. If an action is performed to quickly then
      # SproutCore may not respond correctly and therefore cause
      # unexpected behavior in the application
      #
      module StallSupport
    
        DEFAULT_STALL = 0.2
    
        DEFAULT_KEY_STALLS = {
          :click => 0.2,
          :double_click => 0.5,
          :select => 0.5
        }
      
        @@adjusted_default_stall = DEFAULT_STALL
      
        @@adjusted_default_key_stalls = {}
      
        def self.adjust_all_stalls(stall)
          return if stall.nil? or stall <= 0
          @@adjusted_default_stall = stall
          DEFAULT_KEY_STALLS.each_key do |key|
            @@adjusted_default_key_stalls[key] = stall
          end
        end
      
        def self.adjust_default_stall(stall)
          return if stall.nil? or stall <= 0
          @@adjusted_default_stall = stall
        end
      
        def self.adjust_default_key_stall(key, stall)
          return if stall.nil? or stall <= 0
          @@adjusted_default_key_stalls[key] = stall
        end
      
        def self.reset()
          @@adjusted_default_stall = DEFAULT_STALL
          @@adjusted_default_key_stalls.clear
        end
    
        def stall(key, stall=nil)
          if stall.nil?
            sleep StallSupport.default_key_stall(key)
          elsif stall <= 0
            sleep StallSupport.default_stall
          else
            sleep stall
          end
        end
    
      private
      
        def self.default_stall()
          return @@adjusted_default_stall
        end
      
        def self.default_key_stall(key)
          value = @@adjusted_default_key_stalls[key]
          if value.nil?
            value = DEFAULT_KEY_STALLS[key]
            return default_stall if value.nil?
            return value
          end
          return value
        end
    
      end
      
    end
  end
end