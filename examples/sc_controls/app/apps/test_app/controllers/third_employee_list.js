/*globals TestApp */

TestApp.thirdEmployeeListController = SC.TreeController.create({

  contentBinding: SC.Binding.oneWay('TestApp.groupEmployeesController.employeesGroupedByCompany')
  
});