# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski
  module Foundation
    
    #
    # ProxyObject is the root object for all objects that are to proxy an object within a 
    # web brower. This provides all of the core functionality allowing you to communicate with
    # a remote object and access other remote objects through the use of relative property paths. 
    #
    # In the case where you have created a custom SproutCore object and want to have a proxy for it
    # then your proxy must inherit from the SCObject class that inherits this class.
    #
    class ProxyObject
      
      include Lebowski::Foundation
      include Lebowski::Foundation::Mixins::WaitActions
      include Lebowski::Foundation::Mixins::DefinePathsSupport
      
      attr_reader :parent,   # The parent object of this object. Must derive from Lebowski::Foundation::ProxyObject
                  :rel_path, # The relative path to the remote object using SC property path notation
                  :driver    # The SproutCore driver that is used to actually communicate with the remote object
      
      attr_accessor :name # A name for this object. Useful for printing out statements and debugging
      
      #
      # Creates a new proxy object instance. 
      #
      # Try to refrain from overriding this method. Instead, if you wish to perform some operations
      # during the time an object is being initialized, override the init_ext method
      #
      # @param parent {Object} parent object of this object. Must inherit from Lebowski::Foundation::ProxyObject
      # @param rel_path {String} a relative path to the remote object (e.g. 'foo', 'foo.bar')
      # @param driver {Object} used to remotely communicate with the remote object.
      #
      # @see #init_ext
      #
      def initialize(parent=nil, rel_path=nil, driver=nil)
        
        if not init_expected_parent_type.nil?
          if not parent.kind_of? init_expected_parent_type
            raise ArgumentInvalidTypeError.new "parent", parent, init_expected_parent_type
          end
        end
        
        @parent = parent
        @rel_path = rel_path
        @driver = driver
        @guid = nil
        @cached_proxy_objects = {}
        @defined_proxies = {}
        @name = ""
        
        init_ext()
      end
      
      #
      # Override this method for any initialization procedures during the time the object is being 
      # inialized 
      #
      # @see #initialize
      #
      def init_ext()
      
      end
      
      #
      # Use when you wish to represent a proxied object as something else other then the proxy
      # returned by this object when accessed with a relative path using []. This is useful
      # in cases where you have a view that is simply composed of other views but itself is not
      # custom view inherited from SC.View. As an example, it is common in SproutCore to 
      # create a complex view that lives only within an SC.Page, like so:
      #
      #   MyApp.mainPage = SC.Page.create({
      #    
      #     composedView: SC.View.design({
      #       layout: { top: 0, bottom: 0, left: 0, right: 0 },
      #       childViews: 'buttonOne buttonTwo statusLabel'.w(),
      #
      #       buttonOne: SC.ButtonView.design({
      #         ...
      #       }),
      #
      #       buttonTwo: SC.ButtonView.design({
      #         ...
      #       }),
      #
      #       statusLabel: SC.LabelView.design({
      #         ...
      #       })
      #     })
      # 
      #   }) 
      #
      # Since the root view (composedView) is just a basic SC.View, accessing it using
      # the proxy's [] convention would just give you back a basic View proxy. This then
      # means you have to access the child views explicitly every time you want to interact
      # with the composed view. This can be brittle since the view's structure can change.
      # Instead you can make a proxy to abstract away the interal structure and make it
      # easier to work with the view. Therefore, we could make a proxy as follows:
      #
      #   ComposedView < Lebowski::Foundation::Views::View
      #
      #     def click_button_one()
      #       self['buttonOne'].click
      #     end
      #
      #     def click_button_two()
      #       self['buttonTwo'].click
      #     end   
      #
      #     def status()
      #       return self['statusLabel.value']
      #     end
      #
      #   end
      #
      # With the proxy above, you can then do the following:
      #
      #   view = App['mainPage.composedView', View]
      #   view = view.represent_as(ComposedView) 
      #   view.click_button_one
      #   status = view.status
      #
      def represent_as(type)
        if not (type.kind_of?(Class) and type.ancestors.member?(ProxyObject))
          raise ArgumentInvalidTypeError.new "type", type, 'class < ProxyObject'
        end
        
        obj = type.new @parent, @rel_path, @driver
        return obj
      end
      
      #
      # Returns the absolute path of this object based on the parent object heirarchy. As
      # an example, this object's parent has an absolute path of 'foo' and this object has
      # relative path of 'bar', then the absolute path will be 'foo.bar'
      #
      def abs_path()   
        if not @abs_path.nil? 
          return @abs_path
        end

        if @parent.nil? or @parent.abs_path.nil?
          return @rel_path
        end

        @abs_path = "#{@parent.abs_path}.#{rel_path}"

        return @abs_path
      end
      
      #
      # Returns the absolute path given a relative path. Say, for example, that a
      # proxy object has an absolute path of 'mainPage.mainPane.someView'. When
      # given a relative path of 'foo.bar', the returned value would be:
      #
      #   'mainPage.mainPane.someView.foo.bar'
      #
      def abs_path_with(rel_path)
        path = abs_path
        return rel_path if path.nil?
        return "#{path}.#{rel_path}"
      end
      
      #
      # Gets the remote SproutCore GUID for this object
      #
      def sc_guid()
        # We only need to fetch the remote GUID once since it never changes for a given instance
        @guid = @driver.get_sc_guid(abs_path) if @guid.nil?
        return @guid
      end
      
      #
      # Gets the remote SC class name for this object
      #
      def sc_class()
        # We only need to fetch the remote SC class name once since it never changes for a given instance
        @class_name = @driver.get_sc_object_class_name(abs_path) if @class_name.nil?
        return @class_name
      end
      
      #
      # Gets all the remote SproutCore classes that the proxied object derives from. This will return
      # an array of strings representing the names of the classes. As an example, if the
      # proxy was communicating with an object that was of type SC.ButtonView then the
      # result would be the following:
      #
      #   ['SC.ButtonView', 'SC.View', 'SC.Object']
      #
      # The last item in the array is always 'SC.Object' since that is the root object for all
      # SproutCore objects.
      #
      def sc_all_classes()
        @all_class_names = @driver.get_sc_object_class_names(abs_path) if @all_class_names.nil?
        return @all_class_names
      end
      
      #
      # Checks if the remote proxied object is a kind of given SC class 
      #
      def sc_kind_of?(type)
        if not (type.kind_of?(Class) or type.kind_of?(String))
          raise ArgumentInvalidTypeError.new "type", type, 'class < SCObject', String
        end
        
        if type.kind_of?(Class) and type.ancestors.member?(SCObject)
          type = type.represented_sc_class
        end
        
        type = type.downcase
        result = sc_all_classes.detect do |val| 
          val.downcase == type
        end
        return (not result.nil?)
      end
      
      def sc_type_of(rel_path)
        return @driver.get_sc_type_of(abs_path_with(rel_path))
      end
      
      def sc_path_defined?(rel_path)
        return (not sc_type_of(rel_path) == SC_T_UNDEFINED)
      end
      
      def none?(rel_path)
        type = sc_type_of(rel_path)
        return (type == SC_T_UNDEFINED or type == SC_T_NULL) 
      end
      
      def object?(rel_path)
        type = sc_type_of(rel_path)
        return (type == SC_T_OBJECT or type == SC_T_HASH)
      end
      
      # DEPRECATED
      def proxy(klass, rel_path)
        puts "DEPRECATED: proxy is deprecated. use define_proxy instead"
        puts "... klass = #{klass}"
        puts "... rel_path = #{rel_path}"
        define_proxy(klass, rel_path)
      end
      
      # DEPRECATED
      def define(path, rel_path=nil, expected_type=nil)
        puts "DEPRECATED: define is deprecated. use define_path instead"
        puts "... path = #{path}"
        puts "... rel_path = #{rel_path}"
        puts "... expected_type = #{expected_type}"
        define_path(path, rel_path, expected_type)
      end
      
      #
      # Defines a path proxy for a relative path on this proxy object. The path proxy
      # will be loaded only when actually requested for use.
      #
      # @param klass The klass to use as the path proxy
      # @param rel_path The relative path agaist this proxy object 
      #
      def define_proxy(klass, rel_path)
        if (not rel_path.kind_of?(String)) or rel_path.empty?
          raise ArgumentError.new "rel_path must be a valid string"
        end
        
        if not (klass.kind_of?(Class) and klass.ancestors.member?(ProxyObject))
          raise ArgumentInvalidTypeError.new "klass", klass, 'class < ProxyObject'
        end

        @defined_proxies[rel_path] = klass
      end
      
      #
      # Given a relative path, unravel it to access an object. Unraveling means to take
      # any defined path in the given relative path and convert the entire path back
      # into a full relative path without definitions.
      #
      def unravel_relative_path(rel_path)
        path_parts = rel_path.split '.'
        
        full_rel_path = ""
        defined_path = nil
        counter = path_parts.length
        
        for path_part in path_parts do
          path = defined_path.nil? ? path_part : "#{defined_path}.#{path_part}"
          if path_defined? path
            defined_path = path
          else
            break
          end
          counter = counter - 1
        end
        
        full_rel_path << self.defined_path(defined_path).full_rel_path if (not defined_path.nil?)
        if (counter > 0)
          full_rel_path << "." if (not defined_path.nil?)
          full_rel_path << path_parts.last(counter).join('.')
        end
        
        return full_rel_path
      end
      
      #
      # The primary method used to access a proxied object's properties. Accessing
      # a property is done using a relative property path. The path is a chain of
      # properties connected using dots '.'. The type is automatically determined, but
      # in cases where a particular type is expected, you can optionally supply what the
      # expected type should be. 
      #
      # As an example, to access an object's property called 'foo', you can do the
      # following:
      #
      #   value = object['foo']
      #
      # If you expect the value's type to be, say, an number, you can do the following:
      #
      #   value = object['foo', :number]
      #
      # In the case where you expect the value to be a type of object you can do one
      # of the following:
      #
      #   value = object['foo', 'SC.SomeObject']
      #
      #   value = object['foo', SomeObject]
      #
      # In the first case, you are supply the object type as a string, in the second case
      # you are supplying the expected type with a proxy class. For the second option to
      # work you must first supply the proxy to the proxy factory.
      #
      # To access a property through a chain of objects, you supply a relative path, like
      # so:
      #
      #   value = object['path.to.some.property']
      #
      # Remember that the path is relative to the object you passed the path to. The approach
      # is used to work with how you would normally access properties using the SproutCore 
      # framework.
      #
      # The fundamental types detected within the web browser are the following:
      #
      #   Null     - null in JavaScript
      #   Error    - SproutCore error object
      #   String   - string in JavaScript
      #   Number   - number in JavaScript
      #   Boolean  - boolean in JavaScript
      #   Hash     - a JavaScript hash object
      #   Object   - a SproutCore object
      #   Array    - a JavaScript array
      #   Class    - A SproutCore class
      #
      # Based on the value's type within the browser, this method will translate the value as
      # follows:
      #
      #   Null     -> nil 
      #   Error    -> :error
      #   String   -> standard string
      #   Number   -> standard number
      #   Boolean  -> standard boolean
      #   Hash     -> a generic proxy object
      #   Object   -> closest matching proxy object
      #   Array    -> standard array for basic types; an object array (ObjectArray) for objects
      #   Class    -> a generic proxy object
      #
      # If the given relative path tries to reference a property that is not defined then :undefined
      # is returned. 
      #
      # The two special cases are when the basic type of the relative path is a SproutCore object or 
      # an array. In the case of a SproutCore object, the closest matching object type will be returned
      # based on what proxies have been provided to the proxy factory. For instance, let's say you have
      # custom view that derives from SC.View. If no proxy has been made for the custom view then
      # the next closest proxy will be returned, which would be a View proxy that is already part
      # of the lebowski framework. If your require a proxy to interact with the custom view then you
      # need to add that proxy to the proxy framework. 
      #
      # When the type is an array, the proxy object will check the content of the array to determine
      # their type. If all the content in the array are of the same type then it will return a 
      # corresponding array made up content with that type. So, for example, if an object has
      # a property that is an array of strings then a basic array of string will be returned. In the
      # case where the array contains either hash objects or SproutCore objects then an ObjectArray
      # will be returned. 
      #
      def [](rel_path, expected_type=nil)
        if (not rel_path.kind_of?(String)) or rel_path.empty?
          raise ArgumentError.new "rel_path must be a valid string"
        end
        
        if @cached_proxy_objects.has_key? rel_path
          return @cached_proxy_objects[rel_path]
        end
        
        defined_proxy = @defined_proxies.has_key?(rel_path) ? @defined_proxies[rel_path] : nil
          
        path_defined = path_defined? rel_path
        
        if path_defined
          path = defined_path rel_path
          expected_type = path.expected_type if (path.has_expected_type? and expected_type.nil?)
        end
      
        unraveled_rel_path = unravel_relative_path rel_path
        value = fetch_rel_path_value unraveled_rel_path, expected_type
        
        if value.kind_of? ProxyObject
          value = value.represent_as(defined_proxy) if (not defined_proxy.nil?)
          @cached_proxy_objects[rel_path] = value if (path_defined or not defined_proxy.nil?) 
        end
        
        return value
      end
      
      #
      # Retain a reference to the original eql? method so we can still use it
      #
      alias_method :__eql?, :eql?
      
      #
      # Override the == operator so that a proxy object can be compared to another
      # proxy object via their SproutCore GUIDs
      #
      def ==(obj)
        return (self.sc_guid == obj.sc_guid) if obj.kind_of?(ProxyObject)
        return super(obj)
      end
      
      alias_method :eql?, :==
      
      #
      # Override method_missing so that we can access a proxied object's properties using
      # a more conventional Ruby approach. So instead of accessing an object's property
      # using the [] convention, we can instead do the following:
      #
      #   value = proxied_object.foo # compared to proxied_object['foo']
      #
      # This will also translate the name of property into camel case that is normally
      # used in JavaScript. So, if an object in JavaScript has a property with the
      # name 'fooBar', you can access that property using the standard Ruby convention
      # like so:
      #
      #   value = proxied_object.foo_bar
      #
      # It will be converted back into 'fooBar'. If the property does not exist
      # on the proxied object then an exception will be thrown. If you want to access
      # property without an exception being thrown then use the [] convention using
      # a relative property path string.
      #
      def method_missing(sym, *args, &block)
        if (not sym.to_s =~ /\?$/) and (args.length == 0)
          camel_case = to_camel_case(sym.to_s)
          return self[camel_case] if sc_path_defined?(camel_case)  
        end
        super
      end
      
    private
    
      def init_expected_parent_type()
        return nil
      end
    
      def rel_path_first_part(rel_path)
        first_path_part = rel_path.match(/^((\w|-)*)\./)
        first_path_part = rel_path if first_path_part.nil?
        first_path_part = first_path_part[1] if first_path_part.kind_of?(MatchData)   
        return first_path_part    
      end
    
      def rel_path_sub_path(rel_path, first_path_part)
        sub_path = (first_path_part != rel_path) ? rel_path.sub(/^(\w|-)*\./, "") : ""
        return sub_path
      end
      
      def fetch_rel_path_value(rel_path, expected_type)
        type = sc_type_of(rel_path)
        
        case type
        when SC_T_NULL
          return handle_type_null(rel_path, expected_type)
        
        when SC_T_UNDEFINED
          return handle_type_undefined(rel_path, expected_type)
        
        when SC_T_ERROR
          return handle_type_error(rel_path, expected_type)

        when SC_T_STRING
          return handle_type_string(rel_path, expected_type)
        
        when SC_T_NUMBER
          return handle_type_number(rel_path, expected_type)
        
        when SC_T_BOOL
          return handle_type_bool(rel_path, expected_type)
        
        when SC_T_ARRAY
          return handle_type_array(rel_path, expected_type)
        
        when SC_T_HASH
          return handle_type_hash(rel_path, expected_type)
        
        when SC_T_OBJECT
          return handle_type_object(rel_path, expected_type)
          
        when SC_T_CLASS
          return handle_type_class(rel_path, expected_type)
        
        else
          raise StandardError.new "Unrecognized returned type '#{type}' for path #{abs_path_with(rel_path)}"
        end
      end
      
      def handle_type_null(rel_path, expected_type)
        if (not expected_type.nil?) and not (expected_type == :null)
          raise UnexpectedTypeError.new(abs_path_with(rel_path), expected_type, SC_T_NULL, :null)
        end

        return nil
      end
      
      def handle_type_undefined(rel_path, expected_type)
        if (not expected_type.nil?) and not (expected_type == :undefined)
          raise UnexpectedTypeError.new(abs_path_with(rel_path), expected_type, SC_T_UNDEFINED, :undefined)
        end

        return :undefined
      end
      
      def handle_type_error(rel_path, expected_type)
        if (not expected_type.nil?) and not (expected_type == :error)
          raise UnexpectedTypeError.new(abs_path_with(rel_path), expected_type, SC_T_ERROR, :error)
        end

        return :error
      end
      
      def handle_type_bool(rel_path, expected_type)
        value = @driver.get_sc_path_boolean_value(abs_path_with(rel_path))
        
        if (not expected_type.nil?) and not (expected_type == :boolean or expected_type == :bool)
          raise UnexpectedTypeError.new(abs_path_with(rel_path), expected_type, SC_T_BOOL, value)
        end
        
        return value
      end
      
      def handle_type_string(rel_path, expected_type)
        value = @driver.get_sc_path_string_value(abs_path_with(rel_path))
        
        if (not expected_type.nil?) and not (expected_type == :string)
          raise UnexpectedTypeError.new(abs_path_with(rel_path), expected_type, SC_T_STRING, value)
        end
        
        return value
      end
      
      def handle_type_number(rel_path, expected_type)
        value = @driver.get_sc_path_number_value(abs_path_with(rel_path))
        
        if (not expected_type.nil?) and not (expected_type == :number)
          raise UnexpectedTypeError.new(abs_path_with(rel_path), expected_type, SC_T_NUMBER, value)
        end
        
        return value
      end
      
      def handle_type_class(rel_path, expected_type)
        # TODO: Need to handle this case better
        value = ProxyObject.new self, rel_path, @driver
        
        if (not expected_type.nil?) and not (expected_type == :class)
          raise UnexpectedTypeError.new(abs_path_with(rel_path), expected_type, SC_T_CLASS, value)
        end
        
        return value
      end
      
      def handle_type_hash(rel_path, expected_type)
        value = ProxyObject.new self, rel_path, @driver
        
        if (not expected_type.nil?) and not (expected_type == :object or expected_type == :hash)
          raise UnexpectedTypeError.new(abs_path_with(rel_path), expected_type, SC_T_HASH, value)
        end
        
        return value
      end
      
      def handle_type_object(rel_path, expected_type)
        
        value = nil
        
        class_names = @driver.get_sc_object_class_names(abs_path_with(rel_path))
        matching_class = class_names.detect { |name| ProxyFactory.has_key?(name) }
        if matching_class.nil?
          value = ProxyFactory.create_proxy(Lebowski::Foundation::SCObject, self, rel_path)
        else
          value = ProxyFactory.create_proxy(matching_class, self, rel_path)
        end
        
        if not expected_type.nil?
          got_expected_type = (expected_type == :object or value.sc_kind_of?(expected_type))
          if not got_expected_type
            raise UnexpectedTypeError.new(abs_path_with(rel_path), expected_type, SC_T_OBJECT, value)
          end
        end

        return value
        
      end
      
      def handle_type_array(rel_path, expected_type)
        content_type = @driver.get_sc_type_of_array_content(abs_path_with(rel_path))
        
        got_expected_type = false
        
        # TODO: This needs a better solution
        case content_type
        when SC_T_NUMBER
          got_expected_type = (expected_type == :array or expected_type == :number_array)
          value = @driver.get_sc_path_number_array_value(abs_path_with(rel_path))
        when SC_T_STRING
          got_expected_type = (expected_type == :array or expected_type == :string_array)
          value = @driver.get_sc_path_string_array_value(abs_path_with(rel_path))
        when SC_T_BOOL
          got_expected_type = (expected_type == :array or expected_type == :boolean_array or expected_type == :bool_array)
          value = @driver.get_sc_path_boolean_array_value(abs_path_with(rel_path))
        when SC_T_HASH
          got_expected_type = (expected_type == :array or expected_type == :object_array or expected_type == :hash_array)
          value = ObjectArray.new self, rel_path
        when SC_T_OBJECT
          got_expected_type = (expected_type == :array or expected_type == :object_array)
          value = ObjectArray.new self, rel_path
        when "empty"
          got_expected_type = (expected_type == :array)
          value = []
        else
          got_expected_type = (expected_type == :array)
          # TODO: Replace with correct logic. Temporary for now
          value = []
        end
        
        if (not expected_type.nil?) and (not got_expected_type)
          raise UnexpectedTypeError.new(abs_path_with(rel_path), expected_type, SC_T_ARRAY, value)
        end
        
        return value
      end
      
      #
      # Will return a string in camel case format for any value that follows the Ruby
      # variable and method naming convention (e.g. my_variable_name). As an example:
      # 
      #   Util.to_camel_case(:some_long_name) # => "someLongName"
      #   Util.to_camel_case("function_foo_bar") # => "functionFooBar"
      #
      def to_camel_case(value)
        camel_case_str = ""
        word_counter = 1
        words = value.to_s.split('_')
        return words[0] if words.length == 1
        words.each do |word|
          camel_case_str << ((word_counter == 1) ? word : word.sub(/./) { |s| s.upcase })   
          word_counter = word_counter.next
        end
        return camel_case_str
      end
      
    end
    
  end
end