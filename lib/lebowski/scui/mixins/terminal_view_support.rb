# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module SCUI
    module Mixins
      
      module TerminalViewSupport
        def has_terminal_view_support
          return true
        end
        
        def terminal_name
          @terminal_name = self['terminal'] if @terminal_name.nil?
          return @terminal_name
        end
        
        def link_to(end_term, x = 0, y = 0)
          assert_item_has_terminal_view_support(end_term)
          self.drag_to(end_term, x, y)
        end
        
        def linked_to?(terminal)
          assert_item_has_terminal_view_support(terminal)
          
          terminal_parent_node = terminal.parent['content']
          my_parent_node = self.parent['content']
          
          self.parent.links.each do |link|
            return true if (link.start_node == terminal_parent_node) && (link.start_terminal == terminal.terminal_name) && (link.end_terminal == self.terminal_name)
            return true if (link.end_node == terminal_parent_node) && (link.end_terminal == terminal.terminal_name) && (link.start_terminal == self.terminal_name)
          end
          
          terminal.parent.links.each do |link|
            return true if (link.start_node == my_parent_node) && (link.start_terminal == self.terminal_name) && (link.end_terminal == terminal.terminal_name)
            return true if (link.end_node == my_parent_node) && (link.end_terminal == self.terminal_name) && (link.start_terminal == terminal.terminal_name)
          end
          
          return false
        end

        
        private
          def assert_item_has_terminal_view_support(item)
            if not item.respond_to? :has_terminal_view_support
              raise ArgumentError.new "Cannot link to an item without terminal view support (#{TerminalViewSupport})"
            end
          end
      end
      
    end
  end
end