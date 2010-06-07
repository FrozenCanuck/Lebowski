# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Spec
  module Matchers
    
    #
    # Replacing RSpec's default method_missing implementation so that we can 
    # include our own special default hooks that allows spec tests to look
    # more readable. 
    #
    # Ideally it would have been better if RSpec provided some nice hooks to 
    # try other default pattern matchers
    #
    def method_missing(sym, *args, &block)
      return Lebowski::Spec::Matchers::Be.new(sym, *args) if sym.to_s =~ /^be_/
      return Lebowski::Spec::Matchers::Has.new(sym, *args) if sym.to_s =~ /^have_/
      return Lebowski::Spec::Operators::That.new(sym, *args) if sym.to_s =~ /^that_/      
      super
    end
  end
end