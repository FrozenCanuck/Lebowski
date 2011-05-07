// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.menuPanesController = SC.ObjectController.create({
  
  status: '--',
  
  showShortMenuPane: function(view) {
    var controller = this;
    
    var items = [
      { 
        title: 'Menu item 1', 
        isEnabled: true, 
        target: this,
        action: 'clickedMenuItem'
      },
      { 
        title: 'Menu item 2', 
        isEnabled: true, 
        target: this,
        action: 'clickedMenuItem'
      },
      {
        separator: true
      },
      { 
        title: 'Menu item 3', 
        isEnabled: true, 
        checkbox: true,
        target: this,
        action: 'clickedMenuItem'
      }
    ];
    
    var anchor = TestApp.getPath('mainPage.menuPaneButton');
    SC.MenuPane.create({
      layout: { width: 200 },
      items: items,
      itemTitleKey: 'title',
      itemValueKey: 'title',
      itemActionKey: 'action'
    }).popup(view);
    this.set('status', 'Opened SC.MenuPane');
  },
  
  showLongMenuPane: function(view) {
    var controller = this;
    
    var items = [];
    
    for (var i = 0; i < 100; i += 1) {
      items.push({ 
        title: 'Menu item ' + i, 
        isEnabled: true, 
        target: this,
        action: 'clickedMenuItem'
      });
    }
    
    var anchor = TestApp.getPath('mainPage.menuPaneButton');
    SC.MenuPane.create({
      layout: { width: 200 },
      items: items,
      itemTitleKey: 'title',
      itemValueKey: 'title',
      itemActionKey: 'action'
    }).popup(view);
    this.set('status', 'Opened SC.MenuPane');
  },
  
  
  clickedMenuItem: function(pane) {
    this.set('status', 'Clicked %@'.fmt(pane.getPath('selectedItem.title')));
  }
  
});