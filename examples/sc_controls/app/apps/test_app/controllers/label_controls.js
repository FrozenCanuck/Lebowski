// ==========================================================================
// Project:   TestApp.employeesController
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals TestApp Core */

TestApp.labelControlsController = SC.Object.create({
  
  caption: null,
  
  actionFoo: function() {
    this.set('caption', 'foo');
  },
  
  actionBar: function() {
    this.set('caption', 'bar');
  }
  
});