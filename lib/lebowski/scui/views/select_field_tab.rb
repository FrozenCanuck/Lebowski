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
        
        def select_field
          @select_field = child_views.find_first(SelectFieldView) if @select_field.nil?
          return @select_field
        end
        
        def container
          @container = child_views.find_first(ContainerView) if @container.nil?
          return @container
        end
        
      end
      
    end
  end
end