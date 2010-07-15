// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp Core */

TestApp.labelControlsController = SC.Object.create({
  
  caption: null,
  
  actionFoo: function() {
    this.set('caption', 'foo');
  },
  
  actionBar: function() {
    this.set('caption', 'bar');
  }
  
});