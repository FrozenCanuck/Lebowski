// ==========================================================================
// Project:   TestApp.employeesController
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals TestApp Core */

TestApp.disclosureControlsController = SC.Object.create({
  
  resetMixedStateDisclosure: function() {
    TestApp.setPath('disclosureViewsPage.mainView.mixedStateDisclosure.disclosure.value', [YES, NO]);
  }
  
});