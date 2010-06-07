// ==========================================================================
// Project:   TestApp - mainPage
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals TestApp */

TestApp.selectFieldViewsPage = SC.Page.design({
  
  mainView: SC.View.design({
    layout: { top: 20, bottom: 0, left: 20, right: 20 },
    childViews: 'basicSelectField1 basicSelectField2 emptyOptionSelectField sortedSelectField disabledSelectField'.w(),
    
    basicSelectField1: SC.View.design({
      layout: { top: 0, left: 0, right: 0, height: 25 },
      childViews: 'label selectField'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 150, height: 20 },
        value: 'Basic Select Field 1:'
      }),
      
      selectField: SC.SelectFieldView.design({
        layerId: 'first-basic-select-field',
        layout: { left: 130, centerY: 0, width: 100, height: 23 },
        objects: ['square', 'circle', 'triangle'],
        value: 'square'
      })
    }),
    
    basicSelectField2: SC.View.design({
      layout: { top: 30, left: 0, right: 0, height: 25 },
      childViews: 'label selectField'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 150, height: 20 },
        value: 'Basic Select Field 2:'
      }),
      
      selectField: SC.SelectFieldView.design({
        layerId: 'second-basic-select-field',
        layout: { left: 130, centerY: 0, width: 100, height: 23 },
        objects: [
          { name: 'square', value: 1000 },
          { name: 'circle', value: 2000 },
          { name: 'triangle', value: 3000 }
        ],
        nameKey: 'name',
        valueKey: 'value',
        value: 2000
      })
    }),
    
    emptyOptionSelectField: SC.View.design({
      layout: { top: 60, left: 0, right: 0, height: 25 },
      childViews: 'label selectField'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 150, height: 20 },
        value: 'Empty Field:'
      }),
      
      selectField: SC.SelectFieldView.design({
        layerId: 'empty-option-select-field',
        layout: { left: 130, centerY: 0, width: 100, height: 23 },
        objects: ['square', 'circle', 'triangle'],
        emptyName: 'empty',
        value: "***"
      })
    }),
    
    sortedSelectField: SC.View.design({
      layout: { top: 90, left: 0, right: 0, height: 25 },
      childViews: 'label selectField'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 150, height: 20 },
        value: 'Sorted Fields:'
      }),
      
      selectField: SC.SelectFieldView.design({
        layerId: 'sorted-select-field',
        layout: { left: 130, centerY: 0, width: 100, height: 23 },
        objects: [
          { item: 'zebra' },
          { item: 'cat' },
          { item: 'apple' },
          { item: 'kite' }
        ],
        nameKey: 'item',
        sortKey: 'item',
        valueKey: 'item',
        value: 'apple'
      })
    }),
    
    disabledSelectField: SC.View.design({
      layout: { top: 120, left: 0, right: 0, height: 25 },
      childViews: 'label selectField'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 150, height: 20 },
        value: 'Disabled Select Field:'
      }),
      
      selectField: SC.SelectFieldView.design({
        layerId: 'disabled-select-field',
        layout: { left: 130, centerY: 0, width: 100, height: 23 },
        objects: ['square', 'circle', 'triangle'],
        value: 'square',
        isEnabled: false
      })
    })
  })
  
});