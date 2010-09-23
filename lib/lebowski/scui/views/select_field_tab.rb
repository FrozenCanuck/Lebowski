# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module SCUI
    module Views
      
      #
      # Represents a proxy to a SCUI select field tab view (SCUI.SelectFieldTab)
      #
      class SelectFieldTabView < Lebowski::Foundation::Views::View
        representing_sc_class 'SCUI.SelectFieldTab'
        
        def select_button
          @select_button = child_views.find_first(SelectButtonView) if @select_button.nil?
          return @select_button
        end
        
        def container
          @container = child_views.find_first(ContainerView) if @container.nil?
          return @container
        end
        
      end
      
    end
  end
end