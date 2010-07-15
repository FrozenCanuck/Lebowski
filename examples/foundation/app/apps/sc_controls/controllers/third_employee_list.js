// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.thirdEmployeeListController = SC.TreeController.create({

  contentBinding: SC.Binding.oneWay('TestApp.groupEmployeesController.employeesGroupedByCompany')
  
});