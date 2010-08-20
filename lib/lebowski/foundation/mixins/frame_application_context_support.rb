# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    module Mixins
        
      #  
      # Mixin is used to provide support to an object that wants to provide a 
      # frame application that can be used to acquire application context
      #
      module FrameApplicationContextSupport
        include Lebowski::Foundation
        
        def frame()
          
          if @frame_app.nil?
            parent_app = Util.get_root_application_object(self)
            @frame_app = FrameApplication.new({
              :parent_app => parent_app,
              :locator => frame_app_context_locator
            })
          end
          return @frame_app
        end
        
        def frame_app_context_locator()
          return ''
        end
        
      end
      
    end
  end
end