# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    module Views
      
      #
      # Represents a proxy to a SproutCore select button (SC.SelectButtonView)
      #
      class SelectButtonView < Lebowski::Foundation::Views::View
        include Lebowski::Foundation::Util
        
        representing_sc_class 'SC.SelectButtonView'
        
        def display_menu
          click if !has_menu_displayed?
        end
        
        def hide_menu
          menu.click_off if has_menu_displayed?
        end

        def has_menu_displayed?
          return (not menu.nil?)
        end

        def menu
          @menu = self['pane.rootResponder.menuPane']
          if not @menu.nil?
            @menu = @menu.represent_as(SelectButtonMenu) 
            @menu.select_button = self
          end
          return @menu
        end

        def select_item(title)
          display_menu
          menu.menu_items.click title
        end

        def checkbox_enabled?
          @checkbox_enabled = self['checkboxEnabled'] if @checkbox_enabled.nil?
          return @checkbox_enabled
        end
      end

      class SelectButtonMenu < Lebowski::Foundation::Panes::MenuPane
        attr_writer :select_button

        def item_checked?(title)
          raise "The checkbox option is not enabled for this select button." if not @select_button.checkbox_enabled?
          menu_item = nil
          if title.kind_of? String
            menu_item = menu_items.find_first({ :title => /^#{title}$/i })
          elsif title.kind_of? Regexp
            menu_item = menu_items.find_first({ :title => title })
          else
            raise ArgumentInvalidTypeError.new "title", title, String, Regexp
          end
          return menu_item['content.checkbox']
        end
      end

    end
  end
end