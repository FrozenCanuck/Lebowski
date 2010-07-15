# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module SCUI
    module Views
      
      #
      # Represents a proxy to a SCUI content editable view (SCUI.ContentEditableView)
      #
      class ContentEditableView < Lebowski::Foundation::Views::WebView
        
        representing_sc_class 'SCUI.ContentEditableView'
      
        def empty_selection?()
          value = self['selection']
          return (value == '' or value.nil?)
        end
      
        def image_selected?()
          return (not self['selectedImage'].nil?)
        end
        
        def hyperlink_selected?()
          return (not self['selectedHyperlink'].nil?) 
        end
        
        def find_elements(selector)
          return ContentEditableViewSupport::DOMElementList.new self, selector
        end
        
        def find_element(selector)
          elems = ContentEditableViewSupport::DOMElementList.new self, selector
          return nil if elems.empty?
          return elems[0]
        end
        
        def create_range(*params)
          return ContentEditableViewSupport::Range.new self, *params
        end
        
        def select_all()
          body = find_element('body')
          body.select_content
        end
        
        def select_none()
          set_cursor_to_end
        end
        
        def set_cursor_to_start()
          body = find_element('body')
          range = create_range
          range.set_start body, 0
          range.set_end body, 0
          range.collapse
          return range
        end
        
        def set_cursor_to_end()
          body = find_element('body')
          nodes = body.child_nodes_count
          range = create_range
          range.set_start body, nodes
          range.set_end body, nodes
          range.collapse
          return range
        end
  
        def delete_all_content()
          body = find_element('body')
          nodes = body.child_nodes_count
          range = create_range
          range.set_start body, 0
          range.set_end body, nodes
          range.delete_content
        end
        
        def insert_content_at_start(content)
          range = set_cursor_to_start
          range.insert_content content
        end
        
        def insert_content_at_end(content)
          range = set_cursor_to_end
          range.insert_content content
        end
        
      end
      
      module ContentEditableViewSupport
        
        class Range
          include Lebowski::Foundation
          
          attr_reader :start_element, :end_element, :start_offset, :end_offset
          
          def initialize(view, *params) 
            
            @start_element = nil
            @end_element = nil
            @start_offset = 0
            @end_offset = 0
            @start_before = false
            @start_after = false
            @end_before = false
            @end_after = false
            
            if params[0].kind_of? Hash
              hash = params[0]
              @start_element = hash[:start_element]
              @end_element = hash[:end_element]
              @start_offset = hash[:start_offset].nil? ? 0 : hash[:start_offset]
              @end_offset = hash[:end_offset].nil? ? 0 : hash[:end_offset]
            elsif params.length == 4
              @start_element = params[0]
              @start_offset = params[1]
              @end_element = params[2]
              @end_offset = params[3]
            elsif params.length != 0
              raise ArgumentError.new "invalid number of arguments supplied"
            end
        
            assert_element_is_valid(@start_element, "start element")
            assert_element_is_valid(@end_element, "end element")
            assert_offset_is_valid(@start_offset, "start offset")
            assert_offset_is_valid(@end_offset, "end offset")
            
            @view = view
          end
          
          def set_start(elem, offset=0)
            assert_element_is_valid(elem, "elem")
            assert_offset_is_valid(offset, "offset")
            
            @start_element = elem
            @start_offset = offset
            @start_before = false
            @start_after = false
          end
          
          def set_end(elem, offset=0)
            assert_element_is_valid(elem, "elem")
            assert_offset_is_valid(offset, "offset")
          
            @end_element = elem
            @end_offset = offset
            @end_before = false
            @end_after = false
          end
          
          def set_start_before(elem)
            assert_element_is_valid(elem, "elem")
            
            @start_element = elem
            @start_offset = 0
            @start_before = true
            @start_after = false
          end
          
          def set_start_after(elem)
            assert_element_is_valid(elem, "elem")
            
            @start_element = elem
            @start_offset = 0
            @start_before = false
            @start_after = true
          end
          
          def set_end_before(elem)
            assert_element_is_valid(elem, "elem")
            
            @end_element = elem
            @end_offset = 0
            @end_before = true
            @end_after = false
          end
          
          def set_end_after(elem)
            assert_element_is_valid(elem, "elem")
            
            @end_element = elem
            @end_offset = 0
            @end_before = false
            @end_after = true
          end
          
          def has_start_defined?()
            return ((not @start_element.nil?) or @start_before == true or @start_after == true) 
          end
          
          def has_end_defined?()
            return ((not @end_element.nil?) or @end_before == true or @end_after == true)
          end
          
          def has_boundaries_defined?()
            start_defined = has_start_defined? and has_end_defined?
          end
          
          def select()
            if @start_element.nil? or @end_element.nil?
              raise StandardError.new "unable to select range. start and end elements must be defined"
            end
            
            @view.exec_driver_in_context do |driver|
              driver.select_range create_range_hash_object
              driver.mouse_up('css=body')
            end
          end
          
          def collapse(to_start=true)
            if not has_boundaries_defined?
              raise StandardError.new "unable to collapse range. boundaries must be defined"
            end
            
            hash = create_range_hash_object
            if to_start == true
              hash[:collapseToStart] = true
            else
              hash[:collapseToEnd] = true
            end
            
            @view.exec_driver_in_context do |driver|
              driver.select_range hash
              driver.mouse_up('css=body')
            end
          end
          
          def delete_content()
            if not has_boundaries_defined?
              raise StandardError.new "unable to delete content. boundaries must be defined"
            end
          
            @view.exec_driver_in_context do |driver|
              driver.range_delete_content create_range_hash_object
              driver.mouse_up('css=body')
            end
          end
          
          def insert_content(content)
            if not content.kind_of? String
              raise ArgumentError.new "unable to insert content. content must be a string"
            end
            
            if not has_boundaries_defined?
              raise StandardError.new "unable to insert content. boundaries must be defined"
            end
            
            hash = create_range_hash_object
            hash[:content] = content
          
            @view.exec_driver_in_context do |driver|
              driver.range_insert_content hash
              driver.mouse_up('css=body')
            end
          end
          
        private
        
          def assert_element_is_valid(element, name)
            if not (element.nil? or element.kind_of? DOMElement)
              raise ArgumentError.new "a valid #{name} must supplied"
            end
          end
          
          def assert_offset_is_valid(offset, name)
            if not ((offset.kind_of? Integer and offset >= 0) or offset.kind_of? String)
              raise ArgumentError.new "#{name} must be an integer greater than or equal to 0"
            end
          end
          
          def create_range_hash_object()
            return {
              :startElementSelector => @start_element.selector,
              :startElementIndex => @start_element.index,
              :startOffset => @start_offset,
              :startBefore => @start_before,
              :startAfter => @start_after,
              :endElementSelector => @end_element.selector,
              :endElementIndex => @end_element.index,
              :endOffset => @end_offset,
              :endBefore => @end_before,
              :endAfter => @end_after
            }
          end
          
        end

        class DOMElement
          
          attr_reader :index, :selector
          
          def initialize(view, selector, index)
            @selector = selector
            @index = index
            @view = view
          end
          
          def to_s()
            return "DOMElement<selector=#{selector},index=#{index}>"
          end
          
          def tag()
            value = ''
            @view.exec_driver_in_context do |driver|
              value = driver.get_element_tag_name @selector, @index
            end
            return value
          end
          
          def child_nodes_count()
            value = 0
            @view.exec_driver_in_context do |driver|
              value = driver.get_element_child_nodes_count @selector, @index
            end
            return value
          end
          
          def select()
            range = @view.create_range
            range.set_start_before self
            range.set_end_after self
            range.select
            return range
          end
          
          def select_content()
            range = @view.create_range
            range.set_start self, 0
            range.set_end self, child_nodes_count
            range.select
            return range
          end
          
          def set_cursor_before()
            range = @view.create_range
            range.set_start_before self
            range.set_end_after self
            range.collapse
            return range
          end
          
          def set_cursor_after()
            range = @view.create_range
            range.set_start_before self
            range.set_end_after self
            range.collapse false
            return range
          end
    
          def delete()
            range = @view.create_range
            range.set_start_before self
            range.set_end_after self
            range.delete_content
          end
          
          def insert_content_before(content)
            range = set_cursor_before
            range.insert_content content
          end
          
          def insert_content_after(content)
            range = set_cursor_after
            range.insert_content content
          end
          
        end
        
        class DOMElementList
          
          attr_reader :selector
          
          def initialize(view, selector)
            @selector = selector
            @view = view
          end
          
          def empty?()
            return (count == 0)
          end
          
          def count()
            value = 0
            @view.exec_driver_in_context do |driver|
              value = driver.get_css_selector_count(@selector)
            end
            return value
          end
          
          def [](index)
            if not index.kind_of? Integer or index < 0 or index >= count
              raise ArgumentError.new "index is out of bounds: #{index}"
            end
            
            return DOMElement.new @view, @selector, index
          end
          
          def each(&block)
            return if empty?
            
            (0..count).each do |index|
              yield DOMElement.new(@view, @selector, index)
            end
          end
          
        end
        
      end
      
    end
  end
end