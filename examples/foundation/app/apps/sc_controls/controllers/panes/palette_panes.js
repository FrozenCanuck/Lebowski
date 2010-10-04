// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.palettePanesController = SC.ObjectController.create({
  
  status: '--',
  
  palettePaneView: SC.View.extend({
    layout: { left: 0, right: 0, top: 0, bottom: 0 },
    childViews: 'group'.w(),
    
    group: SC.View.design({
      layout: { width: 200, height: 100, centerX: 0, centerY: 0 },
      childViews: 'label close'.w(),
    
      label: SC.LabelView.design({
        layout: { height: 25, top: 0, left: 0, right: 0 },
        textAlign: SC.ALIGN_CENTER,
        value: null
      }),
      
      close: SC.ButtonView.design({
        layout: { height: 25, left: 0, right: 0, bottom: 0 },
        title: 'Close Pane',
        action: function() {
          var pane = this.get('pane');
          var paneType = SC._object_className(pane.constructor);
          TestApp.palettePanesController.set('status', 'Closed %@ - ID = %@'.fmt(paneType, pane.id));
          pane.remove();
        }
      })
    })
  }),
  
  createPalettePane: function() {
    if (SC.none(this.nextPalettePaneId)) {
      this.nextPalettePaneId = 0;
    } else {
      this.nextPalettePaneId = this.nextPalettePaneId + 1;
    }
    
    var pane = SC.PalettePane.create({
      id: this.nextPalettePaneId,
      layout: { width: 400, height: 200, right: 0, top: 0 },
      contentView: this.palettePaneView
    });
    pane.setPath('contentView.group.label.value', 'ID = %@'.fmt(this.nextPalettePaneId));
    pane.append();
    this.set('status', 'Created a SC.PalettePane - ID = %@'.fmt(this.nextPalettePaneId));
  },
  
  resetPalettePaneIdCounter: function() {
    this.nextPalettePaneId = null;
  }
  
});