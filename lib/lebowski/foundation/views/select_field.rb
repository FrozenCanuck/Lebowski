# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    module Views
      
      #
      # Represents a proxy to a SproutCore select field view (SC.SelectFieldView)
      #
      class SelectFieldView < Lebowski::Foundation::Views::View
        # include Lebowski::Foundation

        representing_sc_class 'SC.SelectFieldView'

        EMPTY_VALUE = '***'

        def selected?()
          val = self['value']
          return false if val.nil?
          return false if (val.kind_of?(String) and (val.empty? or val == EMPTY_VALUE))
          return true
        end
        
        #
        # Use to check if this view has an empty item
        #
        def has_empty_option?()
          empty = self['emptyName']
          return (not (empty.nil? or empty.empty?))
        end
        
        def selected_with_name?(value)
          objs = self['objects']
          val = self['value']
          objs.each do |obj|
            name = get_object_name(obj)
            return (val == get_object_value(obj)) if (not (name =~ /^#{value}$/i).nil?)
          end
          return false
        end
        
        def selected_with_value?(value)
          objs = self['objects']
          val = self['value']
          objs.each do |obj|
            if value.kind_of? String
              return true if (not (val =~ /^#{get_object_value(obj)}$/i).nil?)
            else
              return true if (value == val)
            end
          end
          return false
        end
        
        def selected_with_index?(index)
          # TODO
        end

        def select(val)
          return if val.nil?

          if val.kind_of? Integer
            select_with_index(val)
          elsif val == :empty
            select_empty
          else
            select_with_name(val.to_s)
          end
        end
        
        #
        # Used to select an item via its index
        #
        # @see #select
        #
        def select_with_index(val)
          option_locator = "index=#{val}"
          @driver.sc_select(:view, option_locator, self.abs_path)
          stall :select
        end

        #
        # Used to select an item via its label
        #
        # @see #select
        #
        def select_with_name(val)
          option_locator = "label=regexi:^#{val}$"
          @driver.sc_select(:view, option_locator, self.abs_path)
          stall :select
        end

        #
        # Used to select an item via its value
        #
        # @see #select
        #
        def select_with_value(val)
          option_locator = "value=regexi:^(nu|st|sc)#{val}$"
          @driver.sc_select(:view, option_locator, self.abs_path)
          stall :select
        end

        #
        # Used to select the empty item, if there is one
        #
        # @see #select
        #
        def select_empty()
          option_locator = "value=#{EMPTY_VALUE}"
          @driver.sc_select(:view, option_locator, self.abs_path)
          stall :select
        end
        
      private

        def get_object_name(obj)
          if obj.kind_of?(ProxyObject)
            @nameKey = self["nameKey"] if @nameKey.nil?
            return obj[@nameKey]
          end
            return obj
        end

        def get_object_value(obj)
          if obj.kind_of?(ProxyObject)
            @valueKey = self["valueKey"] if @valueKey.nil?
            return obj[@valueKey]
          end
          return obj
        end
    
      end
    end
  end
end