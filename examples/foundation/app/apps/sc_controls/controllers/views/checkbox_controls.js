// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp Core */

TestApp.checkboxControlsController = SC.Object.create({
  
  reset: function() {
    var page = TestApp.checkboxViewsPage;
    page.setPath('basicCheckboxView.value', NO);
    page.setPath('mixedStateCheckboxView.value', [YES, NO]);
  }
  
});