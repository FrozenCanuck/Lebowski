module Lebowski
  module Foundation
    
    module Mixins
   
      #
      # Mixin provides objects with behavior to define symbolic paths that can be used
      # to help access remote objects
      #
      module DefinePathsSupport
        include Lebowski::Foundation

        #
        # Defines symbolic path
        #
        # The path given must be a string. The path itself follows a standard dot-path
        # notatition, such as the following examples:
        #
        #   "foo"
        #   "foo.bar"
        #   "foo.bar.mah"
        #
        # You can optionally provide a relative path and an expected type. When a
        # relative path is not provided, then the given path acts as a place holder, which
        # can be useful to organize symbolic paths into groups. If a relative path
        # is provided then it is used to access an actual object in the web browser.
        #
        # If an expected type is provided, then it will be used to check the type of
        # the returned object whenever the defined symbolic path is used to access
        # a remote object. if the object being proxied is not of the expectec type
        # then an exception will be thrown
        #
        # Examples of how to define a path:
        #
        #   obj.define_path 'foo'               # foo acts as a place holder
        #   obj.define_path 'bar', 'x.y.x'      # bar is a symolic path for 'x.y.x'
        #   obj.define_path 'foo.aaa', 'a.b.c'  # aaa is a symbolic path for 'a.b.c' 
        #   obj.define_path 'foo.bbb', 'm.n.o'  # bbb is a symbolic path for 'm.n.o'
        #   obj.define_path 'stuff.xxx', 'h.j.k'  # xxx is a symbolic path for 'h.j.k'. stuff is a place holder
        #   obj.define_path 'mah', 'bar.thing'  # mah is a symbolic path for 'x.y.z.thing'. bar is automatically replaced 
        #
        def define_path(path, rel_path=nil, expected_type=nil)
          if (not path.kind_of?(String)) or path.empty?
            raise ArgumentError.new "path must be a valid string"
          end
          
          current_path_part = root_defined_path_part
          
          path_parts = path.split('.')
          counter = 1
          path_parts.each do |part|
            if current_path_part.has_path_part? part 
              current_path_part = current_path_part[part]
            else
              if counter == path_parts.length
                current_path_part = current_path_part.add_path_part part, rel_path, expected_type
              else
                current_path_part = current_path_part.add_path_part part
              end
            end
            counter = counter.next
          end
          
          return current_path_part
        end

        #
        # Defines relative symbolic paths for a given symbolic path that has been defined.
        #
        # Use when you are trying to define many symbolic paths that are all
        # relative to another symbolic path that has already been defined. The following
        # is an example of how it is used:
        #
        #   obj.define_path 'foo', 'a.b.c' # first define the parent symbolic path
        #
        #   obj.define_paths_for 'foo' do |path|
        #     # Paths defined are all relative to foo
        #     path.define_path 'bar', 'x.y.z'
        #     path.define_path 'mah', 'm.n.o'
        #   end
        #
        #   x = obj['foo.bar'] # path will be converted to actual path 'a.b.c.x.y.z'
        #
        def define_paths_for(path, &block)
          path_part = root_defined_path_part[path]
          if path_part.nil?
            raise ArgumentError.new "can not define paths for #{path} since it has not yet been defined"
          end
          
          yield path_part
        end
        
        #
        # Checks if a given path has been defined
        #
        def path_defined?(path)
          return (not root_defined_path_part[path].nil?)
        end
        
        #
        # Gets a symbolic path object if it has been defined
        #
        def defined_path(path)
          return root_defined_path_part[path]
        end
        
        #
        # Returns the root symbolic path object for the given object
        #
        def defined_paths()
          return root_defined_path_part
        end
        
        def root_defined_path_part()
          if @root_defined_path_part.nil?
            @root_defined_path_part = Support::DefinedPathPart.new
          end
          return @root_defined_path_part
        end
        
        def root_defined_path_part=(path)
          if not path.kind_of? Support::DefinedPathPart
            raise ArgumentInvalidTypeError.new 'part', part, DefinedPathPart
          end
          @root_defined_path_part = path
        end

      end
      
      module Support
 
        #
        # Represents a part of a defined path. As an example, if 'foo.bar' was a defined
        # path then the string would be split up an represented as two parts: foo and bar
        # where foo is the parent of bar.
        #
        class DefinedPathPart
          include Lebowski::Foundation
          include DefinePathsSupport
        
          attr_reader :name, :parent, :rel_path, :expected_type
        
          def initialize(name=nil, parent=nil, rel_path=nil, expected_type=nil)
            @name = name
            @parent = parent
            @rel_path = rel_path
            @expected_type = expected_type
            @child_path_parts = {}
          end
          
          #
          # Returns the number of child parts this part has
          #
          def count()
            return @child_path_parts.count
          end
          
          #
          # Used to iterate over this part's child parts
          # 
          def each(&block)
            @child_path_parts.each do |key, value|
              yield value
            end
          end
          
          #
          # Used access a descendent part based on the given string representing
          # relative symbolic path to this part. As an example, if "foo.bar"
          # was provided, the string would be split up and each part of the string
          # would be traversed in order to find the last descendent part. If the
          # given path can not be followed then nil is returned
          #
          def [](value)
            return nil if value.nil?
            
            if not value.kind_of? String
              raise ArgumentInvalidTypeError.new 'value', value, String
            end
            
            current_path_part = self
            path_parts = value.split('.')
            counter = 1
            path_parts.each do |part|
              current_path_part = current_path_part.child_path_part(part)
              return nil if current_path_part.nil?
            end
            return current_path_part
          end
        
          #
          # Add as path part to this object. The part can optionally be
          # associated with a relative path and expected type
          #
          def add_path_part(name, rel_path=nil, expected_type=nil)
            if not name.kind_of? String
              raise ArgumentInvalidTypeError.new 'name', name, String
            end
    
            if has_path_part? name
              raise ArgumentError "path part #{name} has already been added"
            end
            
            rel_path_parts = (not rel_path.kind_of? String) ? [] : rel_path.split('.')
            
            if (not rel_path_parts.empty?) and has_path_part?(rel_path_parts[0])
              rel_path = ""
              rel_path << self[rel_path_parts[0]].full_rel_path
              if (rel_path_parts.length > 1)
                rel_path << "." << rel_path_parts.last(rel_path_parts.length - 1).join('.')
              end
            end
    
            path_part = create_path_part(name, self, rel_path, expected_type)
              
            @child_path_parts[path_part.name] = path_part
            return path_part
          end
          
          #
          # Checks if this part is a root part
          #
          def is_root?()
            return (name.nil? and parent.nil?) 
          end
          
          #
          # Checks if this part is just a placed holder.
          #
          def is_place_holder?()
            return rel_path.nil?
          end
          
          def has_expected_type?()
            return (not expected_type.nil?)
          end
          
          #
          # Checks if this part has a child part matching the given value
          #
          def has_path_part?(part)
            if part.kind_of? DefinedPathPart
              part = part.name
            elsif not part.kind_of? String
              raise ArgumentInvalidTypeError.new 'part', part, String, DefinedPathPart
            end
            
            return @child_path_parts.has_key?(part)
          end
          
          #
          # Will generate a full defined path for this part
          #
          def full_defined_path()
            return nil if is_root?
            return name if parent.is_root?
            return "#{parent.full_defined_path}.#{name}"
          end
          
          #
          # Will generate a full relative path for this part. The relative path
          # generated is based on this part and all of its parent parts' relative
          # paths. 
          #
          def full_rel_path()
            return nil if rel_path.nil?
            
            path = nil
            current_part = self
            while not current_part.nil? do
              if (not current_part.rel_path.nil?)
                if path.nil?
                  path = current_part.rel_path
                else
                  path = "#{current_part.rel_path}.#{path}"
                end
              end
              current_part = current_part.parent
            end
            
            return path
          end
          
          def defined_paths()
            return self
          end
          
          def to_s()
            return "DefinedPathPart<name=#{name}, rel_path=#{rel_path}, full_defined_path=#{full_defined_path}>"
          end
        
        protected
        
          def root_defined_path_part()
            return self
          end
        
          def child_path_part(part)
            return @child_path_parts[part]
          end
          
          def create_path_part(name, parent, rel_path, expected_type)
            return DefinedPathPart.new name, parent, rel_path, expected_type
          end
        
        end
      
      end
      
    end
    
  end
end