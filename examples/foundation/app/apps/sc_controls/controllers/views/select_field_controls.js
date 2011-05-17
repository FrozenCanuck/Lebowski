// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp Core */

TestApp.selectFieldControlsController = SC.Object.create({
  
  largeItemsList: null,
  
  init: function() {
    sc_super();
    this.set('largeItemsList', this._generateLargeItemList());
  },
  
  reset: function() {
    var page = TestApp.selectFieldViewsPage;
    
    page.setPath('basicSelectField1.value', 'square');
    page.setPath('basicSelectField2.value', 2000);
    page.setPath('emptyOptionSelectField.value', null);
    page.setPath('sortedSelectField.value', 'apple');
    page.setPath('disabledSelectField.value', 'square');
    
    var items = this.get('largeItemsList');
    page.setPath('largeSelectField.value', items[0]);
  },
  
  _generateLargeItemList: function() {
    var items = [];
    
    for (var i = 0; i < 100; i += 1) {
      items.push("item " + i);
    }
    
    return items;
  }
  
});