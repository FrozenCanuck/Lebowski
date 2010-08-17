# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

#
# It may be that in your particular SproutCore application you had the need
# to create your own custom views in order to visualize data and interact
# with the view in a way specific to your needs. To test your custom view 
# within an application, you can create a proxy for it based on the view's
# type. This file demonstrates how to create a type proxy for a custom view.
#

module TestApp
  module Views
      
    #
    # At minimum, all view proxies must inherit from the Lebowski
    # framework's View proxy. The View proxy provides many of the 
    # core functionality in order interact with a SproutCore view. 
    # 
    # Your view proxy must also indicate what type of class it is 
    # representing. This is important so that the Lebowski framework 
    # can automtically detect the remote view's type and create the
    # right type of proxy instance for that view using the framework's 
    # proxy factory. To indicate what type the proxy is representing is
    # done with the representing_sc_class built in method.
    #
    # If your custom view inherits from something more specific then
    # the SC.View, then it is recommended that your proxy also try
    # reflect that same inheritence heirarchy. As an example, Let's
    # say you create a custom view that inherits from SC.ButtonView.
    # In such as case, instead of inheriting from the View proxy, you
    # should instead make your proxy inherit from the ButtonView
    # proxy.
    #
    # When creating a type proxy for a view, it is ideal that your 
    # proxy consist of an a programming interface that makes it easy 
    # for people to perform specific user operations and access 
    # information. 
    #
    class CustomRenderedView < Lebowski::Foundation::Views::View
      
      #
      # This view proxy is representing the view TestApp.CustomRenderedView
      # which you can find the code for in the application's 
      # custom_rendered.js file 
      #
      representing_sc_class 'TestApp.CustomRenderedView'
      
      #
      # The custom view is broken up into three main box regions:
      # main box 1, main box 2, and main box 3. Each box in the
      # view has its own unique properites. Therefore, we want to 
      # represent each box as its own object within this proxy
      #
      # We are sure to pass this object to each of the main
      # box instances so that they can access the proxy's
      # various methods
      #
      
      def main_box_1
        return MainBox1.new(self, '.main-box1')
      end

      def main_box_2
        return MainBox2.new(self, '.main-box2')
      end
      
      def main_box_3
        return MainBox3.new(self, '.main-box3')
      end     
	  end
      
    #
    # A class representing one of the Stooges displayed in
    # the view's main box 1
    #
    class Stooge
      def initialize(stooge)
        @name = stooge.text
        @url = stooge.attribute('href')
      end
      
      attr_reader :name, :url
    end

    #
    # A generic class that each of the specific main box classes
    # inherit from
    #
    class MainBox
      def initialize(parent, selector)
        @parent = parent
        @selector = selector
      end

      def classes
        cq = @parent.core_query(@selector)
        classes = cq[0].classes
        cq.done
        
        return classes
      end
    end
    
    #
    # Class representing the first main box. This box does not have
    # any user interactive properties. Instead the box just contains
    # a list of hyperlinks. Therefore we this class just provides a 
    # simple interface to acces those links.
    #
    class MainBox1 < MainBox
      def initialize(parent, selector)
        super(parent, selector)
        
        #
        # In order to access the actual DOM elements within the
        # custom view, we must access the given parent's core
        # query object. The core query object (CoreQuery) is what
        # allows us to actually access low-level DOM elements within
        # the browser. To use the core query, you simpley have to 
        # provide the object with a simplified CSS selector. 
        #
        # For more information on accepted CSS selectors, refer
        # to the SproutCore framework's core_query.js file.
        #
        cq = @parent.core_query(@selector + ' a')
      
        #
        # We access the DOM elements that make the CSS selector
        # via the core query's array accessor method.
        #
        @larry = Stooge.new(cq[0])
        @curly = Stooge.new(cq[1])
        @moe = Stooge.new(cq[2])
      
        @stooges = [@larry, @curly, @moe]
      
        #
        # When we are done using the core query object be sure
        # to call its done method.
        #
        cq.done
      end
         
      attr_reader :stooges, :larry, :curly, :moe
    end
    
    #
    # Class representing the view's second main box. The second box
    # contains a paragraph DOM element that a user can click on. By
    # clicking on the paragraph the view will detect it and change
    # the second box's background color between blue and purple.
    # Therefore we want this class's interface to make it easy to
    # click the paragraph and change the background color.  
    #
    class MainBox2 < MainBox
      
      #
      # Accesses the paragraph's text and returns it as the
      # box's title. 
      #
      def title
        
        #
        # Use the parent's core query object to access the 
        # paragraph DOM element via a CSS selector
        #
        cq = @parent.core_query(@selector + ' p')
        
        # 
        # We access that paragraph's text via the DOM element's
        # text property
        #
        title = cq[0].text
        
        #
        # Finished using the core query
        #
        cq.done          
        
        return title
      end
      
      #
      # Will click on the paragraph DOM element in order to change
      # the box's background color
      #
      def click_title
        cq = @parent.core_query(@selector + ' p')
        
        #
        # To click the DOM element we just have to invoke the click
        # method
        #
        cq[0].click
        
        cq.done
      end
      
      #
      # Used to check if the box's background color is purple
      #
      def is_purple?
        return true if classes.match(/active/)
        return false
      end
      
      #
      # Used to check if the box's background color is blue
      #
      def is_blue?
        return false if classes.match(/active/)
        return true
      end
    end
    
    #
    # Class representing the view's third main box. This box contains
    # two images that you can double click on to change the box's 
    # background color. In addition, you can also double click on the
    # box itself to change its background color.
    #
    class MainBox3 < MainBox
        
      #
      # Double click on the alert image within the box
      #
      def double_click_alert_image
        double_click_by_index(0)
      end
      
      #
      # Double click on the info image with the box
      #
      def double_click_info_image
        double_click_by_index(1)
      end
    
      #
      # Double click on the box itself
      #
      def double_click_box
        cq = @parent.core_query(@selector)
        elem = cq[0]
        elem.double_click
        cq.done
      end
    
      #
      # Used to check if the box's background color is black
      #
      def is_black?
        return true if classes.match(/black/)
        return false
      end
    
      #
      # Used to check if the box's background color is white
      #
      def is_white?
        return true if classes.match(/white/)
        return false
      end
    
      #
      # Used to check if the box's background color is red
      #
      def is_red?
        return false if classes.match(/black/) || classes.match(/white/)
        return true
      end
        
    private
        
      def double_click_by_index(index)
        cq = @parent.core_query(@selector + ' img')
        raise ArgumentError.new "Index out of range." if (index < 0) || (index >= cq.size)
        cq[index].double_click
        cq.done
      end
      
    end

  end
end
