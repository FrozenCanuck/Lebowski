# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    module Views
      
      #
      # Represents a proxy to a SproutCore text field view (SC.TextFieldView)
      #
      class TextFieldView < Lebowski::Foundation::Views::View
        
        representing_sc_class 'SC.TextFieldView'
        
        SELECTOR_INPUT_FIELD = "input"
        SELECTOR_TEXT_AREA = "textarea"
        
        #
        # Used to check if this view is empty
        #
        def empty?()
          val = self['value']
          return (val.nil? or val.empty?)
        end
        
        def clear()
          type ""
        end
        
        def key_down(char)
          cq = core_query(text_field_selector)
          input = cq[0]
          input.key_down char
          cq.done
        end
        
        def key_up(char)
          cq = core_query(text_field_selector)
          input = cq[0]
          input.key_up char
          cq.done
        end
        
        #
        # Used to type text into this view. This will directly insert the text
        # into the input field. There will be no simulated key up and key down
        # events
        #
        def type(text)
          cq = core_query(text_field_selector)
          input = cq[0]
          input.type text
          cq.done
        end
        
        def type_append(text)
          val = self['value']
          type "#{val}#{text}"
        end
        
        #
        # Used to simulate the typing of a single key. This will cause a simulated
        # key up and key down event
        #
        def type_key(text)
          clear
          type_key_append text
        end
        
        def type_key_append(text)
          cq = core_query(text_field_selector)
          input = cq[0]
          input.type_key text
          cq.done
        end
        
        #
        # Used to simulate the typing of some given text. Each character from the
        # given text will "typed" meaning that a simulated key up and key down event
        # will occur for each character. This is useful when you have something
        # that reacts to each character being entered.
        #
        def type_keys(text)
          clear
          type_keys_append text
        end
        
        def type_keys_append(text)
          cq = core_query(text_field_selector)
          input = cq[0]
          text.chars.each do |x|
            input.type_key x
          end
          cq.done
        end
        
      private
      
        def text_field_selector()
          return (self['isTextArea'] == true) ? SELECTOR_TEXT_AREA : SELECTOR_INPUT_FIELD
        end
        
      end
    end
  end
end