# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    module Views
            
      #
      # Represents a proxy to a SproutCore button view (SC.ListItemView)
      #
      class ListItemView < Lebowski::Foundation::Views::View
        include Lebowski::Foundation
        include Lebowski::Foundation::Mixins::InlineTextFieldSupport 
        include Lebowski::Foundation::Mixins::ListItemViewSupport 
        
        representing_sc_class 'SC.ListItemView'
        
        def content_checkbox_key()
          return get_delegate_property('contentCheckboxKey', 'displayDelegate')
        end
        
        def content_value_key()
          return get_delegate_property('contentValueKey', 'displayDelegate')
        end
        
        def content_icon_key()
         return get_delegate_property('contentIconKey', 'displayDelegate')
        end
        
        def content_right_icon_key()
          return get_delegate_property('contentRightIconKey', 'displayDelegate')
        end
        
        def has_icon?()
          return (self['hasContentIcon'] == true)
        end
        
        def icon()
          @icon = create_icon(icon_selector) if @icon.nil?
          return has_icon? ? @icon : nil
        end
        
        def has_right_icon?()
          return (self['hasContentRightIcon'] == true)
        end
        
        def right_icon()
          @right_icon = create_right_icon(right_icon_selector) if @right_icon.nil?
          return has_right_icon? ? @right_icon : nil
        end
        
        def has_checkbox?()
          return (not content_checkbox_key.nil?)
        end
        
        def checkbox()
          @checkbox = create_checkbox(checkbox_selector) if @checkbox.nil?
          return has_checkbox? ? @checkbox : nil
        end
        
        def has_disclosure?()
          return (self['disclosureState'] != SC_LEAF_NODE)
        end
        
        def disclosure()
          @disclosure = create_disclosure(disclosure_selector) if @disclosure.nil?
          return has_disclosure? ? @disclosure : nil
        end
        
        def expand()
          dis = disclosure
          dis.toggle_on if (not dis.nil?)
        end
        
        def collapse()
          dis = disclosure
          dis.toggle_off if (not dis.nil?)
        end
      
        def edit_label(text)
          return if (not self['contentIsEditable'] or content_value_key.nil?)
          scroll_to_visible
          click
          select
          cq = core_query(label_selector)
          if cq.size > 0
            cq[0].click
            edit_inline_text_field text
            click
          end
          cq.done
        end
        
      protected
      
        def create_icon(selector)
          return Support::ListItemViewMainIcon.new self, selector
        end
        
        def create_right_icon(selector)
          return Support::ListItemViewRightIcon.new self, selector
        end
      
        def create_checkbox(selector)
          return Support::ListItemViewCheckbox.new self, selector 
        end
        
        def create_disclosure(selector)
          return Support::ListItemViewDisclosure.new self, selector
        end
        
        def checkbox_selector()
          return '.sc-outline .sc-checkbox-view'
        end
        
        def disclosure_selector()
          return '.sc-outline img.disclosure'
        end
        
        def label_selector()
          return '.sc-outline label'
        end
        
        def icon_selector()
          return '.sc-outline img.icon'
        end
        
        def right_icon_selector()
          return '.sc-outline img.right-icon'
        end
        
      end
      
      module Support
      
        class ListItemViewIcon
        
          def initialize(parent, selector)
            @parent = parent
            @selector = selector
          end
        
          def click()
            @parent.scroll_to_visible
            cq = @parent.core_query(@selector)
            cq[0].click
            cq.done
          end
        
          def value()
            return nil
          end
        
        end
      
        class ListItemViewMainIcon < ListItemViewIcon
        
          def value()
            key = @parent.content_icon_key
            return @parent[key]
          end
        
        end
      
        class ListItemViewRightIcon < ListItemViewIcon
        
          def value()
            key = @parent.content_right_icon_key
            return @parent[key]
          end
        
        end
      
        class ListItemViewCheckbox
          include Lebowski::Foundation
        
          def initialize(parent, selector)
            @parent = parent
            @selector = selector
          end
        
          def value()
            key = @parent.content_checkbox_key
            return nil if key.nil?
            val = @parent["content.#{key}"]
            return val
          end
        
          def selected?()
            val = value
            return (val == true or val == SC_MIXED_STATE)
          end
        
          def in_mixed_state?()
            return (value == SC_MIXED_STATE)
          end
        
          def select()
            val = value
            return if val.nil?
            if val != true
              @parent.scroll_to_visible
              cq = @parent.core_query(@selector)
              cq[0].click
              cq.done
            end
          end
        
          def deselect()
            val = value
            return if val.nil?
            cq = @parent.core_query(@selector)
            if val == true
              @parent.scroll_to_visible
              cq[0].click
            elsif value == SC_MIXED_STATE
              @parent.scroll_to_visible
              cq[0].click
              cq[0].click
            end
            cq.done
          end
        
        end
      
        class ListItemViewDisclosure
          include Lebowski::Foundation
        
          def initialize(parent, selector)
            @parent = parent
            @selector = selector
          end
        
          def value()
            return @parent['disclosureState']
          end
        
          def is_toggled_on?()
            return (@parent['disclosureState'] == SC_BRANCH_OPEN)
          end
        
          def is_toggled_off?()
            return (@parent['disclosureState'] == SC_BRANCH_CLOSED)
          end
        
          def toggle_on()
            if is_toggled_off?
              @parent.scroll_to_visible
              cq = @parent.core_query(@selector)
              cq[0].click
              cq.done
            end
          end
        
          def toggle_off()
            if is_toggled_on?
              @parent.scroll_to_visible
              cq = @parent.core_query(@selector)
              cq[0].click
              cq.done
            end
          end
        
          alias_method :is_expanded?, :is_toggled_on?
        
          alias_method :is_collapsed?, :is_toggled_off?
        
          alias_method :expand, :toggle_on
        
          alias_method :collapse, :toggle_off
        
        end
        
      end
      
    end
  end
end