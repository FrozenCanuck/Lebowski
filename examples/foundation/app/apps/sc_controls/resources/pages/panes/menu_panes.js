// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.menuPanesPage = SC.Page.design({
  
  statusLabel: SC.outlet('mainView.statusLabel'),
  
  shortMenuButton: SC.outlet('mainView.shortMenu'),
  
  longMenuButton: SC.outlet('mainView.longMenu'),

  mainView: SC.View.design({
    layout: { top: 20, bottom: 0, left: 20, right: 20 },
    childViews: 'statusLabel shortMenu longMenu'.w(),
    
    statusLabel: SC.LabelView.design({
      layerId: 'menu-panes-status-label',
      layout: {left: 0, top: 0, right: 0, height: 25 },
      textAlign: SC.ALIGN_LEFT,
      valueBinding: 'TestApp.menuPanesController.status'
    }),
    
    shortMenu: SC.ButtonView.design({
      layout: {left: 0, top: 30, width: 200, height: 25 },
      title: 'Short Menu Pane',
      target: TestApp.menuPanesController,
      action: 'showShortMenuPane'
    }),
    
    longMenu: SC.ButtonView.design({
      layout: {left: 0, top: 60, width: 200, height: 25 },
      title: 'Long Menu Pane',
      target: TestApp.menuPanesController,
      action: 'showLongMenuPane'
    })
  })

});