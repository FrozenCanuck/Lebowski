// ==========================================================================
// Project:   TestApp.employeesController
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals TestApp Core */

TestApp.buttonControlsController = SC.Object.create({
  
  counter: 0,
  
  incrementCounter: function() {
    this.set('counter', this.get('counter') + 1);
  },
  
  resetCounter: function() {
    this.set('counter', 0);
  }
  
});