// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.listViewsPage = SC.Page.design({
  
  mainView: SC.View.design({
    layout: { top: 20, bottom: 0, left: 20, right: 20 },
    childViews: 'header firstEmployeeList secondEmployeeList thirdEmployeeList'.w(),
    
    header: SC.View.design({
      layerId: 'header',
      layout: { top: 0, left: 0, right: 0, height: 25 },
      childViews: 'caption status'.w(),
      
      caption: SC.LabelView.design({
        layout: { top: 0, left: 0, bottom: 0, width: 50 },
        value: 'Status:'
      }),
      
      status: SC.LabelView.design({
        layerId: 'list-status-label',
        layout: { top: 0, left: 55, right: 0, bottom: 0 },
        valueBinding: SC.Binding.oneWay('TestApp.firstEmployeeListController.status')
      })
    }),
    
    firstEmployeeList: SC.ScrollView.design({
      layout: { top: 40, left: 0, height: 150, width: 300 },
      contentView: SC.ListView.design({
        layerId: 'first-employee-list',
        layout: { top: 0, bottom: 0, right: 0, left: 0 },
        contentBinding: 'TestApp.firstEmployeeListController',
        selectionBinding: 'TestApp.firstEmployeeListController.selection',
        target: TestApp.firstEmployeeListController,
        action: 'itemAction',
        delegate: TestApp.firstEmployeeListController,
        canReorderContent: YES,
        allowDeselectAll: YES,
        canDeleteContent: YES,
        canEditContent: YES,
        isEditable: YES,
        contentValueKey: 'summary',
        contentCheckboxKey: 'active'
      })
    }),
    
    secondEmployeeList: SC.ScrollView.design({
      layout: { top: 40, left: 310, height: 150, width: 300 },
      contentView: SC.ListView.design({
        layerId: 'second-employee-list',
        layout: { top: 0, bottom: 0, right: 0, left: 0 },
        contentBinding: 'TestApp.secondEmployeeListController',
        selectionBinding: 'TestApp.secondEmployeeListController.selection',
        target: TestApp.secondEmployeeListController,
        action: 'itemAction',
        delegate: TestApp.secondEmployeeListController,
        canReorderContent: YES,
        allowDeselectAll: YES,
        canDeleteContent: YES,
        canEditContent: YES,
        isEditable: YES,
        isDropTarget: YES,
        hasContentIcon: YES,
        hasContentRightIcon: NO,
        contentIconKey: 'icon',
        contentRightIconKey: 'right-icon',
        contentValueKey: 'summary'
      })
    }),
    
    thirdEmployeeList: SC.ScrollView.design({
      layout: { top: 200, left: 0, height: 150, width: 300 },
      contentView: SC.ListView.design({
        layerId: 'third-employee-list',
        layout: { top: 0, bottom: 0, right: 0, left: 0 },
        contentBinding: 'TestApp.thirdEmployeeListController.arrangedObjects',
        selectionBinding: 'TestApp.thirdEmployeeListController.selection',
        target: TestApp.thirdEmployeeListController,
        action: 'itemAction',
        delegate: TestApp.thirdEmployeeListController,
        canReorderContent: NO,
        allowDeselectAll: YES,
        canDeleteContent: NO,
        canEditContent: NO,
        isEditable: NO,
        contentValueKey: 'summary',
        treeItemIsGrouped: NO
      })
    })
    
  })
  
});