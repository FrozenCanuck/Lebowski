# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    module Views
      
      #
      # Represents a proxy to a SproutCore container view (SC.ContainerView)
      #
      class ContainerView < Lebowski::Foundation::Views::View
        
        representing_sc_class 'SC.ContainerView'
        
        def empty?()
          return self['contentView'].nil?
        end
        
        def showing?(view)
          if not view.kind_of? View
            raise ArgumentInvalidTypeError.new "view", view, View
          end
          
          return (view == self['contentView'])
        end
        
      end
    end
  end
end