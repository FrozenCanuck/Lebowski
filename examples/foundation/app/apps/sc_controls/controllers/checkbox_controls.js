// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp Core */

TestApp.checkboxControlsController = SC.Object.create({
  
  resetMixedStateCheckbox: function() {
    TestApp.setPath('checkboxViewsPage.mainView.mixedStateCheckbox.checkbox.value', [YES, NO]);
  }
  
});