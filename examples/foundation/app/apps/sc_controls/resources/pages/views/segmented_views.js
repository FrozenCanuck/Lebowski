// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.segmentedViewsPage = SC.Page.design({
  
  resetButton: SC.outlet('mainView.resetButton'),
  
  basic1SegmentedView: SC.outlet('mainView.basicSegmentedView1.segmentedView'),
  
  basic2SegmentedView: SC.outlet('mainView.basicSegmentedView2.segmentedView'),
  
  allowEmptySelectionSegmentedView: SC.outlet('mainView.allowEmptySelection.segmentedView'),
  
  allowMultipleSelectionSegmentedView: SC.outlet('mainView.allowMultipleSelection.segmentedView'),
  
  allowEmptyMultipleSelectionSegmentedView: SC.outlet('mainView.allowEmptyMultipleSelection.segmentedView'),
  
  mainView: SC.View.design({
    layout: { top: 20, bottom: 0, left: 20, right: 20 },
    childViews: [
      'basicSegmentedView1', 
      'basicSegmentedView2', 
      'allowEmptySelection',
      'allowMultipleSelection', 
      'allowEmptyMultipleSelection',
      'disabledSegmentedView',
      'resetButton'
    ],
    
    resetButton: SC.ButtonView.design({
      layout: { top: 0, left: 300, width: 80, height: 24 },
      layerId: 'reset-segmented-views-button',
      title: 'Reset',
      target: TestApp.segmentedViewsController,
      action: 'reset'
    }),
    
    basicSegmentedView1: SC.View.design({
      layout: { top: 0, left: 0, right: 0, height: 25 },
      childViews: 'label segmentedView'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 150, height: 20 },
        value: 'Basic Segmented View 1:'
      }),
      
      segmentedView: SC.SegmentedView.design({
        layerId: 'first-basic-segmented',
        layout: { left: 130, centerY: 0, width: 200, height: 23 },
        items: 'foo bar'.w()
      })
    }),
    
    basicSegmentedView2: SC.View.design({
      layout: { top: 30, left: 0, right: 0, height: 25 },
      childViews: 'label segmentedView'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 150, height: 20 },
        value: 'Basic Segmented View 2:'
      }),
      
      segmentedView: SC.SegmentedView.design({
        layerId: 'second-basic-segmented',
        layout: { left: 130, centerY: 0, width: 200, height: 23 },
        itemTitleKey: 'title',
        itemValueKey: 'value',
        items: [
          { title: 'cat', value: 1 },
          { title: 'dog', value: 2 },
          { title: 'pig', value: 3 }
        ]
      })
    }),
    
    allowEmptySelection: SC.View.design({
      layout: { top: 60, left: 0, right: 0, height: 25 },
      childViews: 'label segmentedView'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 150, height: 20 },
        value: 'Allow Empty Selection:'
      }),
      
      segmentedView: SC.SegmentedView.design({
        layerId: 'allow-empty-segmented',
        layout: { left: 130, centerY: 0, width: 200, height: 23 },
        items: 'cat dog pig'.w(),
        allowsEmptySelection: YES
      })
    }),
    
    allowMultipleSelection: SC.View.design({
      layout: { top: 90, left: 0, right: 0, height: 25 },
      childViews: 'label segmentedView'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 150, height: 20 },
        value: 'Allow Multiple Selection:'
      }),
      
      segmentedView: SC.SegmentedView.design({
        layerId: 'allow-multiple-segmented',
        layout: { left: 130, centerY: 0, width: 200, height: 23 },
        items: 'cat dog pig'.w(),
        value: 'cat',
        allowsMultipleSelection: YES,
        allowsEmptySelection: NO
      })
    }),
    
    allowEmptyMultipleSelection: SC.View.design({
      layout: { top: 120, left: 0, right: 0, height: 25 },
      childViews: 'label segmentedView'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 150, height: 20 },
        value: 'Allow Empty & Multiple:'
      }),
      
      segmentedView: SC.SegmentedView.design({
        layerId: 'allow-empty-multiple-segmented',
        layout: { left: 130, centerY: 0, width: 200, height: 23 },
        items: 'cat dog pig'.w(),
        value: 'cat',
        allowsMultipleSelection: YES,
        allowsEmptySelection: YES
      })
    }),
    
    disabledSegmentedView: SC.View.design({
      layout: { top: 150, left: 0, right: 0, height: 25 },
      childViews: 'label segementedView'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 150, height: 20 },
        value: 'Diabled Segmented View:'
      }),
      
      segementedView: SC.SegmentedView.design({
        layerId: 'disabled-segmented',
        layout: { left: 130, centerY: 0, width: 200, height: 23 },
        items: 'cat dog pig'.w(),
        value: 'dog',
        isEnabled: false
      })
    })
    
  })
});