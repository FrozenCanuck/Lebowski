// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp Core */

TestApp.containerControlsController = SC.Object.create({
  
  nowShowing: null,
  
  showEmptyContainer: function() {
    this.set('nowShowing', null);
  },
  
  showView1: function() {
    this.set('nowShowing', 'view1');
  },
  
  showView2: function() {
    this.set('nowShowing', 'view2');
  },
  
  reset: function() {
    this.showEmptyContainer();
  }
  
});