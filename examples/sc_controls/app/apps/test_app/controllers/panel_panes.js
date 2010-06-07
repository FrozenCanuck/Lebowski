/*globals TestApp */

TestApp.panelPanesController = SC.ObjectController.create({
  
  modalPaneView: SC.View.extend({
    layout: { left: 0, right: 0, top: 0, bottom: 0 },
    childViews: 'close'.w(),
    
    close: SC.ButtonView.design({
      layout: { width: 200, height: 25, centerX: 0, centerY: 0 },
      title: 'Close Panel Pane',
      action: function() {
        var pane = this.get('pane');
        TestApp.panelPanesController.set('status', 'Closed panel pane');
        pane.remove();
      }
    })
  }),
  
  status: '--',
  
  showPanelPane: function() {
    SC.PanelPane.create({
      layout: { width: 400, height: 200, centerX: 0, centerY: 0 },
      contentView: this.modalPaneView
    }).append();
    this.set('message', 'Opened SC.PanelPane');
  }
  
});