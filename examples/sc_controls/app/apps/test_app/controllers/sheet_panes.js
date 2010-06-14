// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.sheetPanesController = SC.ObjectController.create({
  
  modalPaneView: SC.View.extend({
    layout: { left: 0, right: 0, top: 0, bottom: 0 },
    childViews: 'close'.w(),
    
    close: SC.ButtonView.design({
      layout: { width: 200, height: 25, centerX: 0, centerY: 0 },
      title: 'Close Sheet Pane',
      action: function() {
        var pane = this.get('pane');
        TestApp.sheetPanesController.set('status', 'Closed sheet pane');
        pane.remove();
      }
    })
  }),
  
  status: '--',
  
  showSheetPane: function() {
    SC.SheetPane.create({
      layout: { width: 400, height: 200, centerX: 0 },
      contentView: this.modalPaneView
    }).append();
    this.set('status', 'Opened SC.SheetPane');
  }
  
});