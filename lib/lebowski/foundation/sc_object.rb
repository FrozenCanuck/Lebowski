# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    
    class SCObject < ProxyObject
      
      @@represented_sc_classes = {}
      
      def self.representing_sc_class(sc_class)
        raise ArgumentError "sc_class must be a non-empty string" if (not sc_class.kind_of? String) or sc_class.empty?
        return if @@represented_sc_classes.has_key? self.to_s
        @@represented_sc_classes[self.to_s] = sc_class
      end
      
      def self.represented_sc_class
        return @@represented_sc_classes[self.to_s]
      end
      
      def represented_sc_class
        return @@represented_sc_classes[self.class.to_s]
      end
      
      def has_represented_sc_class?()
        return (not represented_sc_class.nil?)
      end
      
      def kind_of_represented_sc_class?()
        return false if (not has_represented_sc_class?)
        return sc_kind_of?(represented_sc_class)
      end
      
    end
  end
end