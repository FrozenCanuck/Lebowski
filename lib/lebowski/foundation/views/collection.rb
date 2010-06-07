# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    
    module Views
      
      #
      # Represents a proxy to a generic SproutCore collection view (SC.CollectionView)
      #
      class CollectionView < Lebowski::Foundation::Views::View
        include Lebowski::Foundation
        
        representing_sc_class 'SC.CollectionView'
        
        def allowed_content_reordering?()
          return self['canReorderContent']
        end
        
        def allowed_content_deletion?()
          return self['canDeleteContent']
        end
        
        def allowed_content_editing?()
          return self['canEditContent']
        end
        
        def allowed_deselect_all?()
          return self['allowDeselectAll']
        end
        
        def content()
          @content = create_content_object_array if @content.nil?
          return @content
        end
        
        def item_views()
          @item_views = create_item_views_object_array if @item_views.nil?
          return @item_views
        end
        
        def can_drag_to_start_of?()
          return false
        end
        
        def can_drag_to_end_of?()
          return false
        end
        
        def apply_drag_to_start_of(source)
          # no-op
        end
        
        def apply_drag_to_end_of(source)
          # no-op
        end
        
      protected
      
        def create_content_object_array()
          return Support::CollectionItemArray.new self
        end
        
        def create_item_views_object_array()
          return Support::CollectionItemViewArray.new self
        end
        
      end
      
      module Support
        
        # Represents a generic array of content objects for a collection view
        class CollectionItemArray < Lebowski::Foundation::ObjectArray
          include Lebowski::Foundation

          def initialize(parent, *params)
            super(parent, 'content', 'length', *params)
          end

          def selected()
            @selected = self.filter({ :is_selected => true }) if @selected.nil?
            return @selected
          end

        protected

          def create_filtered_object_array(parent, array_rel_path, array_length_property_name, prefilter)
            klass = self.class
            return klass.new parent, prefilter
          end

          def init_validate_parent(parent)
            if not parent.kind_of? CollectionView
              raise ArgumentInvalidTypeError.new "parent", parent, CollectionView
            end
          end

          def item_is_selected?(index)
            return @driver.get_sc_collection_view_content_is_selected(@parent.abs_path, index)
          end

          def item_is_group?(index)
            return @driver.get_sc_collection_view_content_is_group(@parent.abs_path, index)
          end

          def item_outline_level(index) 
            return @driver.get_sc_collection_view_content_outline_level(@parent.abs_path, index)
          end

          def item_disclosure_state(index)
            return @driver.get_sc_collection_view_content_disclosure_state(@parent.abs_path, index)
          end

          # @override
          #
          # Handle special flags 
          def find_indexes_process_filter(filter)
            processed_filter = {}

            @item_is_selected_flag = :no_flag
            @item_is_group_flag = :no_flag
            @item_outline_level_flag = :no_flag
            @item_disclosure_state_flag = :no_flag

            filter.each do |key, value|
              case key
              when :is_selected
                @item_is_selected_flag = value
              when :is_group
                @item_is_group_flag = value
              when :outline_level
                @item_outline_level_flag = value
              when :disclosure_state
                @item_disclosure_state_flag = value
              else
                processed_filter[key] = value
              end
            end

            return processed_filter
          end

          # @override
          #
          # Handle special flags
          def find_indexes_process_indexes(indexes)
            processed_indexes = []

            indexes.each do |index|
              if @item_is_selected_flag != :no_flag
                next if item_is_selected?(index) != @item_is_selected_flag
              end

              if @item_is_group_flag != :no_flag
                next if item_is_group?(index) != @item_is_group_flag
              end

              if @item_outline_level_flag != :no_flag
                next if item_outline_level(index) != @item_outline_level_flag
              end

              if @item_disclosure_state_flag != :no_flag
                next if item_disclosure_state(index) != @item_disclosure_state_flag
              end

              processed_indexes << index
            end

            return processed_indexes
          end

        end
        
        # Represents a generic array of item views for a collection view
        class CollectionItemViewArray < CollectionItemArray
          include Lebowski::Foundation
          include Lebowski::Foundation::Views

          SELECT_ALL_KEY = 'a'
          
          def index_of(obj)
            indexes = find_indexes({ :sc_guid => obj.content.sc_guid })
            return indexes.empty? ? -1 : indexes[0]
          end

          def find_with_content(content)
            if content.nil?
              raise ArgumentError.new "content can not be nil"
            end

            content = [content] if (not content.kind_of? Array)

            items = []
            content.each do |obj|
              if not obj.kind_of? Lebowski::Foundation::ProxyObject
                raise ArgumentInvalidTypeError.new "content", obj, Lebowski::Foundation::ProxyObject
              end

              guid = obj.sc_guid
              result = find_all({ :sc_guid => guid })
              items << result[0] if (not result.empty?)
            end
            return items
          end

          def select(filter)
            raise ArgumentError.new "filter required" if filter.nil?
            deselect_all
            select_with_fiter(filter)
          end
          
          def select_add(filter)
            raise ArgumentError.new "filter required" if filter.nil?
            select_with_fiter(filter)
          end
          
          def select_range(val1, val2)
            idx1 = get_index(val1, 'val1')
            idx2 = get_index(val2, 'val2')
            items_count = @parent.item_views.count
            if (idx1 < 0 or idx1 >= items_count) or (idx2 < 0 or idx2 >= items_count)
              raise ArgumentError.new "arguments are out of bounds"
            end
            item1 = @parent.item_views[idx1]
            item2 = @parent.item_views[idx2]
            item1.click
            @parent.key_down :shift_key
            item1.select
            item2.select
            @parent.key_up :shift_key
          end
          
          def deselect(filter)
            raise ArgumentError.new "filter required" if filter.nil?
            
            @parent.key_down :ctrl_key
            each filter do |view, index|
              view.deselect
            end
            @parent.key_up :ctrl_key
          end 

          def select_all()
            num_views = count
            return if (num_views == 0)

            if num_views > 1
              select_range(self[0], self[num_views - 1])
            end            
          end

          def deselect_all()
            @parent.click
          end

        protected

          # @Override
          #
          # Will mixin collection view support for returned proxy
          def create_object(index, expected_type=nil)
            rel_path = "itemViewForContentIndex.#{index}"
            obj =  @parent[rel_path, expected_type]
            # Before we return the item view we have to make sure the
            # proxy has collection item view support mixin
            mix_in_support_for_object obj
            return obj
          end
          
          # Mixes in the CollectionItemViewSupport mixin for the given proxy object. 
          #
          # This is required since the example view provided to a collection
          # view can be any type of view; therefore, we can't assume the proxy 
          # representing the view will already have collection item view suppor
          def mix_in_support_for_object(obj)
            if not obj.class.ancestors.member? Mixins::CollectionItemViewSupport            
              obj.extend Mixins::CollectionItemViewSupport
            end
          end
          
        private
          
          def get_index(val, val_name)
            return val if val.kind_of?(Integer)
            return index_of(val) if val.kind_of?(Lebowski::Foundation::ProxyObject)
            raise ArgumentInvalidTypeError.new val_name, val, Integer, Lebowski::Foundation::ProxyObject
          end
          
          def select_with_fiter(filter)
            each filter do |view, index|
              view.select_add
            end
          end

        end
        
      end
    
    end
  end
end