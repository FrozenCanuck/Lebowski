// ==========================================================================
// Project:   TestApp - mainPage
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals TestApp */

TestApp.panelPanesPage = SC.Page.design({

  mainView: SC.View.design({
    layout: { top: 20, bottom: 0, left: 20, right: 20 },
    childViews: 'statusLabel showPanelPane'.w(),
    
    statusLabel: SC.LabelView.design({
      layerId: 'panel-panes-status-label',
      layout: {left: 0, top: 0, right: 0, height: 25 },
      textAlign: SC.ALIGN_LEFT,
      valueBinding: 'TestApp.panelPanesController.status'
    }),
    
    showPanelPane: SC.ButtonView.design({
      layerId: 'show-panel-pane',
      layout: {left: 0, top: 30, width: 200, height: 25 },
      title: 'Show Panel Pane',
      target: TestApp.panelPanesController,
      action: 'showPanelPane'
    })
  })

});