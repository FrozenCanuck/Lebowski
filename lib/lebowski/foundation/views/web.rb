# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    module Views
      
      #
      # Represents a proxy to a SproutCore web view (SC.WebView)
      #
      class WebView < Lebowski::Foundation::Views::View
        include Lebowski::Foundation::Mixins::FrameApplicationContextSupport
        
        representing_sc_class 'SC.WebView'
        
        def frame_app_context_locator()
          return "css=##{layer_id} iframe"
        end
        
      end
      
    end
  end
end