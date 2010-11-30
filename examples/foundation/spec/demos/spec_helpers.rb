DEBUG = true

SPECS_ROOT_FOLDER = 'specs'
VIEWS_ROOT_FOLDER = 'views'
PANES_ROOT_FOLDER = 'panes'

SC_CONTROLS = {
  :web_view => { :type => 'SC.WebView', :path => "#{VIEWS_ROOT_FOLDER}/web_view" },
  :list_view => { :type => 'SC.ListView', :path => "#{VIEWS_ROOT_FOLDER}/list_view" },
  :list_item_view => { :type => 'SC.ListItemView', :path => "#{VIEWS_ROOT_FOLDER}/list_item_view" },
  :palette_pane => { :type => 'SC.PalettePane', :path => "#{PANES_ROOT_FOLDER}/palette_pane" }
}

def show_control(control)
  App['controlsList'].item_views.find_first({ :name => SC_CONTROLS[control][:type] }).select
end

def run_specs(path, spec=nil)
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