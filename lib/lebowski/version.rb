# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

module Lebowski # :nodoc:
  module VERSION # :nodoc:
    MAJOR  = 0
    MINOR  = 1
    TINY   = 1
    PRE    = nil

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')

    SUMMARY = "lebowski #{STRING}"
  end
end