// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.fourthEmployeeListController = SC.TreeController.create(SC.CollectionViewDelegate, {
  
  collectionViewShouldBeginDrag: function(view) { 
    var sel = this.getPath('selection.firstObject');
    if (!sel || sel.get('isFolder')) return NO;
    return YES; 
  },
  
  collectionViewDragDataTypes: function(view) { 
    return [TestApp.DRAG_EMPLOYEES2]; 
  },
  
  collectionViewDragDataForType: function(view, drag, dataType) 
  {  
    if (dataType == TestApp.DRAG_EMPLOYEES2) {
      var sel = this.getPath('selection.firstObject'); 
      return sel;
    }
    
    return null ;
  },
  
  collectionViewComputeDragOperations: function(view, drag, proposedDragOperations) {    
    if (drag.hasDataType(TestApp.DRAG_EMPLOYEES2)) {
      return SC.DRAG_ANY;
    }
    
    return SC.DRAG_NONE;
  },
  
  collectionViewValidateDragOperation: function(view, drag, op, proposedInsertionIndex, proposedDropOperation) {
    return op;
  },
  
  collectionViewPerformDragOperation: function(view, drag, op, proposedInsertionIndex, proposedDropOperation) {
    var root = this.get('content');
    var dropOnTarget = view.get('content').objectAt(proposedInsertionIndex);
    
    if (!dropOnTarget) return SC.DRAG_NONE; 
    
    if (!dropOnTarget.get('isFolder')) dropOnTarget = root;
    
    var employee = drag.dataForType(TestApp.DRAG_EMPLOYEES2);
    
    var folder = employee.get('folder');
    if (!folder) folder = root;
    folder.get('treeItemChildren').removeObject(employee);
    
    dropOnTarget.get('treeItemChildren').push(employee);
    employee.set('folder', dropOnTarget);
    this.notifyPropertyChange('content');
    
    return SC.DRAG_NONE;
  }
  
});