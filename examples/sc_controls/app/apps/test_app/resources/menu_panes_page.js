// ==========================================================================
// Project:   TestApp - mainPage
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals TestApp */

TestApp.menuPanesPage = SC.Page.design({

  mainView: SC.View.design({
    layout: { top: 20, bottom: 0, left: 20, right: 20 },
    childViews: 'statusLabel basicMenu'.w(),
    
    statusLabel: SC.LabelView.design({
      layerId: 'menu-panes-status-label',
      layout: {left: 0, top: 0, right: 0, height: 25 },
      textAlign: SC.ALIGN_LEFT,
      valueBinding: 'TestApp.menuPanesController.status'
    }),
    
    basicMenu: SC.ButtonView.design({
      layerId: 'basic-menu-pane',
      layout: {left: 0, top: 30, width: 200, height: 25 },
      title: 'Basic Menu Pane',
      target: TestApp.menuPanesController,
      action: 'showMenuPane'
    })
  })

});