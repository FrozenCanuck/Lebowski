# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

require '../../../lib/lebowski/rspec'

include Lebowski::Foundation
include Lebowski::Foundation::Views

#
# Refer to the custom_view.rb file to learn how to create your own view proxy
# based on type.
#

require 'custom_view'
include TestApp::Views

#
# In order for the Lebowski framework to know about your type proxy and use it, you
# must register the proxy with the framework's proxy factory. Once registered, the
# framework will return an instance of your proxy every time you access a view
# within the browser that is of a type the proxy is representing.
#
# The proxy factory is designed to return the most specific type of proxy based on
# what an object within the browser inherits from. As an example, the 
# TestApp.CustomRenderedView directly inherits from SC.View. If the 
# CustomRenderedView proxy was not registered with the framework's proxy factory
# then everytime you tried to access a view that was of type 
# TestApp.CustomRenderedView the proxy factory would resort to returning a
# basic View proxy. Since we are registering the CustomRenderedView proxy
# then the proxy factory will return an instance of CustomRenderedView every time 
# we access a view that is an instance of TestApp.CustomRenderedView. 
#

ProxyFactory.proxy CustomRenderedView # First registering our proxy with the ProxyFactory

App = MainApplication.new \
        :app_root_path => "/test_app", 
        :app_name => "TestApp"

App.start

App.move_to 1, 1
App.resize_to 1024, 768

#
# Define a symbolic path to the custom rendered view 
#
App.define_path 'custom_rendered_view', 'mainPage.mainPane.customRenderedView', CustomRenderedView

describe "Custom Rendered View Test" do
  
  describe "Main Box 1 Test" do
    
    before(:all) do
      #
      # The proxy returned will be a new instance of the CustomRenderedView proxy
      # that we registered earlier.
      #
      @view = App['custom_rendered_view']
      
      #
      # Access the proxy's first main box object
      #
      @main_box1 = @view.main_box_1
    end

    it "will verify that larry has url 'http://larry.com'" do
      @main_box1.larry.should have_url 'http://larry.com'
    end

    it "will verify that curly has url 'http://curly.org'" do
      @main_box1.curly.should have_url 'http://curly.org'
    end

    it "will verify that moe has url 'http://moe.net'" do
      @main_box1.moe.should have_url 'http://moe.net'
    end
    
  end
  
  describe "Main Box 2 Test" do
    
    before(:all) do
      @view = App['custom_rendered_view']
      
      #
      # Access the proxy's second main box object
      #
      @main_box2 = @view.main_box_2
    end

    it "will verify that main-box2 has title 'hello world'" do
      @main_box2.should have_title 'hello world'
    end
    
    it "will verify that the color of main-box2 is blue" do
      @main_box2.should be_blue
    end

    it "will click 'hello world' and verify the color of the box is purple" do
      @main_box2.click_title
      @main_box2.should be_purple
    end
    
  end
  
  describe "Main Box 3 Test" do
    
    before(:all) do
      @view = App['custom_rendered_view']
      
      #
      # Access the proxy's third main box object
      #
      @main_box3 = @view.main_box_3
    end

    it "will verify that the color of main-box3 is red" do
      @main_box3.should be_red
    end

    it "will double-click the alert image and verify the color of the box is black" do
      @main_box3.double_click_alert_image
      @main_box3.should be_black
    end

    it "will double-click the info image and verify the color of the box is white" do
      @main_box3.double_click_info_image
      @main_box3.should be_white
    end

    it "will double-click the box and verify the color of the box is red" do
      @main_box3.double_click_box
      @main_box3.should be_red
    end
    
  end
  
end
