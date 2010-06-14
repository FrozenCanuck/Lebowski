// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp Core */

TestApp.disclosureControlsController = SC.Object.create({
  
  resetMixedStateDisclosure: function() {
    TestApp.setPath('disclosureViewsPage.mainView.mixedStateDisclosure.disclosure.value', [YES, NO]);
  }
  
});