begin
  kind_of? ::Lebowski::Foundation
rescue Exception => e
  require_relative '../../../../lib/lebowski/rspec'  
  include Lebowski::Foundation
  include Lebowski::Foundation::Views
end

SPECS_ROOT_FOLDER = 'specs'
VIEWS_ROOT_FOLDER = 'views'
PANES_ROOT_FOLDER = 'panes'

SC_CONTROLS = { }

def add_view_spec(group, sc_type, sub_path)
  SC_CONTROLS[group] = { :type => sc_type, :path => "#{VIEWS_ROOT_FOLDER}/#{sub_path}" }
end

def add_pane_spec(group, sc_type, sub_path)
  SC_CONTROLS[group] = { :type => sc_type, :path => "#{PANES_ROOT_FOLDER}/#{sub_path}" }
end

module App
  
  @@app = nil
  
  def self.initialize(browser=:firefox)
    @@app = MainApplication.new \
      :app_root_path => "/sc_controls", 
      :app_name => "TestApp",
      :browser => browser

    @@app.start do |app|
      app['mainPage.mainPane.isPaneAttached']
    end

    @@app.move_to 1, 1
    @@app.resize_to 1024, 768

    @@app.define_path 'controlsList', '#controls-list', ListView
    @@app.define_path 'controlContainer', '#control-container', View
  end
  
  def self.get_instance
    return @@app
  end
  
end

def show_control(control)
  app = App.get_instance
  app['controlsList'].item_views.find_first({ :name => SC_CONTROLS[control][:type] }).select
end

def run_specs(path=:all, spec=nil)
  full_path = "#{SPECS_ROOT_FOLDER}/"
  
  if path == :all
    full_path += "**/*.rb"
  elsif path.kind_of? Symbol
    controls_path = SC_CONTROLS[path][:path]
    full_path += "#{controls_path}/"
    full_path += spec.nil? ? "**/*.rb" : "#{spec.sub(/\.rb/i, '')}.rb"
  elsif path =~ /\.rb/i
    full_path += path
  else
    full_path = "#{path}/**/*.rb"
  end

  paths = Dir.glob(full_path) 
  
  paths.each do |path|
    require_relative path
  end
end

add_view_spec :button_view, 'SC.ButtonView', 'button_view'
add_view_spec :label_view, 'SC.LabelView', 'label_view'
add_view_spec :container_view, 'SC.ContainerView', 'container_view'
add_view_spec :segmented_view, 'SC.SegmentedView', 'segmented_view'
add_view_spec :web_view, 'SC.WebView', 'web_view'
add_view_spec :list_view, 'SC.ListView', 'list_view'
add_view_spec :list_item_view, 'SC.ListItemView', 'list_item_view'
add_view_spec :radio_view, 'SC.RadioView', 'radio_view'
add_view_spec :select_button_view, 'SC.SelectButtonView', 'select_button_view'
add_view_spec :checkbox_view, 'SC.CheckboxView', 'checkbox_view'
add_view_spec :select_field_view, 'SC.SelectFieldView', 'select_field_view'

add_pane_spec :alert_pane, 'SC.AlertPane', 'alert_pane'
add_pane_spec :palette_pane, 'SC.PalettePane', 'palette_pane'
add_pane_spec :picker_pane, 'SC.PickerPane', 'picker_pane'
add_pane_spec :menu_pane, 'SC.MenuPane', 'menu_pane'