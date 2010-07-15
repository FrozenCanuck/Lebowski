// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp Core */

TestApp.controlsListController = SC.TreeController.create({
  
  controlItemSelected: function() {
    var sel = this.get('selection');
    
    if (!sel || sel.get('length') === 0 || sel.get('length') > 1) {
      this.showBlankView();
      return;
    }
    
    var item = sel.get('firstObject');
    if (!item.get('page')) {
      this.showBlankView();
      return;
    }
    
    this.showControlView(item.get('page'));
  },
  
  showBlankView: function() {
    TestApp.setPath('mainPage.controlContainerView.nowShowing', 'TestApp.mainPage.blankView');
  },
  
  showControlView: function(page) {
    TestApp.setPath('mainPage.controlContainerView.nowShowing', 'TestApp.%@.mainView'.fmt(page));
  }
  
});