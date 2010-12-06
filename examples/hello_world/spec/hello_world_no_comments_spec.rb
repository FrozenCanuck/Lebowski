# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

begin
  kind_of? ::Lebowski::Foundation
rescue Exception => e
  require_relative '../../../lib/lebowski/rspec'  
  include Lebowski::Foundation
  include Lebowski::Foundation::Views
end

App = MainApplication.new \
        :app_root_path => "/hello_world", 
        :app_name => "HelloWorldApp",
        :browser => :firefox

App.start do |app|
  app['mainPage.mainPane.isPaneAttached'] == true
end

App.move_to 1, 1 
App.resize_to 1024, 768 

App.define_path 'group', 'mainPage.mainPane.groupView'

describe "Hello World Test" do
  
  before(:all) do    
    @label = App['group.label', 'SC.LabelView']
    @hello_button = App['group.helloButton', ButtonView]
    @world_button = App['#world-button', ButtonView]
  end
  
  it "will check that label has an initial value 'click a button'" do
    @label.should have_value /click a button/i
  end
  
  it "will check that hello button has title 'hello'" do
    @hello_button.should have_title /hello/i
  end
  
  it "will check that world button has title 'world'" do
    @world_button.should have_title /world/i
  end
  
  it "will click hello button and then confirm label has value 'hello'" do
    @hello_button.click
    @label.should have_value /hello/i
  end

  it "will click world button and then confirm label has value 'world'" do
    @world_button.click
    @label.should have_value /world/i
  end
  
end