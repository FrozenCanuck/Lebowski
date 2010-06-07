# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    module Views
      
      #
      # Represents a proxy to a SproutCore radio view (SC.RadioView)
      #
      class RadioView < Lebowski::Foundation::Views::View
        
        representing_sc_class 'SC.RadioView'
        
        def in_mixed_state?()
          value = self['value']
          return value.kind_of?(Array)
        end
        
        def buttons()
          if @items.nil?
            @items = Support::SimpleItemArray.new self, '.sc-radio-button'
          end
          return @items
        end
        
      end
    end
  end
end