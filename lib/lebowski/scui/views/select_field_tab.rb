module Lebowski
  module SCUI
    module Views
      
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