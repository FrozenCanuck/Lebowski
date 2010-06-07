// ==========================================================================
// Project:   TestApp.employeesController
// Copyright: ©2010 My Company, Inc.
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
  }
  
});