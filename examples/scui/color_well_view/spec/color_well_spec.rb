require '../../../../lib/lebowski/spec'

include Lebowski::Foundation
include Lebowski::SCUI::Views

App = Application.new :app_root_path => "/test_app", :app_name => "TestApp" , :browser => :firefox

App.start
App.window.maximize

App.define 'color_well', 'mainPage.mainPane.colorView', ColorWellView

describe "VIEW: SCUI.ColorWell" do
  before(:all) do
    @view = App['color_well']
  end

  it "will click the color well" do
    @view.click
  end

  it "will verify that there is no color selected" do
    @view.should_not have_color_selected
  end

  it "will select #96eee6 as the color and verify" do
    @view.select_color '#96eee6'
    @view.should have_color_selected
    @view.should have_color '#96eee6'
  end
  
  it "will select the color red and verify" do
    @view.select_color :red
    @view.should have_color_selected
    @view.should have_color :red
  end
  
  it "will select the color green and verify" do
    @view.select_color :green
    @view.should have_color_selected
    @view.should have_color :green
  end
  
  it "will select the color blue and verify" do
    @view.select_color :blue
    @view.should have_color_selected
    @view.should have_color :blue
  end

  it "will select the color orange and verify" do
    @view.select_color :orange
    @view.should have_color_selected
    @view.should have_color :orange
  end
  
  it "will select the color yellow and verify" do
    @view.select_color :yellow
    @view.should have_color_selected
    @view.should have_color :yellow
  end
  
  it "will select the color violet and verify" do
    @view.select_color :violet
    @view.should have_color_selected
    @view.should have_color :violet
  end
  
  it "will select the color gray and verify" do
    @view.select_color :gray
    @view.should have_color_selected
    @view.should have_color :gray
  end
  
  it "will select the color black and verify" do
    @view.select_color :black
    @view.should have_color_selected
    @view.should have_color :black
  end
  
  it "will select the color white and verify" do
    @view.select_color :white
    @view.should have_color_selected
    @view.should have_color :white
  end
end