// ==========================================================================
// Project:   TestApp - mainPage
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals TestApp */

TestApp.sheetPanesPage = SC.Page.design({

  mainView: SC.View.design({
    layout: { top: 20, bottom: 0, left: 20, right: 20 },
    childViews: 'statusLabel showSheetPane'.w(),
    
    statusLabel: SC.LabelView.design({
      layerId: 'sheet-panes-status-label',
      layout: {left: 0, top: 0, right: 0, height: 25 },
      textAlign: SC.ALIGN_LEFT,
      valueBinding: 'TestApp.sheetPanesController.status'
    }),
    
    showSheetPane: SC.ButtonView.design({
      layerId: 'show-sheet-pane',
      layout: {left: 0, top: 30, width: 200, height: 25 },
      title: 'Show Sheet Pane',
      target: TestApp.sheetPanesController,
      action: 'showSheetPane'
    })
  })

});