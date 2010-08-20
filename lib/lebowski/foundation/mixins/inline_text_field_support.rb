# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    
    module Mixins
      
      class InlineTextFieldError < Exception

      end
      
      #
      # Mixin adds support for any view that makes use of the inline text field view
      # (SC.InlineTextFieldView)
      #
      module InlineTextFieldSupport
      
        def edit_inline_text_field(value)
          pane = self['pane', 'SC.Pane']
          inline_text_field = pane.child_views.find_first('SC.InlineTextFieldView')
          if inline_text_field.nil?
            raise InlineTextFieldError.new "Was unable to locate the inline text field view to edit"
          end
          inline_text_field.type value
        end

      end
      
    end
  end
end