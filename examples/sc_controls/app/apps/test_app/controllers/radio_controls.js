// ==========================================================================
// Project:   TestApp.employeesController
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals TestApp Core */

TestApp.radioControlsController = SC.Object.create({
  
  resetMixedRadioView: function() {
    TestApp.setPath('radioViewsPage.mainView.mixedStateRadioView.radio.value', [1]);
  }
  
});