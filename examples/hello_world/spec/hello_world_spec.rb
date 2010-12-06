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

#
# If you're new to the Lebowski framework and want to know how
# to run a test script with the framework, you've come to the right
# place. 
#
# You can follow along with the script by reading the comments
# below. Be sure to have everything configured correctly by going over
# the frameworks README file, if you haven't alredy done so.
#
# You will need to have both the selenium server started as well
# as the hello world example application started using sc-server.
# You can take a look at the application before running this script
# by opening up a browser and going to the following URL:
#
#   http://localhost:4020/hello_world
#
# You should see a green label and two buttons. Remember: This is a
# hello world example :-). 
#
# To run this script, you can execute the following:
#
#   lebowski-spec hello_world_spec.rb
#

#
# Start by creating an instance of our application. At minimum, you
# must supply the application's URL root path and the application's
# root object name. You can supply other optional parameters, such as
# what browser you wish to use to load the application into.
# 
# For this hello world application, you can find the application root
# object in the core.js file under the app/apps/hello_world folder. 
#
App = MainApplication.new \
        :app_root_path => "/hello_world", 
        :app_name => "HelloWorldApp",
        :browser => :firefox # optional parameter. Firefox is the default browser

#
# Now that we have the application created, we then have to start it by
# calling the application's start method. This will open up two browsers. 
# One browser is the command console and the other browser is where the 
# application is loaded into. 
#
# (Note: If you happen to only see the command console but not the window 
# showing the SC application, then it may be the case that the browser you 
# are using is set to not allow pop-up windows. Be sure that you browser
# is configured to allow pop-up windows or else your Lebowski scripts will
# fail.)
#
# At minimum, the framework will not continue until it can detect both
# the SproutCore framework and the application's root object. However, 
# for more complex applications, loading the application to a proper
# start state might take some time. In such cases, we want to wait
# until everything in the application is fully loaded and set up
# correctly. We can perform such a waiting action by optionally supplying 
# the application's start method with a wait block. 
#
# For the hello world example app, we do not want to continue with the 
# script until the application's isLoaded variable is equal to true. If
# the condition is not met before a timeout is met then an exception will
# be thrown. The default timeout is 10 seconds. We can alter the timeout
# by supplying a timeout value, like so:
#
#   App.start(20) do |app|
#     ...
#   end
#
# Outside of the start method, you can also call the application object's
# wait_until method to wait for some condition to be met, like so:
#
#   App.wait_until do |app|
#     ...
#   end
#
# wait_until is what start actually calls when provided a block. As well,
# the wait_until methods is something that can be called on any proxy
# object.
#
App.start do |app|
  app['isLoaded'] == true
end

#
# After starting the application, you can optionally move and resize the
# browser window that your SproutCore application has been loaded into. 
# If you'd like to instead just maximize the the browser to take up the
# entire screen you can call application object's maximize method, like so:
#
#   App.maximize
#
# If you do not wish to move or resize the browser window then the browser
# will be positioned and sized to defaults determined by the Selenium framework.
#
App.move_to 1, 1 # Have a slight offset for Firefox so that the window will actually be moved
App.resize_to 1024, 768 

#
# Because SproutCore property paths can be long when trying to access
# specific views, we make a short-cut by defining symbolic paths for a 
# specific path on the application object. Note that a path must point to 
# either a SprouCore object or a plain-old JavaScript hash object. You
# will get an exception if the path does not point to either one. 
#
# Here we define 'group' as the symbolic path for the path
# 'mainPage.mainPane.groupView'
#
# Optionally, you can provide the expected type for the given path.
# In this case we want to confirm that the path points to an object
# that is of type SC.View represented by the Lebowski frameworks 
# View proxy.
#
App.define_path 'group', 'mainPage.mainPane.groupView', View

