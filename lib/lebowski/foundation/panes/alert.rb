# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    
    module Panes
      
      #
      # Represents a proxy to a SproutCore alert pane (SC.AlertPane)
      #
      class AlertPane < Lebowski::Foundation::Panes::PanelPane
        include Lebowski::Foundation
        
        representing_sc_class 'SC.AlertPane'
        
        ALERT_TYPE_WARN = 'alert'
        ALERT_TYPE_ERROR = 'error'
        ALERT_TYPE_INFO = 'info'
        ALERT_TYPE_PLAIN = 'blank'
        
        ALERT_TYPES = {
          :alert => ALERT_TYPE_WARN,
          :warn => ALERT_TYPE_WARN,
          :error => ALERT_TYPE_ERROR,
          :info => ALERT_TYPE_INFO,
          :plain => ALERT_TYPE_PLAIN
        }
        
        ALERT_PROPERTY_TYPE = 'icon'
        
        BUTTON_ONE = 'button1'
        BUTTON_TWO = 'button2'
        BUTTON_THREE = 'button3'
        
        BUTTONS = [BUTTON_ONE, BUTTON_TWO, BUTTON_THREE]
        
        def type()
          return :alert if is_alert?
          return :error if is_error?
          return :info if is_info?
          return :plain if is_plain?
          return "" 
        end
        
        def is_type?(key)
          if (not ALERT_TYPES.has_key?(key))
            raise ArgumentError.new "require valid key: #{key}" 
          end
          
          return (not (self[ALERT_PROPERTY_TYPE] =~ /#{ALERT_TYPES[key]}/i).nil?)
        end
        
        def is_alert?()
          return is_type?(:alert)
        end
        
        alias_method :is_warn?, :is_alert?
        
        def is_error?()
          return is_type?(:error)
        end
        
        def is_info?()
          return is_type?(:info)
        end
        
        def is_plain?()
          return is_type?(:plain)
        end
        
        def button_count()
          counter = 0
          each_button do |button|
            counter = counter.next
          end
          return counter
        end
        
        def each_button(&block)
          raise ArgumentError.new "must provide a block" if (not block_given?)
          BUTTONS.each do |button|
            btn = self[button]
            next if (btn == :undefined)
            next if (not btn['isVisible'])
            yield btn
          end
        end
        
        def has_button?(title)
          raise ArgumentError.new "title can not be nil" if title.nil?
          each_button do |button|
            return true if (not (button['title'] =~ /^#{title}$/i).nil?)
          end
          return false
        end
        
        def click_button(title)
          raise ArgumentError.new "title can not be nil" if title.nil?
          each_button do |button|
            if not (button['title'] =~ /^#{title}$/i).nil?
              button.click
              return
            end
          end
        end
        
      end
    end
  end
end