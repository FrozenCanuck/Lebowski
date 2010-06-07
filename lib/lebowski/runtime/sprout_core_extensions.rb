module Lebowski
  module Runtime
    
    module SproutCoreExtensions
      include Lebowski
      
      HTTP_HEADERS = { 'Content-Type' => 'application/x-www-form-urlencoded; charset=utf-8' }
            
      REMOTE_CONTROL_COMMAND_TIMEOUT = /^timed out after/i
      
      # SC Application Setup Selenium Calls
      
      def set_application_name(name)
        __remote_control_command("setScApplicationName", [name,])
      end
      
      def initialize_sc_selenium_extension(timeout)
        __remote_control_command("initializeScSeleniumExtension", [timeout,])
      end
      
      def open_sc_application(app_root_path, timeout=nil) 
        __remote_control_command("openScApplication", [app_root_path, timeout])
      end
      
      # SC Object Foundation Selenium Calls
      
      def get_sc_guid(scpath)
        return __string_command("getScGuid", [scpath])
      end
      
      def get_sc_object_class_name(scpath)
        return __string_command("getScObjectClassName", [scpath])
      end
      
      def is_sc_object_kind_of_class(scpath, klass)
        return __boolean_command("isScObjectKindOfClass", [scpath, klass])
      end

      def get_sc_type_of(scpath)
        return __string_command("getScTypeOf", [scpath])
      end
      
      def get_sc_type_of_array_content(scpath)
        return __string_command("getScTypeOfArrayContent", [scpath])
      end
      
      def get_sc_object_class_names(scpath)
        return __string_array_command("getScObjectClassNames", [scpath])
      end
      
      # SC Object Property Selenium Calls
      
      def get_sc_path_string_value(scpath)
        return __string_command("getScPropertyValue", [scpath])
      end
      
      def get_sc_path_number_value(scpath)
        return __number_command("getScPropertyValue", [scpath])
      end
      
      def get_sc_path_boolean_value(scpath)
        return __boolean_command("getScPropertyValue", [scpath])
      end
      
      def get_sc_path_string_array_value(scpath)
        return __string_array_command("getScPropertyValue", [scpath])
      end
      
      def get_sc_path_number_array_value(scpath)
        return __number_array_command("getScPropertyValue", [scpath])
      end
      
      def get_sc_path_boolean_array_value(scpath)
        return __boolean_array_command("getScPropertyValue", [scpath])
      end
      
      def get_sc_property_value(scpath, property)
        return get_sc_property_string_value(scpath, property)
      end
      
      def get_sc_property_string_value(scpath, property)
        full_path = "#{scpath}.#{property}"
        return __string_command("getScPropertyValue", [full_path,])
      end
      
      def get_sc_property_boolean_value(scpath, property)
        full_path = "#{scpath}.#{property}"
        return __boolean_command("getScPropertyValue", [full_path,])
      end
      
      def get_sc_property_number_value(scpath, property)
        full_path = "#{scpath}.#{property}"
        return __number_command("getScPropertyValue", [full_path,])
      end
      
      def get_sc_property_array_value(scpath, property)
        return get_sc_property_string_array_value(scpath, property)
      end
      
      def get_sc_property_string_array_value(scpath, property)
        full_path = "#{scpath}.#{property}"
        return __string_array_command("getScPropertyValue", [full_path,])
      end
      
      def get_sc_property_number_array_value(scpath, property)
        full_path = "#{scpath}.#{property}"
        return __number_array_command("getScPropertyValue", [full_path,])
      end
      
      def get_sc_property_boolean_array_value(scpath, property)
        full_path = "#{scpath}.#{property}"
        return __boolean_array_command("getScPropertyValue", [full_path,])
      end
      
      # SC View Object Foundation Selenium Calls
      
      def get_sc_view_layer(scpath)
        return string_command("getScViewLayer", [scpath, ])
      end
      
      # @return {Lebowski::Rect}
      def get_sc_view_frame(scpath)
        value = __number_array_command("getScViewFrame", [scpath])
        return nil if value.nil?
        return Rect.new(value[0], value[1], value[2], value[3])
      end
      
      # @return {Lebowski::Coords}
      def get_sc_element_window_position(type, *params)
        value = __number_array_command("getScElementWindowPosition", [__locator(type, *params)])
        return nil if value.nil?
        return Coords.new(value[0], value[1])
      end
      
      def get_sc_view_child_view_count(scpath)
        full_path = "#{scpath}.childViews.length"
        return __number_command("getScPropertyValue", [full_path, ])
      end
      
      # SC View Object Event Selenium Calls
      
      def sc_type(type, text, *params)
        __remote_control_command("type", [__locator(type, *params), text, ])
      end
      
      def sc_select(type, optionLocator, *params)
        __remote_control_command("select", [__locator(type, *params), optionLocator, ])
      end
      
      def sc_mouse_move(type, *params)
        __remote_control_command("mouseMove", [__locator(type, *params),])
      end
      
      alias_method :sc_mouse_enter, :sc_mouse_move
      alias_method :sc_mouse_exit, :sc_mouse_move
      
      def sc_mouse_move_at(type, x, y, *params)
        coords = "#{x},#{y}"
        __remote_control_command("mouseMoveAt", [__locator(type, *params), coords])
      end
      
      def sc_mouse_down(type, *params)
        __remote_control_command("scMouseDown", [__locator(type, *params),])
      end
      
      def sc_mouse_up(type, *params)
        __remote_control_command("scMouseUp", [__locator(type, *params), ])
      end
      
      def sc_mouse_down_at(type, x, y, *params)
        coords = "#{x},#{y}"
        __remote_control_command("mouseDownAt", [__locator(type, *params), coords])
      end
    
      def sc_mouse_up_at(type, x, y, *params)
        coords = "#{x},#{y}"
        __remote_control_command("mouseUpAt", [__locator(type, *params), coords])
      end
            
      def sc_right_mouse_down(type, *params)
        __remote_control_command("scMouseDownRight", [__locator(type, *params), ])
      end
      
      def sc_right_mouse_up(type, *params)
        __remote_control_command("scMouseUpRight", [__locator(type, *params), ])
      end
      
      def sc_right_mouse_down_at(type, x, y, *params)
        coords = "#{x},#{y}"
        __remote_control_command("mouseDownRightAt", [__locator(type, *params), coords])
      end
      
      def sc_right_mouse_up_at(type, x, y, *params)
        coords = "#{x},#{y}"
        __remote_control_command("mouseUpRightAt", [__locator(type, *params), coords])
      end
      
      def sc_basic_click(type, *params)
        __remote_control_command("click", [__locator(type, *params), ])
      end
      
      def sc_click(type, *params)
        __remote_control_command("scClick", [__locator(type, *params), ])
      end
      
      def sc_right_click(type, *params)
        __remote_control_command("scRightClick", [__locator(type, *params), ])
      end
      
      def sc_double_click(type, *params)
        __remote_control_command("scDoubleClick", [__locator(type, *params), ])
      end
      
      def sc_focus(type, *params)
        __remote_control_command("focus", [__locator(type, *params), ])
      end
      
      def sc_key_down(type, key, *params)
        if key == :meta_key
          meta_key_down
        elsif key == :alt_key
          alt_key_down
        elsif key == :ctrl_key
          control_key_down
        elsif key == :shift_key
          shift_key_down
        elsif key.kind_of? Symbol
          __remote_control_command("scFunctionKeyDown", [__locator(type, *params), key.to_s])
        else
          __remote_control_command("scKeyDown", [__locator(type, *params), key])
        end
        __register_key_as_down(key)
      end
      
      def sc_key_up(type, key, *params)
        if key == :meta_key
          meta_key_up
        elsif key == :alt_key
          alt_key_up
        elsif key == :ctrl_key
          control_key_up
        elsif key == :shift_key
          shift_key_up
        elsif key.kind_of? Symbol
          __remote_control_command("scFunctionKeyUp", [__locator(type, *params), key.to_s])
        else
          __remote_control_command("scKeyUp", [__locator(type, *params), key])
        end
        __register_key_as_up(key)
      end
      
      def key_down?(key)
        return __key_pressed?(key)
      end
      
      def key_up?(key)
        return (not __key_pressed?(key))
      end
      
      def sc_type_key(type, key, *params)
        if key.kind_of? Symbol
          __remote_control_command("scTypeFunctionKey", [__locator(type, *params), key.to_s, ])
        else
          __remote_control_command("scTypeKey", [__locator(type, *params), key, ])
        end
      end
      
      def sc_view_scroll_to_visible(scpath)
        __remote_control_command("scViewScrollToVisible", [scpath])
      end
      
      def sc_wait_until(root_scpath, join, conditions, timeout=nil)
        params = {
          :rootPath => root_scpath,
          :join => join,
          :conditions => conditions,
          :timeout => timeout
        }
        
        encoded_params = ObjectEncoder.encode_hash(params)
        
        __remote_control_command("scWaitUntil", [encoded_params])
      end
      
      # SC Core Query Selenium Calls
      
      def sc_core_query_done(handle)
        __remote_control_command("scCoreQueryDone", [handle,])
      end
      
      def get_sc_core_query(scpath, selector)
        return __number_command("getScCoreQuery", [scpath, selector])
      end
      
      def get_sc_core_query_size(handle)
        return __number_command("getScCoreQuerySize", [handle,])
      end
      
      def get_sc_core_query_element_classes(handle, elemIndex)
        return __string_command("getScCoreQueryElementClasses", [handle, elemIndex,])
      end
      
      def get_sc_core_query_element_html(handle, elemIndex)
        return __string_command("getScCoreQueryElementHTML", [handle, elemIndex,])
      end
      
      def get_sc_core_query_element_attribute(handle, elemIndex, attribute)
        return __string_command("getScCoreQueryElementAttribute", [handle, "#{elemIndex}:#{attribute}",])
      end
      
      def get_sc_core_query_element_text(handle, elemIndex)
        return __string_command("getScCoreQueryElementText", [handle, elemIndex,])
      end
      
      def get_sc_core_query_element_tag(handle, elemIndex)
        return __string_command("getScCoreQueryElementTag", [handle, elemIndex,])
      end
      
      # SC Collection View Selenium Calls
      
      def get_sc_collection_view_content_group_indexes(scpath)
        return __number_array_command("getScCollectionViewContentGroupIndexes", [scpath,])
      end
      
      def get_sc_collection_view_content_selected_indexes(scpath)
        return __number_array_command("getScCollectionViewContentSelectedIndexes", [scpath,])
      end
      
      def get_sc_collection_view_content_now_showing_indexes(scpath)
        return __number_array_command("getScCollectionViewContentNowShowingIndexes", [scpath,])
      end
      
      def get_sc_collection_view_content_is_selected(scpath, index)
        return __boolean_command("getScCollectionViewContentIsSelected", [scpath, index,])
      end

      def get_sc_collection_view_content_is_group(scpath, index)
        return __boolean_command("getScCollectionViewContentIsGroup", [scpath, index,])
      end
      
      def get_sc_collection_view_content_disclosure_state(scpath, index)
        return __number_command("getScCollectionViewContentDisclosureState", [scpath, index,])
      end
      
      def get_sc_collection_view_content_outline_level(scpath, index)
        return __number_command("getScCollectionViewContentOutlineLevel", [scpath, index,])
      end
      
      # Selenium User Extension Utility Function Selenium Calls
      
      def get_sc_object_array_index_lookup(scpath, lookup_params)
        encoded_params = ObjectEncoder.encode_hash(lookup_params)
        return __number_array_command("getScObjectArrayIndexLookup", [scpath, encoded_params])
      end
      
      def get_sc_selection_set_indexes(scpath)
        return __number_array_command("getScSelectSetIndexes", [scpath, ])
      end

      def get_sc_localized_string(str)
        if @localized_string_cache.nil?
          @localized_string_cache = {}
        end

        if @localized_string_cache.has_key?(str)
          return @localized_string_cache[str]
        else
          val = __string_command("getScLocalizedString", [str, ])
          @localized_string_cache[str] = val
          return val
        end
      end
      
      def sc_window_move_to(x, y)
        __remote_control_command("scWindowMoveTo", [x, y])
      end
      
      def sc_window_resize_to(width, height)
        __remote_control_command("scWindowResizeTo", [width, height])
      end
      
      def sc_window_maximize()
        __remote_control_command("scWindowMaximize")
      end
      
      # Selenium User Extensions Testing/Debugging Calls   
    
      def __sc_test_computing_property_path(key, path)
        __remote_control_command("scTestComputePropertyPath", [key.to_s, path,])
      end
      
      def __sc_test_sending_encoded_hash(key, hash)
        str = ObjectEncoder.encode_hash(hash)
        __remote_control_command("scTestDecodingEncodedHash", [key.to_s, str,])
      end
      
      def __sc_test_sending_encoded_array(key, array)
        str = ObjectEncoder.encode_array(array)
        __remote_control_command("scTestDecodingEncodedArray", [key.to_s, str,])
      end
      
      def __sc_test_object_array_lookup(key, path, lookup)
        params = ObjectEncoder.encode_hash({
          :key => key.to_s,
          :path => path,
          :lookup => lookup,
        })
        __remote_control_command("scTestObjectArrayLookup", [params,])
      end
      
    protected
      
      #
      # @private
      #
      # Will convert the given type and parameters into a locator recognized by Selenium
      #
      def __locator(type, *params)
        loc = ""
        case type
        when :view 
          loc = "scPath=#{params[0]}"
        when :core_query_element 
          loc = "scCoreQuery=#{params[0]}:#{params[1]}"
        else 
          loc = "scPath=#{params[0]}"
        end
        return loc
      end
      
      def __remote_control_command(verb, args=[])
        if session_id.nil?
          raise RemoteControlError.new "Unable to execute remote control command: A session ID is required"
        end
        
        timeout(default_timeout_in_seconds) do
          data = http_request_for(verb, args)
          status, response = __http_post(data)
          
          if status != "OK"
            if response =~ REMOTE_CONTROL_COMMAND_TIMEOUT
              raise RemoteControlCommandTimeoutError, response
            else
              called_from = caller.detect{|line| line !~ /(selenium-client|vendor|usr\/lib\/ruby|\(eval\))/i}
              err_message = "Received error from server while trying to execute command:\n"
              err_message << "requested:\n"
              err_message << "\t" + CGI::unescape(data.split('&').join("\n\t")) + "\n"
              err_message << "received:\n"
              err_message << "\t#{response}\n"
              raise RemoteControlCommandExecutionError, err_message
            end
          end
                    
          return response[3..-1] # strip "OK," from response
        end
      end
      
      def __http_post(data)
        http = Net::HTTP.new(@host, @port)
        http.open_timeout = default_timeout_in_seconds
        http.read_timeout = default_timeout_in_seconds
        begin
          response = http.post('/selenium-server/driver/', data, HTTP_HEADERS)
        rescue Exception => ex
          err_message = "Error communicating with selenium server: #{ex.message}\n"
          err_message << "Confirm that selenium server is running"
          raise SeleniumServerError.new err_message
        end
        [ response.body[0..1], response.body ]
      end
      
      def __string_command(verb, args=[])
        __remote_control_command(verb, args)
      end
      
      #
      # @private
      #
      # Use this method instead of the number_command method. The number_command method
      # in the selenium-client does not actually convert a string into an int where this
      # method will
      #
      def __number_command(verb, args)
        return __string_command(verb, args).to_i
      end
      
      #
      # @private
      #
      # User this method instead of the boolean_command method. This method will handle
      # cases when the returned value from the server is neither "true" not "false". In
      # such a case the raw value is returned. The reflects cases when a returned value
      # is typically expected to be a true or false boolean value, but in certain
      # situations can be a none boolean value.
      #
      def __boolean_command(verb, args)
        val = __string_command(verb, args)
        return true if (val == "true")
        return false if (val == "false")
        return val
      end
      
      #
      # @private
      #
      # Use this method instead of the string_array_command method. The
      # string_array_command method does not handle the case when the
      # returned value from the server is null where as this method will
      #
      def __string_array_command(verb, args)
        csv = string_command(verb, args)
        return [] if csv.nil? or csv.empty?
        token = ""
        tokens = []
        escape = false
        csv.split(//).each do |letter|
          if escape
            token += letter
            escape = false
            next
          end
          case letter
            when '\\'
              escape = true
            when ','
              tokens << token
              token = ""
            else
              token += letter
          end
        end
        tokens << token
        return tokens
      end
      
      #
      # @private
      #
      # Use this method instead of the number_array_command method
      #
      def __number_array_command(verb, args)
        val = __string_array_command(verb, args)
        val.collect! { |x| x.to_i }
        return val 
      end
      
      #
      # @private
      #
      # Use this method instead of the boolean_array_command method. This
      # method will handle cases when the value is neither true nor false. In
      # such a case the raw value is returned. In done in cases when a return
      # value is typicallys a true or false boolean value, but in particular
      # situations can be a none boolean value.
      #
      def __boolean_array_command(verb, args)
        val = __string_array_command(verb, args)
        val.collect! do |x|
          if ("true" == x)
            true
          elsif ("false" == x)
            false
          else 
            x
          end
        end
        return val 
      end
      
      #
      # @private
      #
      def __pressed_keys
        @pressed_keys = {} if @pressed_keys.nil?
        return @pressed_keys  
      end
      
      #
      # @private
      #
      def __register_key_as_down(key)
        keys = __pressed_keys
        keys[key] = key
      end
      
      #
      # @private
      #
      def __register_key_as_up(key)
        keys = __pressed_keys
        keys.delete key
      end
      
      def __key_pressed?(key)
        return _pressed_keys.has_key?(key)
      end
      
    end
  end
end