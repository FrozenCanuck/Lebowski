// ==========================================================================
// Project:   TestApp - mainPage
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals TestApp */

TestApp.containerViewsPage = SC.Page.design({
  
  mainView: SC.View.design({
    layout: { top: 20, bottom: 0, left: 20, right: 20 },
    childViews: 'header container'.w(),
    
    header: SC.View.design({
      layout: { top: 0, centerX: 0, width: 500, height: 25 },
      childViews: 'emptyButton view1Button view2Button'.w(),
      
      emptyButton: SC.ButtonView.design({
        layerId: 'container-view-empty-button',
        layout: { top: 0, bottom: 0, left: 0, width: 150 },
        title: 'Empty Container',
        target: TestApp.containerControlsController,
        action: 'showEmptyContainer'
      }),
      
      view1Button: SC.ButtonView.design({
        layerId: 'container-view-show-view1-button',
        layout: { top: 0, bottom: 0, centerX: 0, width: 150 },
        title: 'Show View 1',
        target: TestApp.containerControlsController,
        action: 'showView1'
      }),
      
      view2Button: SC.ButtonView.design({
        layerId: 'container-view-show-view2-button',
        layout: { top: 0, bottom: 0, right: 0, width: 150 },
        title: 'Show View 2',
        target: TestApp.containerControlsController,
        action: 'showView2'
      })
    }),
    
    container: SC.ContainerView.design({
      layerId: 'basic-container',
      layout: { top: 40, left: 0, right: 0, bottom: 0 },
      nowShowingBinding: 'TestApp.containerControlsController.nowShowing'
    })
    
  }),
  
  view1: SC.View.design({
    layerId: 'view1-container-test-view',
    layout: { top: 0, bottom: 0, left: 0, right: 0 },
    childViews: 'label'.w(),
    backgroundColor: 'green',
    
    label: SC.LabelView.design({
      layout: { height: 25, left: 0, right: 0, centerY: 0 },
      value: 'Showing View 1',
      textAlign: SC.ALIGN_CENTER
    })
  }),
  
  view2: SC.View.design({
    layerId: 'view2-container-test-view',
    layout: { top: 0, bottom: 0, left: 0, right: 0 },
    childViews: 'label'.w(),
    backgroundColor: 'blue',
    
    label: SC.LabelView.design({
      layout: { height: 25, left: 0, right: 0, centerY: 0 },
      value: 'Showing View 2',
      textAlign: SC.ALIGN_CENTER
    })
  })
  
});