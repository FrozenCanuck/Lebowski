// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.mainController = SC.Object.create({
  
  reset: function() {
    var controller = TestApp.openWindowController;
    controller.set('windowNameValue', '');
    controller.set('windowTitleValue', '');
    controller.set('openingWindow', NO);
    
    controller = TestApp.localControlsController;
    controller.set('labelText', '');
    controller.set('value', '');
  }
  
});