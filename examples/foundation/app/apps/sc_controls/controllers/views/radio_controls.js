// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp Core */

TestApp.radioControlsController = SC.Object.create({
  
  resetMixedRadioView: function() {
    TestApp.setPath('radioViewsPage.mainView.mixedStateRadioView.radio.value', [1]);
  }
  
});