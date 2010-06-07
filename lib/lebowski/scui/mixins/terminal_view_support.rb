module Lebowski
  module SCUI
    module Mixins
      
      module TerminalViewSupport
        def has_terminal_view_support
          return true
        end
        
        def link_to(end_term, x = 0, y = 0)
          assert_item_has_terminal_view_support(end_term)
          self.drag_to(end_term, x, y)
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