// ==========================================================================
// Project:   TestApp - mainPage
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals TestApp */

TestApp.mainPage = SC.Page.design({

  mainPane: SC.MainPane.design({
    childViews: 'mainView'.w(),
    
    mainView: SC.View.design({
      childViews: 'controlsListView containerView'.w(),
      
      controlsListView: SC.ScrollView.design({
        layout: { top: 0, bottom: 0, left: 0, width: 200 },
        contentView: SC.SourceListView.design({
          layerId: 'controls-list',
          contentBinding: 'TestApp.controlsListController.arrangedObjects',
          selectionBinding: 'TestApp.controlsListController.selection',
          isEditable: NO,
          contentValueKey: 'name',
          treeItemIsGrouped: NO,
          target: TestApp.controlsListController,
          action: 'controlItemSelected',
          selectOnMouseDown: YES
        })
      }),

      containerView: SC.ContainerView.design({
        layerId: 'control-container',
        layout: { top: 0, bottom: 0, left: 200, right: 0 },
        nowShowing: 'TestApp.mainPage.blankView'
      })
    })
    
  }),
  
  controlContainerView: SC.outlet('mainPane.mainView.containerView'),
  
  blankView: SC.View.design({
    layout: { top: 0, bottom: 0, left: 0, right: 0 }
  })

});
