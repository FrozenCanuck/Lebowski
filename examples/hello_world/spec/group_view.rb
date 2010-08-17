# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

#
# This is a toy example of how to make a path proxy that you can use in your
# scripts that use the Lebowski framework.
#

module HelloWorldApp
  module Views
    
    #
    # To make a path proxy for a view, the proxy needs to, at minimum, inherit from 
    # the Lebowski framework's View proxy. 
    #
    class GroupView < Lebowski::Foundation::Views::View
      
      #
      # Used to access the group view's child view label
      #
      def label()
        return self['label']
      end
      
      #
      # Used to access the group view's child view helloWorld
      #
      def hello_button()
        return self['helloButton']
      end
      
      #
      # Used to access the group view's child view worldButton
      #
      def world_button()
        return self['worldButton']
      end
      
      #
      # Used to click on the hello button
      #
      def click_hello()
        hello_button.click
      end
      
      #
      # Used to click on the world button
      #
      def click_world()
        world_button.click
      end
      
    end
    
  end
end