// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp Core */

TestApp.selectButtonControlsController = SC.Object.create({
  
  reset: function() {
    var page = TestApp.get('selectButtonViewsPage'), view;
    page.setPath('basicSelectButtonView.value', 'One');
    page.setPath('advancedSelectButtonView.value', 1);
  }
  
});