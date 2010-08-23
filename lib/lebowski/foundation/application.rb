# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    
    #
    # Represents a SproutCore Application. This is a base class that is derived
    # by other classes. The class provides the common data and behavior that
    # all other classes representing an application must have.
    #
    class Application < Lebowski::Foundation::ProxyObject
      include Lebowski
      include Lebowski::Foundation
      include Lebowski::Foundation::Panes
      include Lebowski::Foundation::Mixins
      include Lebowski::Foundation::Mixins::KeyCheck
      
      attr_reader :app_context_manager
      attr_reader :parent_app
      
      def initialize(params)
        super()
        
        if params.nil?
          raise ArgumentError.new "must supply parameters to create application instance"
        end
        
        if not params.kind_of?(Hash)
          raise ArgumentError.new "must supply a hash containing parameters"
        end
        
        if not params[:parent_app].nil?
          @parent_app = params[:parent_app]
          @app_context_manager = @parent_app.app_context_manager
          @driver = @parent_app.driver
        end
      end
      
      def abs_path()
        return nil
      end
      
      def root_object(name, expected_type=nil)
        return self['$' + name, expected_type]
      end
      
      alias_method :framework, :root_object
      
      def main_pane(expected_type=nil)
        return self['$SC.RootResponder.responder.mainPane', expected_type]
      end
      
      def key_pane(expected_type=nil)
        return self['$SC.RootResponder.responder.keyPane', expected_type]
      end
      
      def responding_panes()
        if @responding_panes.nil?
          @responding_panes = ObjectArray.new self, '$SC.RootResponder.responder.panes'
        end
        return @responding_panes
      end
      
      def define_root_object(key, name, expected_type=nil)
        return define_path(key, '$' + name, expected_type)
      end
      
      alias_method :define_framework, :define_root_object
      
      def acquire_application_context(app_name)
        if app_name.nil?
          raise ArugmentError.new "app_name can not be nil"
        end
        app_context_manager.switch_application_context_to self, app_name
      end
      
      def do_aquire_application_context()
        # no-op
      end
      
      def has_current_application_context?()
        return app_context_manager.has_current_application_context?(self)
      end
      
      def exec_in_context(app_name, &block)
        if app_name.nil?
          raise ArgumentError.new "app_name can not be nil"
        end
        app_context_manager.exec_in_context self, app_name, &block
      end
      
      def exec_driver_in_context(&block)
        app_context_manager.exec_driver_in_context self, &block
      end
    
    end

    #
    # Used to represent a SproutCore application that is contained within
    # a web brower window
    #
    class WindowApplication < Application
      
      def initialize(params)
        super(params)
      end
      
      #
      # Moves the browser window
      #
      def move_to(x, y)
        exec_driver_in_context do |driver|
          @driver.sc_window_move_to(x,y)
        end
      end
      
      #      
      # Resizes the browser window
      #
      def resize_to(width, height)
        exec_driver_in_context do |driver|
          driver.sc_window_resize_to(width, height)
        end
      end
      
      #
      # Maximizes the browser window
      #
      def maximize() 
        exec_driver_in_context do |driver|
          driver.sc_window_maximize
        end
      end
      
    end
    
    #
    # Used to represent a SproutCore application that is contained within
    # a web browser window that was opened by another window
    #
    class OpenedWindowApplication < WindowApplication
      
      attr_reader :locator_type, :locator_value
      
      def initialize(params)
        super(params)
        
        if params[:parent_app].nil?
          raise ArugmentError.new "parent_app can not be nil"
        end
        
        @locator_type = params[:locator_type]
        @locator_value = params[:locator_value]
      end
      
      #
      # Used to check if this window is open
      #
      def is_opened?()
        return @driver.is_sc_opened_window?(locator_type, locator_value)
      end
    
      #
      # Closes the opened window if it is currently open
      #
      def close()
        return if (not is_opened?)
        driver.sc_close_opened_window locator_type, locator_value
        if has_current_application_context?
          parent_app.reset_application_context
        end
      end
      
      def do_acquire_application_context()
        @driver.sc_select_window(locator_type, locator_value)
      end
      
    end
    
    #
    # Used to represent a SproutCore application that is contained within
    # an IFrame.
    #
    class FrameApplication < Application
      
      attr_reader :locator
      
      def initialize(params)
        super(params)
        
        if params[:parent_app].nil?
          raise ArugmentError.new "parent_app can not be nil"
        end
        
        @locator = params[:locator]
      end
      
      def do_acquire_application_context()
        parents = []
        current_parent = self.parent_app
        while not current_parent.nil? do
          parents << current_parent
          current_parent = current_parent.parent_app
        end
        
        parents = parents.reverse
        
        parents.each do |parent|
          if parent.kind_of? FrameApplication
            @driver.select_frame parent.locator
          else
            parent.do_acquire_application_context
          end
        end
        
        @driver.select_frame(locator)
      end
      
    end
    
    #
    # This class represents a SproutCore-based main application. In order to interact with the
    # actual application you must create an instance of this class and start it. Once
    # started, you are then free to access any object or view that has been created by 
    # the application within the web browser.  
    #
    class MainApplication < WindowApplication
    
      SAFARI = '*safari'
      FIREFOX = '*firefox'
      CHROME = '*chrome'
      
      DEFAULT_BROWSER = FIREFOX
      DEFAULT_SELENIUM_SERVER_HOST = 'localhost'
      DEFAULT_SELENIUM_SERVER_PORT = 4444
      DEFAULT_APP_SERVER_HOST = 'localhost'
      DEFAULT_APP_SERVER_PORT = 4020
      DEFAULT_TIMEOUT_IN_SECONDS = 240
    
      attr_reader :app_name,
                  :app_root_path,
                  :host,
                  :port,
                  :base_url,
                  :session_id,
                  :browser
                  
      #
      # Creates an Application instance that will allow you to interact with a
      # SproutCore-based application.
      #
      # Initialization requires a hash input containing parameters to set up
      # the application instance. At minimum, the following are required
      #
      #   app_root_path  => The root URL path to the SproutCore-based application (e.g. /my_app)
      #   app_name       => The name of the application's root object (e.g. MyApp)
      #
      # In addition to the two required params, the following optional params can
      # also be supplied:
      #
      #   selenium_server_host => The name of the host the selenium server is running on (default is localhost)
      #   selenium_server_port => The port the selenium server is listening on (default is 4444)
      #   app_server_host      => The name of the server hosting the web application (defalt is localhost)
      #   app_server_port      => The port on the server to access the web application (default is 4020)
      #   browser              => The web browser to load the web application in to (default is SAFARI)
      #
      # Example:
      #
      #   Lebowski::Foundation::Application.new \
      #     :app_root_path => "/hello_world",
      #     :app_name => "HelloWorldApp"
      #
      def initialize(params)
        super(params)
        
        @host = get_selenium_server_host(params)
        @port = get_selenium_server_port(params)
        @browser = get_browser(params)
        
        @app_root_path = get_app_root_path(params)
        raise ArgumentError.new "Application root path is required - :app_root_path" if @app_root_path.nil?
        
        @app_name = get_app_name(params)
        raise ArgumentError.new "Application name is required - :app_name" if @app_name.nil?
        
        @rel_path = @app_name
        @timeout_in_seconds = get_timeout_in_second(params)
        @base_url = get_application_base_url(params)
        @session_id = get_session_id(params)
        
        @driver = Lebowski::Runtime::SproutCoreDriver.new \
          :host => @host, 
          :port => @port, 
          :browser => @browser, 
          :url => @base_url, 
          :timeout_in_second => @timeout_in_seconds
          
        @started = false 
        
        @app_context_manager = Support::ApplicationContextManager.new self
        @parent_app = nil
      end
    
      #
      # Responsible for starting the application. The application will create
      # an internal driver that is used to actually communicate with the 
      # selenium server. 
      #
      # You can optionally supply a block used to wait until some condition 
      # has been satisfied before going on and running the rest of your script. 
      # Example:
      #
      #   application.start do |it|
      #     it['appIsLoaded'] == true
      #   end
      #
      # If the condition does not become true before timing out then an exception
      # will be thrown. You can adjust the timeout like so,
      #
      #   application.start(20) do |it|
      #     it['appIsLoaded'] == true
      #   end
      #
      def start(timeout=nil, &block)
        return if started?
        
        begin
          if @session_id.nil? 
            @driver.start
          else 
            @driver.session_id = @session_id
          end
          
          @driver.set_application_name @app_name
        	@driver.open_sc_application @app_root_path, @timeout_in_seconds
        	@started = true
        rescue Exception => ex
          err_message = "Error connecting to selenium server: #{ex.message}\n"
          err_message << "Confirm that selenium server is running on #{@selenium_server_host}:#{@selenium_server_port}"
          raise Runtime::SeleniumServerError.new err_message
        end
        
        if block_given?
          begin
            wait_until(timeout, &block)
          rescue TimeoutError => toe
            err_message = "Unable to start application. Wait condition was not met before timeout. #{toe.message}"
            raise TimeoutError.new err_message
          end
        end
      end
      
      def end()
        return if (not started?)
        
        begin
          @driver.stop
          @started = false
        rescue Exception => ex
          err_message = "Error disconnecting from selenium server: #{ex.message}\n"
          err_message << "Confirm that selenium server is running on #{@selenium_server_host}:#{@selenium_server_port}"
          raise Runtime::SeleniumServerError.new err_message
        end
      end
      
      def started?()
        return @started
      end
      
      def reset_application_context()
        acquire_application_context app_name
      end
      
      def define_app_name(name)
        define_path name
      end
      
      def opened_windows()
        @opened_windows = Support::OpenedWindows.new(self) if @opened_windows.nil?
        return @opened_windows
      end
      
      def do_acquire_application_context()
        @driver.sc_select_main_window
      end
      
    private
    
      def get_selenium_client(params)
        return params[:driver]
      end
    
      def get_selenium_server_host(params)
        client = get_selenium_client(params) 
        return client.host if (not client.nil?)
        return DEFAULT_SELENIUM_SERVER_HOST if params[:selenium_server_host].nil?
        return params[:selenium_server_host]
      end
      
      def get_selenium_server_port(params)
        client = get_selenium_client(params) 
        return client.port if (not client.nil?)
        return DEFAULT_SELENIUM_SERVER_PORT if params[:selenium_server_port].nil?
        return params[:selenium_server_port].to_i
      end
      
      def get_app_server_host(params)
        return DEFAULT_APP_SERVER_HOST if params[:app_server_host].nil?
        return params[:app_server_host]
      end
      
      def get_app_server_port(params)
        return DEFAULT_APP_SERVER_PORT if params[:app_server_port].nil?
        return params[:app_server_port].to_i
      end
      
      def get_application_base_url(params)
        client = get_selenium_client(params) 
        return client.browser_url if (not client.nil?)
        return "http://#{get_app_server_host(params)}:#{get_app_server_port(params)}"
      end
      
      def get_session_id(params)
        client = get_selenium_client(params) 
        return client.session_id if (not client.nil?)
        return nil
      end
      
      def get_browser(params)
        client = get_selenium_client(params) 
        return client.browser_string if (not client.nil?)
        
        browser = params[:browser]
        
        return browser if browser.kind_of?(String)
        
        case (browser)
        when :firefox
          return FIREFOX
        when :safari
          return SAFARI
        when :chrome
          return CHROME
        else
          return DEFAULT_BROWSER
        end
      end
      
      def get_app_root_path(params)
        return params[:app_root_path]
      end
      
      def get_app_name(params)
        return params[:app_name]
      end
      
      def get_timeout_in_second(params)
        return DEFAULT_TIMEOUT_IN_SECONDS if params[:timeout_in_seconds].nil?
        return params[:timeout_in_seconds].to_i
      end
    
    end
    
    module Support
      
      #
      # Application context manager is used to handle the switching between SproutCore
      # applications and keeping track of what application currently posses the current
      # context that all operations act upon
      #
      class ApplicationContextManager
        include Lebowski::Foundation
        
        attr_reader :main_app

        def initialize(main_app)
          @main_app = main_app
          @driver = main_app.driver
          @current_application_context = { :app => main_app, :app_name => main_app.app_name }
        end

        def switch_application_context_to(app, app_name=nil)  
          if not app.kind_of? Application
            raise ArgumentInvalidTypeError.new "app", app, "class < Application"
          end
          
          if not app.__eql? main_app 
            if main_app.path_defined? app_name
              root = main_app.defined_path app_name
              app.root_defined_path_part = root
            else
              app.root_defined_path_part = main_app.root_defined_path_part
            end
          end
          
          app.do_acquire_application_context

          @driver.update_sc_application_context(app_name) if not app_name.nil?
          @current_application_context = { :app => app, :app_name => app_name }
        end 

        def has_current_application_context?(app)
          return app.__eql?(@current_application_context[:app])
        end

        def exec_in_context(app, app_name=nil, &block)
          previous_app_context = @current_application_context.clone
          switch_application_context_to app, app_name
          yield app
          switch_application_context_to previous_app_context[:app], previous_app_context[:app_name]
        end

        def exec_driver_in_context(app, &block)
          previous_app_context = nil
          if not has_current_application_context?(app)
            previous_app_context = @current_application_context.clone
            switch_application_context_to app
          end

          yield @driver

          if not previous_app_context.nil?
            switch_application_context_to previous_app_context[:app], previous_app_context[:app_name]
          end
        end

      end

      class OpenedWindows

        def initialize(parent_app)
          @parent_app = parent_app
          @driver = parent_app.driver
        end

        def window_with_location?(value)
          return @driver.is_sc_opened_window?(:location, value)
        end

        def window_with_name?(value)
          return @driver.is_sc_opened_window?(:name, value)
        end

        def window_with_title?(value)
          return @driver.is_sc_opened_window?(:title, value)
        end

        def find_by_location(value)
          return find_opened_window(:location, value)
        end

        def find_by_name(value)
          return find_opened_window(:name, value)
        end

        def find_by_title(value)
          return find_opened_window(:title, value)
        end

      private

        def find_opened_window(locator_type, locator_value)
          if @driver.is_sc_opened_window?(locator_type, locator_value)
            return OpenedWindowApplication.new({
              :locator_type => locator_type, 
              :locator_value => locator_value, 
              :parent_app => @parent_app
            }) 
          end
          return nil
        end

      end
      
    end
    
  end
end