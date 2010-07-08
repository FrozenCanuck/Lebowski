module Lebowski
  module SCUI
    module Views
      
      class ContentEditableView < Lebowski::Foundation::Views::View
        representing_sc_class 'SCUI.ContentEditableView'
      
        def empty_selection?()
          value = self['selection']
          return (value == '' or value.nil?)
        end
      
        def image_selected?()
          return (not self['selectedImage'].nil?)
        end
        
        def hyperlink_selected?()
          return (not self['selectedHyperlink'].nil?) 
        end
        
      end
      
    end
  end
end