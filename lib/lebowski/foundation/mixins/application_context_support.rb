module Lebowski
  module Foundation
    
    module Mixins
  
      module ApplicationContextSupport
        include Lebowski::Foundation::Util
        
        def exec_in_context(app_name=nil, &block)
          app = get_root_application_object
          context = app.current_application_context
          acquire_application_context app_name
          yield app
          context.acquire_application_context
        end
        
        def exec_driver_in_context(&block)
          app = get_root_application_object
          context = app.current_application_context
          driver = app.driver
          
          case application_context_type
          when :frame
            driver.select_frame application_context_locator
          when :window
            driver.select_window application_context_locator
          else
            raise StandardError.new "context type is invalid: #{application_context_type}"
          end
          
          yield app.driver
          
          context.acquire_application_context
        end
        
        def acquire_application_context(app_name=nil)
          app = get_root_application_object
          app.reset_application_context
          app.switch_application_context_to self, app_name
        end
        
        def application_context_type()
          return nil
        end
        
        def application_context_locator()
          return nil
        end
        
      end
      
      module FrameApplicationContextSupport
        include ApplicationContextSupport
        
        def application_context_type()
          return :frame
        end
        
      end
      
      module WindowApplicationContextSupport
        include ApplicationContextSupport
        
        def application_context_type()
          return :window
        end
        
      end
      
    end
  end
end