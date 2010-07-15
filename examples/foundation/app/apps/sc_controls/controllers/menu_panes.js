// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.menuPanesController = SC.ObjectController.create({
  
  status: '--',
  
  showMenuPane: function(view) {
    var controller = this;
    
    var subMenuItems = [
      {
        title: 'Sub item 1',
        isEnabled: true, 
        target: this,
        action: 'clickedMenuItem'
      },
      {
        title: 'Sub item 2',
        isEnabled: true, 
        target: this,
        action: 'clickedMenuItem' 
      }
    ];
    
    var subMenu = SC.MenuPane.create({
      layout: { width: 200 },
      items: subMenuItems
    });
    
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
      // TODO: Put back in menu item after figuring out how submenus work in SproutCore.
      //       There is some unique behavior when working menu panes and trying to click
      //       a menu item in a sub menu pane
      // ,
      // { 
      //   title: 'Menu item 4', 
      //   isEnabled: true,
      //   subMenu: subMenu,
      //   branchItem: true  
      // }
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
  
  clickedMenuItem: function(menuItem, pane) {
    this.set('status', 'Clicked %@'.fmt(menuItem.getPath('content.title')));
  }
  
});