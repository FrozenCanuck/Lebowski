# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    
    module ProxyFactory
      
      @@proxies = {}
  
      def self.has_key?(key)
        return @@proxies.has_key? key.downcase
      end
      
      def self.create_proxy(key, parent, rel_path, driver=nil)
        klass = nil
        
        if key.kind_of?(String)
          klass = @@proxies[key.downcase] 
        elsif key.kind_of?(Class) and key.ancestors.member?(Lebowski::Foundation::SCObject)
          klass = key
        else
          raise ArgumentError.new "key is an invalid type: #{key}"
        end
        
        raise ArgumentError.new "proxy key not recognized: #{key}" if klass.nil?
        
        if (parent.nil? and driver.nil?)
          raise ArgumentError.new "must supply a driver either through the parent or driver arguments"
        end
        
        driver = driver.nil? ? parent.driver : driver
        
        return klass.new(parent, rel_path, driver) if rel_path.kind_of? String
        return klass.new(parent, "#{rel_path}", driver) if rel_path.kind_of? Integer
        
        raise ArgumentError.new "rel_path is an invalid type: #{rel_path.class}"
      end
      
      def self.proxy(klass)
        if not (klass.kind_of?(Class) and klass.ancestors.member?(Lebowski::Foundation::SCObject))
          raise ArgumentError.new "class must inherit Lebowski::Foundation::Object: #{klass.class}"
        end
        
        @@proxies[klass.represented_sc_class.downcase] = klass
      end
      
    end
      
  end
end 

module Lebowski
  module Foundation
  
    include Views
    include Panes
    
    ProxyFactory.proxy View
    ProxyFactory.proxy LabelView
    ProxyFactory.proxy ButtonView
    ProxyFactory.proxy ContainerView
    ProxyFactory.proxy SegmentedView
    ProxyFactory.proxy RadioView
    ProxyFactory.proxy CheckboxView
    ProxyFactory.proxy DisclosureView
    ProxyFactory.proxy TextFieldView
    ProxyFactory.proxy SelectFieldView
    ProxyFactory.proxy MenuItemView
    ProxyFactory.proxy CollectionView
    ProxyFactory.proxy ListView
    ProxyFactory.proxy ListItemView
    ProxyFactory.proxy WebView
    ProxyFactory.proxy SelectButtonView
    
    ProxyFactory.proxy Pane
    ProxyFactory.proxy MainPane
    ProxyFactory.proxy ModalPane
    ProxyFactory.proxy PanelPane
    ProxyFactory.proxy AlertPane
    ProxyFactory.proxy PalettePane
    ProxyFactory.proxy PickerPane
    ProxyFactory.proxy SheetPane
    ProxyFactory.proxy MenuPane
    
  end  
end