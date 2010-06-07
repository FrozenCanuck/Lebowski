// ==========================================================================
// Project:   TestApp - mainPage
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals TestApp */

TestApp.checkboxViewsPage = SC.Page.design({
  
  mainView: SC.View.design({
    layout: { top: 20, bottom: 0, left: 20, right: 20 },
    childViews: 'checkbox disabledCheckbox mixedStateCheckbox'.w(),
    
    checkbox: SC.View.design({
      layout: { top: 0, left: 0, right: 0, height: 25 },
      childViews: 'checkbox'.w(),
      
      checkbox: SC.CheckboxView.design({
        layerId: 'basic-checkbox',
        layout: { left: 0, centerY: 0, width: 100, height: 23 },
        title: 'Checkbox'
      })
    }),
    
    disabledCheckbox: SC.View.design({
      layout: { top: 30, left: 0, right: 0, height: 25 },
      childViews: 'checkbox'.w(),
    
      checkbox: SC.CheckboxView.design({
        layerId: 'disabled-checkbox',
        layout: { left: 0, centerY: 0, width: 100, height: 23 },
        title: 'Disabled',
        value: YES,
        isEnabled: NO
      })
    }),
    
    mixedStateCheckbox: SC.View.design({
      layout: { top: 60, left: 0, right: 0, height: 25 },
      childViews: 'checkbox resetButton'.w(),
    
      checkbox: SC.CheckboxView.design({
        layerId: 'mixed-state-checkbox',
        layout: { left: 0, centerY: 0, width: 100, height: 23 },
        title: 'Mixed State',
        value: [YES, NO],
        valueBinding: 'TestApp.checkboxControlsController.checkbox3'
      }),
      
      resetButton: SC.ButtonView.design({
        layerId: 'reset-mixed-state-checkbox-button',
        layout: { left: 110, centerY: 0, width: 100, height: 23 },
        title: 'Reset',
        target: TestApp.checkboxControlsController,
        action: 'resetMixedStateCheckbox'
      })
    })
  })
  
});