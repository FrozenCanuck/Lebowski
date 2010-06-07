module Lebowski
  module Runtime
    class SproutCoreDriver
      include Selenium::Client::Base
      include Lebowski::Runtime::SproutCoreExtensions
      
      def session_id=(value)
        @session_id = value
      end
      
    end
  
  end
end