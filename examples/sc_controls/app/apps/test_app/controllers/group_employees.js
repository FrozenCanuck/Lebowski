// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.groupEmployeesController = SC.ArrayController.create({

  employeesGroupedByCompany: null,

  groupEmployeesByCompany: function() {
  
    var root = SC.Object.create({
      treeItemIsExpanded: YES,
      treeItemChildren: []
    });
    
    var content = this.get('content');
    if (!content) return;
    
    var companies = {};
    
    content.forEach(function(obj) {
      var company = obj.get('company');
      if (!companies[company]) {
        companies[company] = SC.Object.create({
          summary: company,
          treeItemIsExpanded: NO,
          treeItemChildren: []
        });
        root.treeItemChildren.pushObject(companies[company]);
      }
      companies[company].treeItemChildren.pushObject(obj);
    });
    
    this.set('employeesGroupedByCompany', root);
    
  }.observes('*content.[]')
  
});