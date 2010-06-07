# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

require "rubygems"
gem "selenium-client", ">=1.2.16"
require "selenium/client"

require File.expand_path(File.dirname(__FILE__) + '/lebowski/version')
require File.expand_path(File.dirname(__FILE__) + '/lebowski/core')

require File.expand_path(File.dirname(__FILE__) + '/lebowski/runtime')
require File.expand_path(File.dirname(__FILE__) + '/lebowski/foundation')
require File.expand_path(File.dirname(__FILE__) + '/lebowski/scui')