#
# For this particular test script we are making use of the RSpec framework, 
# so we first need to describe the thing we are testing. In this case,
# we are just describing the hello world test.
#
describe "Hello World Test" do
  
  #
  # For each example in our test (represented by the use of "it", where 
  # "it" is the thing that has been described) we want to access the label 
  # and two button views. We can do this easily using our application object 
  # and the 'group' path we defined earlier in the script. The framework will 
  # automtically unravel the path like so:
  # 
  #   group.label ==> mainPage.mainPane.groupView.label
  #
  # You can optionally pass in the expected type to assure the given
  # path references the view/object you expect it to be, which we
  # do for both of the buttons using the Lebowski framework's
  # ButtonView proxy. If you rather not use the proxy you can also
  # provide the string name of the type, such as "SC.ButtonView".
  #
  # Do you always have to access a view through property paths?
  # In short, no. If a view has a layer ID assigned to it then you can
  # optionally access the view via the layer Id. 
  #
  # If you look at the application's main_page.js file you'll see that 
  # the label and two buttons all have unique layer IDs assigned them. 
  # Therefore we can access a view like so:
  #
  #   @label = App['#label']
  #
  # Just remember to include a # at the begining of the view's layer ID.  
  #
  before(:all) do    
    @label = App['group.label', 'SC.LabelView']
    @hello_button = App['group.helloButton', ButtonView]
    @world_button = App['#world-button', ButtonView] # Using the view's layer ID 
  end
  
  #
  # Our first test is to confirm that the label does indeed have the
  # caption "Click a button". We can do this by accessing the label
  # view's value property. Here we are making use of the Lebowski
  # framework's RSpec extensions. If you were to use RSpec normally the
  # statement would be something like the following:
  #
  #   @label.value.should eql 'click a button'
  #
  # Thanks alright, but we can make it more readable using the Lebowski
  # RSpec extensions in order to have the following:
  #
  #   @label.should have_value 'click a button'
  #
  # Or, if you prefer to use Ruby's regular expression language feature, you
  # can alternatively do the following:
  #
  #   @label.should have_value /click a button/i
  #
  # Note that the use of the Lebowski framework's RSpec extensions is
  # completely optional. If you like the traditional way of using RSpec
  # to do your testing, you're more than free to do so. Also, you don't
  # even have to use RSpec to run Lebowski scripts. You can use
  # whatever Ruby testing framework you like.
  #
  it "will check that label has an initial value 'click a button'" do
    @label.should have_value /click a button/i # Using the Lebowski RSpec extensions
  end
  
  #
  # Now let's check the hello button view and confirm that its title
  # does have the value "Hello". We check using Ruby's standard
  # regular expression feature. 
  #
  # What if you just want to get an object's value directly? How do
  # you do that? It's easy! You can use a relative property path,
  # like so:
  #
  #   value = @hello_button['title']
  #
  # or you can access the property as a normal object method:
  #
  #   value = @hello_world.title
  #
  # They work the same way. However, if you're trying to access a
  # property the is deeply nested within other child objects then
  # it is more efficient to use the property path approach:
  #
  #   value = @some_object['path.to.some.value.deeply.nested']
  #
  # Note that if some part of the path is nil or undefined within
  # the browser then nil or :undefined will be returned, respectively. 
  #
  it "will check that hello button has title 'hello'" do
    @hello_button.should have_title /hello/i
  end
  
  #
  # Let's now check the title of the world button. We do the same
  # thing like we did before with the hello button. 
  #
  # How does the Lebowski framework know what type of value to return? The
  # framework checks the value's type implicitely and gives you back the right 
  # type. However, if you really want to make sure you get back the right
  # type you can always do the following:
  #
  #   value = @some_object['path.to.value', <optional expected type>]
  #
  # If the type you expect does not derive from a SproutCore object, you can
  # use symbols such as :object, :number, :string, :boolean, :array and so on.
  #
  it "will check that world button has title 'world'" do
    @world_button.should have_title /world/i
  end
  
  #
  # Great. Now that we've confirmed some of the properties of our views, let's
  # actually get down to business and interact with the buttons. It's pretty
  # easy. 
  #
  # To click on a button (or any view for that matter), just call the
  # view's click method. The framework will do all the necessary work to
  # correctly perform a click action in SproutCore. 
  #
  # All of the Lebowski framework's view proxies have a standard set of common
  # user actions, such as typing keys, right clicking, and moving the mouse.
  # Even dragging and dropping views can be done with little work!
  #
  it "will click hello button and then confirm label has value 'hello'" do
    @hello_button.click
    @label.should have_value /hello/i
  end
  
  #
  # Let's finish our test by clicking on the world button and confirming that
  # the label's value has been updated to be "World".
  #
  # Granted this script is pretty basic, but it already gets you started with
  # how to use the Lebowski framework to test your SproutCore application.
  #
  # For a slightly more advanced use of the Lebowski framework, check out the
  # second hello world spec (hello_world_2_spec.rb)
  #
  it "will click world button and then confirm label has value 'world'" do
    @world_button.click
    @label.should have_value /world/i
  end
  
end