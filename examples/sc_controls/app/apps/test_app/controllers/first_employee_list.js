// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp Core */

TestApp.firstEmployeeListController = SC.ArrayController.create(
  SC.CollectionViewDelegate,
  SC.CollectionContent, 
{

  selection: null,
  
  status: null,
    
  contentDidChange: function() {
    this.notifyPropertyChange('selection');
  }.observes('*content.[]'),
  
  selectionDidChange: function() {
    var sel = this.get('selection');
    if (!sel || sel.get('length') === 0) {
      this.set('status', 'No items selected');
      return;
    }
    
    var ids = [];
    sel.forEach(function(object, index) {
      ids.push(object.get('guid'));
    }, this);
    this.set('status', 'Selected items = [%@]'.fmt(ids.toString()));
  }.observes('selection'),
  
  itemAction: function() {
    var obj = this.getPath('selection.firstObject');
    this.set('status', 'Double clicked on item. guid = %@'.fmt(obj.get('guid')));
  },
  
  //////////// SC.CollectionViewDelete Support
  
  collectionViewDeleteContent: function(view, content, indexes) {
    if (!content) return NO;
    
    indexes.forEach(function(index) { 
      var obj = content.objectAt(index);
      content.removeObject(obj);
    }, this);
    
    return YES;
  },
  
  //////////// SC.CollectionContent Drag and Drop support
  
  collectionViewDragDataTypes: function(view) { 
    return [TestApp.DRAG_EMPLOYEES]; 
  },
  
  collectionViewDragDataForType: function(view, drag, dataType) 
  {  
    if (dataType == TestApp.DRAG_EMPLOYEES) {
      var sel = this.get('selection'); 
      var emps = [];
      sel.forEach(function(object, index) {
        emps.pushObject(object);
      }, this);
      return emps;
    }
    
    return null ;
  }

}) ;