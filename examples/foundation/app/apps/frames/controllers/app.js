// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals FramedApp */

FramedApp.appController = SC.Object.create({
  
  labelValue: null,
  
  textFieldValue: null,
  
  reset: function() {
    this.set('labelValue', null);
    this.set('textFieldValue', null);
  },
  
  update: function() {
    this.set('labelValue', this.get('textFieldValue'));
  }
  
});