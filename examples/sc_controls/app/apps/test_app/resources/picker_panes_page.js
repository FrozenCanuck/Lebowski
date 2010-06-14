// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.pickerPanesPage = SC.Page.design({

  mainView: SC.View.design({
    layout: { top: 20, bottom: 0, left: 20, right: 20 },
    childViews: 'statusLabel pickerPanes'.w(),
    
    statusLabel: SC.LabelView.design({
      layerId: 'picker-panes-status-label',
      layout: {left: 0, top: 0, right: 0, height: 25 },
      textAlign: SC.ALIGN_LEFT,
      valueBinding: 'TestApp.pickerPanesController.status'
    }),
    
    pickerPanes: SC.View.design({
      layout: {left: 0, top: 30, left: 0, bottom: 0 },
      childViews: 'menuPicker pointerPicker'.w(),
      
      menuPicker: SC.ButtonView.design({
        layerId: 'menu-picker',
        layout: {left: 0, top: 0, width: 200, height: 25 },
        title: 'SC.PickerPane - Menu',
        target: TestApp.pickerPanesController,
        action: 'showPickerPaneMenu'
      }),
      
      pointerPicker: SC.ButtonView.design({
        layerId: 'pointer-picker',
        layout: {left: 0, top: 30, width: 200, height: 25 },
        title: 'SC.PickerPane - Pointer',
        target: TestApp.pickerPanesController,
        action: 'showPickerPanePointer'
      })
    })
    
  })

});