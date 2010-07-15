// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.pickerPanesController = SC.ObjectController.create({
  
  status: '--',
  
  modalPaneView: SC.View.extend({
    layout: { left: 0, right: 0, top: 0, bottom: 0 },
    childViews: 'close'.w(),
    
    close: SC.ButtonView.design({
      layout: { width: 200, height: 25, centerX: 0, centerY: 0 },
      title: 'Close Palette Pane',
      action: function() {
        var pane = this.get('pane');
        var paneType = SC._object_className(pane.constructor);
        TestApp.pickerPanesController.set('status', 'Closed %@'.fmt(paneType));
        pane.remove();
      }
    })
  }),
  
  showPickerPaneMenu: function(view) {
    this.showPickerPane(view, SC.PICKER_MENU);
    this.set('status', 'Opened SC.PickerPane - Menu');
  },
  
  showPickerPanePointer: function(view) {
    this.showPickerPane(view, SC.PICKER_POINTER);
    this.set('status', 'Opened SC.PickerPane - Picker');
  },
  
  showPickerPane: function(anchor, type) {
    SC.PickerPane.create({
      layout: { width: 400, height: 200 },
      contentView: this.modalPaneView
    }).popup(anchor, type);
  }
  
});