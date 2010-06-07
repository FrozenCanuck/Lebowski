# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    
    #
    # This class represents a SproutCore-based application. In order to interact with the
    # actual application you must create an instance of this class and start it. Once
    # started, you are then free to access any object or view that has been created by 
    # the application within the web browser.  
    #
    class Application < Lebowski::Foundation::SCObject
      include Lebowski
      include Lebowski::Foundation
      include Lebowski::Foundation::Panes
      include Lebowski::Foundation::Mixins::KeyCheck
    
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
                  :browser,
                  :app_is_loaded_flag
                  
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
        super()
        
        if params.nil?
          raise ArgumentError.new "must supply parameters to create application instance"
        end
        
        if not params.kind_of?(Hash)
          raise ArgumentError.new "must supply a hash containing parameters"
        end
        
        @host = get_selenium_server_host(params)
        @port = get_selenium_server_port(params)
        @browser = get_browser(params)
        
        @app_root_path = get_app_root_path(params)
        raise ArgumentError.new "Application root path is required - :app_root_path" if @app_root_path.nil?
        
        @app_name = get_app_name(params)
        raise ArgumentError.new "Application name is required - :app_name" if @app_name.nil?
        
        @rel_path = @app_name
        @app_is_loaded_flag = get_app_is_loaded_flag(params)
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
      
      def window()
        @window = Window.new(@driver) if @window.nil?
        return @window
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
        return define(key, '$' + name, expected_type)
      end
      
      alias_method :define_framework, :define_root_object
      
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
        case (browser)
        when :firefox
          return FIREFOX
        when :safari
          return SAFARI
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
      
      def get_app_is_loaded_flag(params)
        return params[:app_is_loaded_flag] 
      end
      
      def get_timeout_in_second(params)
        return DEFAULT_TIMEOUT_IN_SECONDS if params[:timeout_in_seconds].nil?
        return params[:timeout_in_seconds].to_i
      end
    
    end
    
    #
    # Represents the browser window the application has been loaded into
    #
    class Window
      
      def initialize(driver)
        @driver = driver
      end
      
      #
      # Moves the browser window
      #
      def move_to(x, y)
        @driver.sc_window_move_to(x,y)
      end
      
      #      
      # Resizes the browser window
      #
      def resize_to(width, height)
        @driver.sc_window_resize_to(width, height)
      end
      
      #
      # Maximizes the browser window
      #
      def maximize() 
        @driver.sc_window_maximize
      end
      
    end
    
  end
end