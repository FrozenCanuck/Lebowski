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

        def drag_to_coordinates(x, y)
          coord_x = -1*(self.position.x) + self.frame.width + x
          coord_y = -1*(self.position.y) + self.frame.height + y
          
          self.drag(coord_x, coord_y)
        end
        
        def drag_to_node(item)
          fixed_node = get_fixed_node(item)
          self.drag_on_to(fixed_node)
        end
        
        def drag_before_node(item)
          drag_relative_to_node(item, true, -1)
        end
        
        def drag_after_node(item)
          drag_relative_to_node(item, true)
        end
        
        def drag_above_node(item)
          drag_relative_to_node(item, false, -1)
        end
        
        def drag_below_node(item)
          drag_relative_to_node(item, false)
        end
        
        private
          def get_fixed_node(item)
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
            fixed_node = get_fixed_node(item)
        
            x = horizontal_drag ? (fixed_node.frame.width + 50) * multiplier : 0
            y = horizontal_drag ? 0 : (fixed_node.frame.height + 50) * multiplier
        
            self.drag_to(fixed_node, x, y)
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