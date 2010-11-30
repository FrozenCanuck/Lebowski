// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp Core */

TestApp.listViewsController = SC.Object.create({
  
  reset: function() {
    this.configureEmployeeLists();
  },

  configureEmployeeLists: function() {
    var employees = TestApp.store.find(Core.Employee);
    
    employees.forEach(function(emp) {
      emp.reset();
    });
    
    var controller = TestApp.getPath('firstEmployeeListController');
    controller.set('content', employees.toArray());
    controller.set('selection', null);

    controller = TestApp.getPath('groupEmployeesController');
    controller.set('content', employees.toArray());
    controller.set('selection', null);
    
    controller = TestApp.getPath('secondEmployeeListController');
    controller.set('content', []);
    controller.set('selection', null);
  }
  
});