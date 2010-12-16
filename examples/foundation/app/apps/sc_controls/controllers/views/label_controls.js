// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp Core */

TestApp.labelControlsController = SC.Object.create({
  
  caption: null,
  
  actionFoo: function() {
    this.set('caption', 'foo');
  },
  
  actionBar: function() {
    this.set('caption', 'bar');
  },
  
  reset: function() {
    var page = TestApp.get('labelViewsPage'), view;
    
    view = page.get('basicLabel');
    view.set('value', "");
    
    view = page.get('editableLabel');
    view.discardEditing();
    view.set('value', "Edit Me");
  }
  
});