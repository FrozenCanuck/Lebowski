# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    module Panes
      
      #
      # Represents a proxy to a SproutCore menu pane (SC.MenuPane)
      #
      class MenuPane < Lebowski::Foundation::Panes::PickerPane
        
        representing_sc_class "SC.MenuPane"
        
        def menu_items()
          @menu_items = create_menu_item_array if @menu_items.nil?
          return @menu_items
        end
        
        def click_item(title)
          menu_items.click title
        end
        
      protected
      
        def create_menu_item_array()
          return Support::MenuItemArray.new(self)
        end
        
      end
      
      module Support
   
        class MenuItemArray < Lebowski::Foundation::ObjectArray
          include Lebowski
          
          def initialize(parent, *params)
            super(parent, 'items', 'length', *params)
            @itemTitleKey = @parent['itemTitleKey']
          end
          
          def click(title)
            menu_item = nil
            if title.kind_of? String
              menu_item = find_first({ @itemTitleKey => /^#{title}$/i })
            elsif title.kind_of? Regexp
              menu_item = find_first({ @itemTitleKey => title })
            else
              raise ArgumentInvalidTypeError.new "title", title, String, Regexp
            end
            menu_item.click if (not menu_item.nil?)
          end
          
        protected
        
          def create_object(index, expected_type=nil)
            rel_path = "_menuView.childViews.#{index}"
            return @parent[rel_path, expected_type]
          end
          
        end
        
      end
      
    end
  end
end