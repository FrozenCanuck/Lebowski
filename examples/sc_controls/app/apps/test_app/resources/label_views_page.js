// ==========================================================================
// Project:   TestApp - mainPage
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals TestApp */

TestApp.labelViewsPage = SC.Page.design({
  
  mainView: SC.View.design({
    layout: { top: 20, bottom: 0, left: 20, right: 20 },
    childViews: 'basicLabel editableLabel'.w(),
    
    basicLabel: SC.View.design({
      layout: { top: 0, left: 0, right: 0, height: 25 },
      childViews: 'label fooButton barButton'.w(),
      
      label: SC.LabelView.design({
        layerId: 'basic-label',
        layout: { top: 0, left: 0, width: 100, height: 25 },
        backgroundColor: 'green',
        valueBinding: 'TestApp.labelControlsController.caption',
        textAlign: SC.ALIGN_CENTER
      }),
      
      fooButton: SC.ButtonView.design({
        layerId: 'basic-label-foo-button',
        layout: { top: 0, left: 110, width: 100, height: 25 },
        title: 'foo',
        target: TestApp.labelControlsController,
        action: 'actionFoo'
      }),
      
      barButton: SC.ButtonView.design({
        layerId: 'basic-label-bar-button',
        layout: { top: 0, left: 220, width: 100, height: 25 },
        title: 'bar',
        target: TestApp.labelControlsController,
        action: 'actionBar'
      })
      
    }),
    
    editableLabel: SC.LabelView.design({
      layerId: 'editable-label',
      layout: { top: 30, left: 0, width: 200, height: 25 },
      backgroundColor: 'green',
      value: 'Edit Me',
      isEditable: YES
    })
  })
  
});