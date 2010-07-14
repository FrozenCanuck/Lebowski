# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module SCUI
    module Mixins
      
      module NodeItemViewSupport
        include Lebowski::Foundation::Mixins::CollectionItemViewSupport
      
        def has_node_item_view_support
          return true
        end
      
        def terminal_by_name(name)
          terminal = terminals.find_first({ :terminal => name })
          raise ArgumentError.new "There is no terminal with the name #{name}." if terminal.nil?
          return terminal
        end
      
        def terminals
          @terminals = Support::TerminalViewArray.new(self) if @terminals.nil?
          return @terminals
        end

        def links
          return Support::LinksArray.new self
        end
        
        def linked_to?(item)
          node_item_view = get_node_item_view(item)
          comparison_node = node_item_view['content']
          my_node = self['content']
          
          links.each { |link| return true if (link.start_node == comparison_node) || (link.end_node == comparison_node) }
          node_item_view.links.each { |link| return true if (link.start_node == my_node) || (link.end_node == my_node) }

          return false
        end

        def positioned_left_of?(item)
          verify_positioning(item, true, -1)
        end
        
        def positioned_right_of?(item)
          verify_positioning(item, true)
        end
        
        def positioned_above?(item)
          verify_positioning(item, false, -1)
        end
        
        def positioned_below?(item)
          verify_positioning(item, false)
        end
        
        def drag_in_canvas(x, y)
          self.drag_to(@parent, x, y)
        end
        
        def drag_left_of(item)
          drag_relative_to_node(item, true, -1)
        end
        
        def drag_right_of(item)
          drag_relative_to_node(item, true)
        end
        
        def drag_above(item)
          drag_relative_to_node(item, false, -1)
        end
        
        def drag_below(item)
          drag_relative_to_node(item, false)
        end
        
        private
          def get_node_item_view(item)
            if item.kind_of? Integer
              fixed_node = @parent.item_views[item]
              raise ArgumentError.new "There is no node at index #{item}" if fixed_node.nil?
              return fixed_node
            else
              assert_item_has_node_item_view_support(item)
              return item
            end
          end

          def drag_relative_to_node(item, horizontal_drag, multiplier = 1)
            fixed_node = get_node_item_view(item)
        
            x = horizontal_drag ? (fixed_node.frame.width + 50) * multiplier : 0
            y = horizontal_drag ? 0 : (fixed_node.frame.height + 50) * multiplier
        
            self.drag_to(fixed_node, x, y)
          end
          
          def verify_positioning(item, horizontal_drag, multiplier = 1)
            fixed_node = get_node_item_view(item)
            x = horizontal_drag ? (fixed_node.position.x + (50 + fixed_node.frame.width) * multiplier) : fixed_node.position.x
            y = horizontal_drag ? fixed_node.position.y : (fixed_node.position.y + (50 + fixed_node.frame.height) * multiplier)
        
            return true if (self.position.x == x) && (self.position.y == y)
            return false
          end
          
          def assert_item_has_node_item_view_support(item)
            if not item.respond_to? :has_node_item_view_support
              raise ArgumentError.new "The item passed in must have node item view support (#{NodeItemViewSupport})"
            end
          end
        
        module Support
          
          class TerminalViewArray < Lebowski::Foundation::ObjectArray
            def initialize(parent, *params)
              if params.empty?
                super(parent, 'childViews', 'length', { :prefilter => { :isTerminal => true } })
              else
                super(parent, 'childViews', 'length', *params)
              end
            end

            def create_object(index, expected_type=nil)
              rel_path = "#{@array_rel_path}.#{index}"
              obj = @parent[rel_path, expected_type]

              mix_in_support_for_object obj
              return obj
            end

            def mix_in_support_for_object(obj)
              if not obj.class.ancestors.member? Lebowski::SCUI::Mixins::TerminalViewSupport
                obj.extend Lebowski::SCUI::Mixins::TerminalViewSupport
              end
            end

            def create_filtered_object_array(parent, array_rel_path, array_length_property_name, prefilter)
              klass = self.class
              return klass.new parent, prefilter
            end
          end

          class LinksArray < Lebowski::Foundation::ObjectArray
            def initialize(parent)
              links_key = parent['content.linksKey']
              super(parent, "content.#{links_key}")
            end

            def create_object(index, expected_type=nil)
              rel_path = "#{@array_rel_path}.#{index}"
              obj = @parent[rel_path, expected_type]

              mix_in_support_for_object obj
              return obj
            end

            def mix_in_support_for_object(obj)
              if not obj.class.ancestors.member? Lebowski::SCUI::Mixins::LinkSupport
                obj.extend Lebowski::SCUI::Mixins::LinkSupport
              end
            end
          end
          
        end
        
      end
      
    end
  end
end