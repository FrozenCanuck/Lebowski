// ==========================================================================
// Project:   TestApp - mainPage
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals TestApp */

TestApp.palettePanesPage = SC.Page.design({

  mainView: SC.View.design({
    layout: { top: 20, bottom: 0, left: 20, right: 20 },
    childViews: 'statusLabel createPalettePane resetPaletteIdCounter anchors'.w(),
    
    statusLabel: SC.LabelView.design({
      layerId: 'palette-panes-status-label',
      layout: {left: 0, top: 0, right: 0, height: 25 },
      textAlign: SC.ALIGN_LEFT,
      valueBinding: 'TestApp.palettePanesController.status'
    }),
    
    createPalettePane: SC.ButtonView.design({
      layerId: 'create-palette',
      layout: {left: 0, top: 30, width: 200, height: 25 },
      title: 'Create Palette Pane',
      target: TestApp.palettePanesController,
      action: 'createPalettePane'
    }),
    
    resetPaletteIdCounter: SC.ButtonView.design({
      layerId: 'reset-palette-id-counter',
      layout: {left: 210, top: 30, width: 200, height: 25 },
      title: 'Reset ID Counter',
      target: TestApp.palettePanesController,
      action: 'resetPalettePaneIdCounter'
    }),
    
    anchors: SC.View.design({
      layerId: 'palette-anchors',
      layout: {left: 0, top: 60, right: 0, bottom: 0 },
      childViews: 'anchor1 anchor2 anchor3'.w(),
      
      anchor1: SC.View.design({
        layerId: 'palette-anchor-1',
        layout: { left: 0, top: 0, width: 20, height: 20 },
        backgroundColor: 'red' 
      }),
      
      anchor2: SC.View.design({
        layerId: 'palette-anchor-2',
        layout: { left: 100, top: 30, width: 20, height: 20 },
        backgroundColor: 'red' 
      }),
      
      anchor3: SC.View.design({
        layerId: 'palette-anchor-3',
        layout: { left: 220, top: 60, width: 20, height: 20 },
        backgroundColor: 'red' 
      })
    })
    
  })

});