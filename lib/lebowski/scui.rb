# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

require File.expand_path(File.dirname(__FILE__) + '/scui/views/date_picker')
require File.expand_path(File.dirname(__FILE__) + '/scui/views/combo_box')
require File.expand_path(File.dirname(__FILE__) + '/scui/views/linkit')
require File.expand_path(File.dirname(__FILE__) + '/scui/views/select_field_tab')
require File.expand_path(File.dirname(__FILE__) + '/scui/views/color_well')
require File.expand_path(File.dirname(__FILE__) + '/scui/views/content_editable')
require File.expand_path(File.dirname(__FILE__) + '/scui/mixins/node_item_view_support')
require File.expand_path(File.dirname(__FILE__) + '/scui/mixins/terminal_view_support')
require File.expand_path(File.dirname(__FILE__) + '/scui/mixins/link_support')

module Lebowski
  
  #
  # The SCUI module contains proxies for views that are part of the SCUI framework
  #
  #   http://github.com/etgryphon/sproutcore-ui
  #
  module SCUI
    module Views
      include Lebowski::Foundation
    
      ProxyFactory.proxy DatePickerView
      ProxyFactory.proxy ComboBoxView
      ProxyFactory.proxy CanvasView
      ProxyFactory.proxy SelectFieldTabView
      ProxyFactory.proxy ColorWellView
      ProxyFactory.proxy ContentEditableView
      
    end
  end
end