// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals BasicApp */

BasicApp.counterController = SC.Object.create({
  
  counter: 0,
  
  incrementCounter: function() {
    var counter = this.get('counter');
    this.set('counter', counter + 1);
  },
  
  decrementCounter: function() {
    var counter = this.get('counter');
    this.set('counter', counter - 1);
  },
  
  resetCounter: function() {
    this.set('counter', 0);
  }
  
});