module Lebowski
  module Runtime
   
    #
    # Used to encode Ruby values into an encoded string that can be sent over
    # to the browser to then be decoded and used.
    #
    # TODO: This needs to be completely changed. Instead of using a custom encoding, 
    #       should instead use a standard encoding scheme, like JSON. Got too
    #       experimental in this case. 
    #
    module ObjectEncoder
      
      COMMA_CHAR = ','
      COLON_CHAR = ':'
      EQUAL_CHAR = '='
      LEFT_SQUARE_BRACKET_CHAR = '['
      RIGHT_SQUARE_BRACKET_CHAR = ']'
      
      ENCODED_COMMA = "[cma]"
      ENCODED_COLON = "[cln]"
      ENCODED_EQUAL = "[eql]"
      ENCODED_LEFT_SQUARE_BRACKET = "[lsb]"
      ENCODED_RIGHT_SQUARE_BRACKET = "[rsb]"
      
      def self.encode(value)
        return encode_hash(value) if value.kind_of? Hash
        return encode_array(value) if value.kind_of? Array
        return nil
      end
      
      #
      # Encodes a given hash into a string representation that can be sent over
      # to the remote browser via Selenium. Examples of encoding:
      #
      #   { 'foo' => "bar"}               # => foo=bar
      #   { :foo => "bar"}                # => foo=bar
      #   { 'foo' => "cat", bar => "dog"} # => foo=cat,bar=dog
      #   { 'foo' => /bar/ }              # => foo=regexp:bar
      #   { 'foo' => /bar/i }             # => foo=regexpi:bar
      #   { 'foo.bar' => "cat" }          # => foo.bar=cat
      #   { 'foo' => "Acme, Inc."}        # => foo=Acme[comma] Inc.
      #   { 'foo' => 100 }                # => foo=int:100
      #   { 'foo' => true }               # => foo=bool:true
      #   { 'foo' => false }              # => foo=bool:false 
      #
      def self.encode_hash(hash) 
        str = ""
        counter = 1
        hash.each do |key, value|
          str << key.to_s << "=" << encode_value(value)
          str << "," if counter < hash.length
          counter = counter.next
        end
        return str
      end
      
      #
      # Encodes a given array into a string representation that can be sent over
      # to the remote browser via Selenium
      #
      def self.encode_array(array)
        str = ""
        counter = 1
        array.each do |value|
          str << encode_value(value)
          str << "," if counter < array.length
          counter = counter.next
        end
        return str
      end
      
      def self.encode_value(value)
        str = ""
        if value.kind_of? Regexp
          str << "regexp"
          str << "i" if (value.options & Regexp::IGNORECASE) == Regexp::IGNORECASE
          str << ":" << encode_string(value.source)
        elsif value.kind_of? Integer
          str << "int:" << value.to_s
        elsif value.kind_of? TrueClass or value.kind_of? FalseClass 
          str << "bool:" << value.to_s
        elsif value.kind_of? Hash
          str << "hash:" << encode_string(encode_hash(value))
        elsif value.kind_of? Array
          str << "array:" << encode_string(encode_array(value))
        elsif value.nil?
          str << "null:null"
        elsif value == :undefined
          str << "undefined:undefined"
        else
          str << encode_string(value.to_s)
        end
        return str
      end
    
      #
      # Encodes special characters in a string. Characters encoded are:
      #  
      #   ,  :  =  [  ]
      #
      def self.encode_string(string)
        new_string = string.gsub(/[,=:\[\]]/) do |c|
          case c
          when COMMA_CHAR
            ENCODED_COMMA
          when COLON_CHAR
            ENCODED_COLON
          when EQUAL_CHAR
            ENCODED_EQUAL
          when LEFT_SQUARE_BRACKET_CHAR
            ENCODED_LEFT_SQUARE_BRACKET
          when RIGHT_SQUARE_BRACKET_CHAR
            ENCODED_RIGHT_SQUARE_BRACKET
          end
        end
        return new_string
      end
      
    end
    
  end
end