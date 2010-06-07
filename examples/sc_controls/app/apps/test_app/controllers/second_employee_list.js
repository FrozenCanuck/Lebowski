/*globals TestApp */

TestApp.secondEmployeeListController = SC.ArrayController.create(
  SC.CollectionViewDelegate,
  SC.CollectionContent, 
{
  content: [],
  
  selection: null,
  
  //////////// SC.CollectionViewDelete Support
  
  collectionViewDeleteContent: function(view, content, indexes) {
    if (!content) return NO;
    
    this.propertyWillChange('content');
    
    indexes.forEach(function(index) { 
      var obj = content.objectAt(index);
      content.removeObject(obj);
    }, this);
    
    this.propertyDidChange('content');
    
    return YES;
  },
  
  //////////// SC.CollectionContent Drag and Drop support
  
  collectionViewComputeDragOperations: function(view, drag, proposedDragOperations) {
    if (drag.hasDataType(TestApp.DRAG_EMPLOYEES)) {
      return SC.DRAG_ANY;
    }
    
    return SC.DRAG_NONE;
  },
  
  collectionViewValidateDragOperation: function(view, drag, op, proposedInsertionIndex, proposedDropOperation) {
    return op;
  },
  
  collectionViewPerformDragOperation: function(view, drag, op, proposedInsertionIndex, proposedDropOperation) {
    var employees = drag.dataForType(TestApp.DRAG_EMPLOYEES);
    var content = this.get('content');
    
    this.propertyWillChange('content');
    
    employees.forEach(function(obj) {
      if (content.indexOf(obj) === -1) {
        obj.set('icon', 'sc-icon-user-16');
        obj.set('right-icon', 'sc-icon-info-16');
        content.pushObject(obj);
      }
    });
    
    this.propertyDidChange('content');
    
    return SC.DRAG_NONE;
  }
  
});