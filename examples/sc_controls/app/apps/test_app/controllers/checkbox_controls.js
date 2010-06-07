// ==========================================================================
// Project:   TestApp.employeesController
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals TestApp Core */

TestApp.checkboxControlsController = SC.Object.create({
  
  resetMixedStateCheckbox: function() {
    TestApp.setPath('checkboxViewsPage.mainView.mixedStateCheckbox.checkbox.value', [YES, NO]);
  }
  
});