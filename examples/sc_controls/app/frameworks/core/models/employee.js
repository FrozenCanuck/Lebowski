// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals Core */

sc_require('core');

Core.Employee = SC.Record.extend({
  
  guid: SC.Record.attr(String),

  firstName: SC.Record.attr(String),

  lastName: SC.Record.attr(String),

  title: SC.Record.attr(String),
  
  company: SC.Record.attr(String),
  
  fullName: function() {
    return "%@ %@".fmt(this.get('firstName'), this.get('lastName'));
  }.property('firstName', 'lastName').cacheable(),
  
  summary: function(key, value) {
    
    if (value !== undefined) {
      var match = value.match(/(.*)=(.*)/i);
      if (match) {
        var matchKey = match[1];
        var matchValue = match[2];
        if (matchKey.length > 0 && matchValue.length > 0) {
          this.set(matchKey, matchValue);
        }
      }
    }
    
    return "[%@] %@ - %@, %@".fmt(this.get('guid'), this.get('fullName'), this.get('company'), this.get('title'));
  }.property('fullName', 'company', 'title').cacheable()

});