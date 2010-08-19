# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

# require '../../../lib/lebowski/spec'
# 
# include Lebowski::Foundation
# include Lebowski::Foundation::Views

#
# If this is your first time working with the Lebowski framework and haven't
# tried using it before, get started with the first hello world spec test in the
# hello_world_spec.rb file. Come back to this more advanced test when you're done.
#

#
# In this test script we are going to make use of a custom proxy that will be used
# for a specific property path. This type of custom proxy is refered to as a "path proxy". 
# The other type of proxy is based on a SproutCore object's type. They are refered to 
# "type proxies".
#
# Both path proxies and type proxies are helpful to people who need to write scripts. They
# abstract away the deeper technical details of how to access a specific child view or how to
# interact with parts of the view in specific way. This helps keep scripts more maintainable,
# easier to use, and easier to read. It's good for everyone :-).
#
# Here we made a path proxy called GroupView. You can find the source code in the
# group_view.rb file. The proxy is pretty basic but it demonstrates how to make
# one. 
#

# 
# Before we run the test, we first have to require the file containing the path proxy and
# then include the module the proxy is contained within.
#
require 'group_view'
include HelloWorldApp::Views

#
# You have to create an instance of you application before you make use of the path proxy.
#
App = MainApplication.new \
        :app_root_path => "/hello_world", 
        :app_name => "HelloWorldApp", 
        :browser => :firefox

#
# Now get the application started.
#
App.start do |app|
  app['isLoaded'] == true
end

App.move_to 1, 1
App.resize_to 1024, 768

#
# Let's set up our symbolic path to the group view in our SproutCore application
#
App.define_path 'group', 'mainPage.mainPane.groupView', View

#
# Now we can go ahead and add our path proxy to our application. Notice that you have
# to also supply the path the path proxy will be linked to. Anytime you now access
# 'group', you will always get back an instance of the GroupView proxy. Not much to it.
#
App.define_proxy GroupView, 'group'

describe "Hello World Test" do

  #
  # Remember that we've linked the GroupView with 'group', so we'll get back and instance 
  # of the GroupView.
  #
  before(:all) do
    @group = App['group']
  end
  
  #
  # Using the GroupView path proxy, we can access the label view using proxy's label method. 
  #
  # But wait a minute. Why not just use the property path? You could, but if the
  # path to the label were to change within the group view then we just have one
  # place to make the change instead of all over the place. Again, one of the
  # benefits of using proxies is to make things easier to maintain.
  #
  it "will check that label has an initial value 'click a button'" do
    @group.label.should have_value /click a button/i
  end
  
  #
  # The proxy also has a method to access the hello button and world button
  #
  it "will check that hello button has title 'hello'" do
    @group.hello_button.should have_title /hello/i
  end
  
  it "will check that world button has title 'world'" do
    @group.world_button.should have_title /world/i
  end
  
  #
  # Instead of calling the hello button view's click button directly, we instead
  # use the proxy's click_hello button. Calling the method will in turn call the
  # actual button view's click method.
  #
  it "will click hello button and then confirm label has value 'hello'" do
    @group.click_hello
    @group.label.should have_value /hello/i
  end
  
  #
  # Let's finish by calling the proxy's click_world button.
  #
  it "will click world button and then confirm label has value 'world'" do
    @group.click_world
    @group.label.should have_value /world/i
  end
  
end