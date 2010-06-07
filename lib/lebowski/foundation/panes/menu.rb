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
        
      protected
      
        def create_menu_item_array()
          return Support::MenuItemArray.new(self)
        end
        
      end
      
      module Support
   
        class MenuItemArray < Lebowski::Foundation::ObjectArray
          include Lebowski
          
          def initialize(parent, *params)
            super(parent, 'menuItemViews', 'length', *params)
          end
          
          def click(title)
            menu_item = nil
            if title.kind_of? String
              menu_item = find_first({ :title => /^#{title}$/i })
            elsif title.kind_of? Regexp
              menu_item = find_first({ :title => title })
            else
              raise ArgumentInvalidTypeError.new "title", title, String, Regexp
            end
            menu_item.click if (not menu_item.nil?)
          end
          
        protected
        
          def find_indexes_process_filter(filter)
            processed_filter = {}

            @title_flag = :no_flag

            filter.each do |key, value|
              case key
              when :title
                @title_flag = value
              else
                processed_filter[key] = value
              end
            end

            return processed_filter
          end

          def find_indexes_process_indexes(indexes)
            processed_indexes = []

            indexes.each do |index|
              if @title_flag != :no_flag
                next if (not menu_item_has_title?(index, @title_flag))
              end

              processed_indexes << index
            end

            return processed_indexes
          end
          
        private
        
          def menu_item_has_title?(index, title)
            menu_item = self[index]
            @valueKey = @parent['itemTitleKey']  if @valueKey.nil?
            value = menu_item["content.#{@valueKey}"]
            return (value =~ title).kind_of?(Integer) if title.kind_of?(Regexp)
            return (value == title)
          end
          
        end
        
      end
      
    end
  end
end