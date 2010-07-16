// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.localControlsController = SC.Object.create({
  
  labelText: '',
  
  value: '',
  
  update: function() {
    this.set('labelText', this.get('value'));
  }
  
});