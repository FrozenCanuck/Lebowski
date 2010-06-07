require File.expand_path(File.dirname(__FILE__) + '/scui/views/date_picker')
require File.expand_path(File.dirname(__FILE__) + '/scui/views/combo_box')
require File.expand_path(File.dirname(__FILE__) + '/scui/views/linkit')
require File.expand_path(File.dirname(__FILE__) + '/scui/mixins/node_item_view_support')
require File.expand_path(File.dirname(__FILE__) + '/scui/mixins/terminal_view_support')

module Lebowski
  module SCUI
    module Views
      include Lebowski::Foundation
    
      ProxyFactory.proxy DatePickerView
      ProxyFactory.proxy ComboBoxView
      ProxyFactory.proxy CanvasView
      
    end
  end
end