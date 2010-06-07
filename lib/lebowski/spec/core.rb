# ==========================================================================
# Project:   Lebowski Framework - The SproutCore Test Automation Framework
# License:   Licensed under MIT license (see License.txt)
# ==========================================================================

#
# matcher is to only be applied to an object that derives from 
# Lebowksi::Foundation::Object class otherwise an exception will
# be raised
#
# Usage: 
#
#   myobject.should exist_in_app => myobject.exists? == true
#   myobject.should_not exist_in_app => myobject.exists? == false
#
Spec::Matchers.define :exist_in_app do
  match do |object|
    object.exists?
  end
end
    