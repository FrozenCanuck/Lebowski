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
  
  active: SC.Record.attr(Boolean, { defaultValue: false }),
  
  init: function() {
    sc_super();
    
    this._guid = this.get('guid');
    this._firstName = this.get('firstName');
    this._lastName = this.get('lastName');
    this._title = this.get('title');
    this._company = this.get('company');
    this._active = this.get('active');
  },
  
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
  }.property('fullName', 'company', 'title').cacheable(),
  
  reset: function() {
    this.set('guid', this._guid);
    this.set('firstName', this._firstName);
    this.set('lastName', this._lastName);
    this.set('title', this._title);
    this.set('company', this._company);
    this.set('active', this._active);
  }

});